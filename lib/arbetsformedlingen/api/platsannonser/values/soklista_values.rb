module Arbetsformedlingen
  module Platsannonser
    module Values
      SoklistaResultPage = KeyStruct.new(
        :list_name,
        :total_ads,
        :total_vacancies,
        :data,
        :raw_data
      )
      class SoklistaResultPage
        include Enumerable

        def each(&block)
          data.each(&block)
        end

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
