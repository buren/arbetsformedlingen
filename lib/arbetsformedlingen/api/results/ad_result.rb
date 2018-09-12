# frozen_string_literal: true

require 'arbetsformedlingen/api/values/ad_result_values'

module Arbetsformedlingen
  module API
    module AdResult
      # Build API result object for ad result
      # @param [API::Response] response
      # @return [Values::Ad]
      def self.build(response)
        return build_empty(response) unless response.success?

        build_page(response)
      end

      # private

      def self.build_page(response)
        response_data = response.json
        data = response_data.fetch('platsannons')
        ad_data = data.fetch('annons')

        Values::Ad.new(
          id: ad_data.fetch('annonsid'),
          url: ad_data.fetch('platsannonsUrl'),
          title: ad_data.fetch('annonsrubrik'),
          body: ad_data.fetch('annonstext'),
          occupation: ad_data.fetch('yrkesbenamning'),
          occupation_id: ad_data.fetch('yrkesid'),
          published_at: ad_data.fetch('publiceraddatum'),
          total_vacancies: ad_data.fetch('antal_platser'),
          municipalities: ad_data.fetch('kommunnamn'),
          municipality_id: ad_data.fetch('kommunkod'),
          total_vacancies_with_visa: ad_data.fetch('antalplatserVisa'),
          employment_type: ad_data.fetch('anstallningstyp'),
          terms: build_terms(data.fetch('villkor')),
          application: build_application(data.fetch('ansokan')),
          workplace: build_workplace(data.fetch('arbetsplats')),
          requirements: build_requirements(data.fetch('krav')),
          response: response
        )
      end

      def self.build_empty(response)
        Values::Ad.new(response: response)
      end

      def self.build_terms(data)
        Values::Terms.new(
          duration: data.fetch('varaktighet', nil),
          working_hours: data.fetch('arbetstid', nil),
          working_hours_description: data.fetch('arbetstidvaraktighet', nil),
          salary_type: data.fetch('lonetyp'),
          salary_form: data.fetch('loneform', nil)
        )
      end

      def self.build_application(data)
        Values::Application.new(
          reference: data['referens'],
          application_url: data.fetch('webbplats', nil),
          email: data['epostadress'],
          last_application_at: data.fetch('sista_ansokningsdag', nil),
          application_comment: data.fetch('ovrigt_om_ansokan', nil)
        )
      end

      def self.build_workplace(data)
        Values::Workplace.new(
          name: data.fetch('arbetsplatsnamn'),
          postal: build_postal(data),
          country: data.fetch('land'),
          visit_address: data.fetch('besoksadress'),
          logotype_url: data.fetch('logotypurl', nil),
          website: data.fetch('hemsida', nil),
          contacts: (
            data.dig('kontaktpersonlista', 'kontaktpersonlista') || []
          ).map do |contact_data|
            build_workplace_contacts(contact_data)
          end
        )
      end

      def self.build_postal(data)
        Values::Postal.new(
          code: data.fetch('postnummer'),
          address: data.fetch('postadress'),
          city: data.fetch('postort'),
          country: data.fetch('postland')
        )
      end

      def self.build_workplace_contacts(data)
        Values::Contact.new(
          name: data['namn'],
          title: data['titel'],
          phone: data['telefonnummer']
        )
      end

      def self.build_requirements(data)
        Values::Requirements.new(
          own_car: data.fetch('egenbil')
        )
      end
    end
  end
end
