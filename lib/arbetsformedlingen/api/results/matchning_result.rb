require 'arbetsformedlingen/api/values/matchning_result_values'

module Arbetsformedlingen
  module API
    module MatchningResult
      def self.build(response)
        return empty_matchning_page(response) unless response.code == '200'

        build_matchning_page(response)
      end

      def self.empty_matchning_page(response)
        response_data = response.json

        Values::MatchningPage.new(
          list_name: 'annonser',
          total_ads: 0,
          total_ads_exact: 0,
          total_ads_nearby: 0,
          total_vacancies_on_page: 0,
          total_pages: 0,
          raw_data: response_data,
          data: [],
          response: response,
          success: false
        )
      end

      def self.build_matchning_page(response)
        response_data = response.json
        data = response_data.fetch('matchningslista')

        Values::MatchningPage.new(
          list_name: 'annonser',
          total_ads: data.fetch('antal_platsannonser'),
          total_ads_exact: data.fetch('antal_platsannonser_exakta'),
          total_ads_nearby: data.fetch('antal_platsannonser_narliggande'),
          total_vacancies_on_page: data.fetch('antal_platserTotal'),
          total_pages: data.fetch('antal_sidor'),
          raw_data: response_data,
          data: build_ad_results(data),
          response: response,
          success: true
        )
      end

      def self.build_ad_results(data)
        data.fetch('matchningdata', []).map do |ad_data|
          build_ad_result(ad_data)
        end
      end

      def self.build_ad_result(ad_data)
        Values::MatchningAd.new(
          id: ad_data.fetch('annonsid'),
          title: ad_data.fetch('annonsrubrik'),
          occupation: ad_data.fetch('yrkesbenamning'),
          occupation_id: ad_data.fetch('yrkesbenamningId'),
          company: ad_data.fetch('arbetsplatsnamn'),
          municipalities: ad_data.fetch('kommunnamn'),
          municipality_id: ad_data.fetch('kommunkod'),
          published_at: ad_data.fetch('publiceraddatum'),
          last_application_at: ad_data.fetch('sista_ansokningsdag', nil),
          url: ad_data.fetch('annonsurl'),
          relevance: ad_data.fetch('relevans'),
          total_vacancies: ad_data.fetch('antalplatser'),
          total_vacancies_with_visa: ad_data.fetch('antalPlatserVisa'),
          duration_id: ad_data.fetch('varaktighetId', nil),
          counties: ad_data.fetch('lan'),
          country_id: ad_data.fetch('lanid'),
          employment_type: ad_data.fetch('anstallningstyp')
        )
      end
    end
  end
end
