module Arbetsformedlingen
  module Platsannonser
    module Values
      Ad = KeyStruct.new(
        :id,
        :url,
        :title,
        :body,
        :occupation,
        :occupation_id,
        :published_at,
        :total_vacancies,
        :municipalities,
        :municipality_id,
        :total_vacancies_with_visa,
        :employment_type,
        :terms,
        :application,
        :workplace,
        :requirements
      )
      class Ad
        def to_h
          hash = super.to_h
          hash[:terms] = hash[:terms].to_h
          hash[:application] = hash[:application].to_h
          hash[:workplace] = hash[:workplace].to_h
          hash[:requirements] = hash[:requirements].to_h
          hash
        end
      end

      Terms = KeyStruct.new(
        :duration,
        :working_hours,
        :working_hours_description,
        :salary_type,
        :salary_form
      )

      Application = KeyStruct.new(
        :reference,
        :application_url,
        :email,
        :last_application_at,
        :application_comment
      )

      Workplace = KeyStruct.new(
        :name,
        :postal,
        :country,
        :visit_address,
        :logotype_url,
        :website,
        :contacts
      )
      class Workplace
        def to_h
          data = super.to_h
          data[:postal] = data[:postal].to_h
          data
        end
      end

      Postal = KeyStruct.new(:code, :address, :city, :country)
      Requirements = KeyStruct.new(:own_car)
    end
  end
end
