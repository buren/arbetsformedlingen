require 'arbetsformedlingen/api/platsannonser/values/soklista_values'

module Arbetsformedlingen
  module Platsannonser
    module SoklistaResult
      def self.build(response_data)
        data = response_data.fetch('soklista')

        Values::SoklistaPage.new(
          list_name: data.fetch('listnamn'),
          total_ads: data.fetch('totalt_antal_platsannonser'),
          total_vacancies: data.fetch('totalt_antal_ledigajobb'),
          raw_data: response_data,
          data: data.fetch('sokdata').map do |result|
            Values::SoklistaResult.new(
              id: result.fetch('id'),
              name: result.fetch('namn'),
              total_ads: result.fetch('antal_platsannonser'),
              total_vacancies: result.fetch('antal_ledigajobb')
            )
          end
        )
      end
    end
  end
end
