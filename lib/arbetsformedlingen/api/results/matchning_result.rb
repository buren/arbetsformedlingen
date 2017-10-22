require 'arbetsformedlingen/api/values/matchning_result_values'

module Arbetsformedlingen
  module API
    module MatchningResult
      def self.build(response_data)
        data = response_data.fetch('matchningslista')

        Values::MatchningResultsPage.new(
          list_name: 'annonser',
          total_ads: data.fetch('antal_platsannonser'),
          total_ads_exact: data.fetch('antal_platsannonser_exakta'),
          total_ads_nearby: data.fetch('antal_platsannonser_narliggande'),
          total_vacancies_on_page: data.fetch('antal_platserTotal'),
          total_pages: data.fetch('antal_sidor'),
          raw_data: response_data,
          data: data.fetch('matchningdata').map { |ad_data| build_ad_result(ad_data) }
        )
      end

      def self.build_ad_result(ad_data)
        Values::MatchningAd.new(
          id: ad_data.fetch('annonsid'),
          title: ad_data.fetch('annonsrubrik'),
          occupation: ad_data.fetch('yrkesbenamning'),
          occupation_id: ad_data.fetch('yrkesbenamningId'),
          company: ad_data.fetch('arbetsplatsnamn'),
          municipality: ad_data.fetch('kommunnamn'),
          municipality_id: ad_data.fetch('kommunkod'),
          published_at: ad_data.fetch('publiceraddatum'),
          last_application_at: ad_data.fetch('sista_ansokningsdag'),
          url: ad_data.fetch('annonsurl'),
          relevance: ad_data.fetch('relevans'),
          total_vacancies: ad_data.fetch('antalplatser'),
          total_vacancies_with_visa: ad_data.fetch('antalPlatserVisa'),
          duration_id: ad_data.fetch('varaktighetId'),
          county: ad_data.fetch('lan'),
          country_id: ad_data.fetch('lanid'),
          employment_type: ad_data.fetch('anstallningstyp')
        )
      end
    end
  end
end
