require 'builder'

module Arbetsformedlingen
  class OutputBuilder
    def initialize(packet)
      @packet = packet
    end

    def to_xml
      # TODO: Set option so that åäö isn't encoded
      builder = Builder::XmlMarkup.new(indent: 2)
      append_envelope(builder, @packet.to_h)
    end

    private

    def append_envelope(builder, packet_data)
      document = packet_data.fetch(:document)

      builder.Envelope(
        xmlns: 'http://arbetsformedlingen.se/LedigtArbete',
        version: '0.52'
      ) do |envelope|
        append_sender(envelope, document)
        append_transaction_info(envelope, document)
        append_packet(envelope, packet_data)
      end
    end

    def append_sender(envelope, document)
      envelope.Sender(id: document.fetch(:customer_id), email: document.fetch(:email))
    end

    def append_transaction_info(envelope, document)
      envelope.TransactInfo(timeStamp: document.fetch(:timestamp)) do |ti|
        ti.TransactId(document.fetch(:id))
      end
    end

    def append_packet(envelope, packet_data)
      envelope.Packet do |pack|
        pack.PacketInfo { |pi| pi.PacketId(packet_data.fetch(:id)) }
        pack.Payload { |payload| append_job_position(payload, packet_data) }
      end
    end

    def append_job_position(payload, packet_data)
      payload.JobPositionPosting(status: "#{'in' unless packet_data.fetch(:active)}active") do |pos|
        cin = packet_data[:position][:company].fetch(:cin_arbetsformedlingen)
        job_pos_id = "#{cin}-#{packet_data.fetch(:job_id)}"
        pos.JobPositionPostingId(job_pos_id)

        append_hiring_org(payload, packet_data)
        append_post_detail(payload, packet_data)
        position = packet_data.fetch(:position)
        append_job_position_info(payload, position)
        append_how_to_apply(payload, position)

        pos.NumberToFill(packet_data.fetch(:number_to_fill))

        pos.JPPExtension do |jpp|
          company = position.fetch(:company)
          jpp.HiringOrgDescription(company.fetch(:description))
          jpp.OccupationGroup(code: packet_data.fetch(:ssyk_id), codename: 'OccupationNameID')
        end
      end
    end

    def append_how_to_apply(node, position)
      node.HowToApply(distribute: 'external') do |how_to|
        how_to.ApplicationMethods do |methods|
          methods.ByWeb do |by_web|
            method = position.fetch(:application_method)
            by_web.URL(method.fetch(:url))
            by_web.SummaryText(method.fetch(:summary))
          end
        end
      end
    end

    def append_hiring_org(payload, packet_data)
      company = packet_data.dig(:position, :company)

      payload.HiringOrg do |org|
        org.HiringOrgName(company.fetch(:name))
        org.HiringOrgId(company.fetch(:cin_arbetsformedlingen), idOwner: company.fetch(:cin))
        append_company_contact(org, company)
      end
    end

    def append_company_contact(node, company)
      data = company.fetch(:address)
      node.Contact do |contact|
        contact.PostalAddress do |address|
          address.PostalCode(data.fetch(:zip))
          address.Municipality(data.fetch(:municipality))
          append_delivery_address(node, data)
        end
      end
    end

    def append_post_detail(node, packet_data)
      publication = packet_data.fetch(:publication)

      node.PostDetail do |detail|
        if publication[:publish_at]
          detail.StartDate { |n| n.Date(publication.fetch(:publish_at)) }
        end
        detail.EndDate { |n| n.Date(publication.fetch(:unpublish_at)) }

        detail.PostedBy do |posted|
          posted.Contact do |contact|
            contact.PersonName { |pn| pn.FormattedName(publication.fetch(:name)) }
            contact.tag!('E-mail', publication.fetch(:email))
          end
        end
      end
    end

    def append_job_position_info(node, position)
      node.JobPositionInformation do |job_pos|
        job_pos.JobPositionTitle(position.fetch(:title))
        append_job_position_description(job_pos, position)
        append_job_position_requirements(job_pos, position)
      end
    end

    def append_job_position_requirements(node, position)
      node.JobPositionRequirements do |job_pos_req|
        position.fetch(:qualifications).each do |qualification|
          if qualification.fetch(:required)
            job_pos_req.QualificationsRequired do |req_qual|
              append_inner_qualification(req_qual, qualification)
            end
          else
            job_pos_req.QualificationsPreferred do |req_qual|
              append_inner_qualification(req_qual, qualification)
            end
          end
        end
      end
    end

    def append_inner_qualification(node, qualification)
      q = qualification

      node.P(q.fetch(:summary)) unless q.fetch(:summary, '').empty?

      unless q[:experience].nil?
        node.Qualification(type: 'experience', yearsOfExperience: q.fetch(:experience))
      end

      if q[:drivers_license] && !q[:drivers_license].empty?
        node.Qualification(
          type: 'license',
          description: 'DriversLicense',
          category: q.fetch(:drivers_license)
        )
      end

      node.Qualification(type: 'equipment', description: 'Car') if q[:car]
    end

    def append_job_position_description(node, position)
      node.JobPositionDescription do |job_pos_desc|
        job_pos_desc.JobPositionPurpose(position.fetch(:purpose))
        job_pos_desc.JobPositionLocation do |job_pos_loc|
          append_job_position_address(job_pos_loc, position.fetch(:address))
        end
        job_pos_desc.Classification do |classification|
          append_schedule(classification, position.fetch(:schedule))
        end
        job_pos_desc.CompensationDescription do |comp_desc|
          salary = position.fetch(:salary)
          comp_desc.Pay do |pay|
            pay.SalaryMonthly(salary.fetch(:type), currency: salary.fetch(:currency))
          end
          comp_desc.SummaryText(salary.fetch(:summary))
        end
      end
    end

    def append_schedule(node, schedule)
      node.Schedule do |sch|
        if schedule.fetch(:full_time)
          sch.FullTime('')
        else
          sch.PartTime('')
        end
        sch.SummaryText(schedule.fetch(:summary))
      end

      node.Duration do |dur|
        if schedule.fetch(:full_time)
          dur.Regular('')
        else
          dur.Temporary { |t| t.TermLength(schedule.fetch(:position_duration_code)) }
        end
        dur.SummaryText(schedule.fetch(:summary))
      end
    end

    def append_delivery_address(node, data)
      return node unless data.key?(:full_address) || data.key?(:street)

      node.DeliveryAddress do |d_address|
        d_address.AddressLine(data.fetch(:full_address)) if data.key?(:full_address)
        d_address.StreetName(data.fetch(:street)) if data.key?(:street)
      end
    end

    def append_job_position_address(node, address)
      node.PostalAddress do |a_node|
        a_node.CountryCode('SE')
        a_node.PostalCode(address.fetch(:zip)) if address.key?(:zip)
        a_node.Municipality(address.fetch(:municipality))
        append_delivery_address(a_node, address)
      end

      node.LocationSummary do |loc_sum|
        loc_sum.Municipality(address.fetch(:municipality))
        loc_sum.CountryCode(address.fetch(:country_code))
      end
    end
  end
end
