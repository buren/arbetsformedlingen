module Arbetsformedlingen
  module Platsannons
    module Values
      SoklistaResultPage = KeyStruct.new(
        :list_name,
        :total_ads,
        :total_vacancies,
        :data,
        :raw_data
      )
      class SoklistaResultPage
        def to_h
          hash = super.to_h
          hash[:data].map!(&:to_h)
          hash
        end
      end

      SoklistaResult = KeyStruct.new(
        :id,
        :name,
        :total_ads,
        :total_vacancies
      )
    end
  end
end
