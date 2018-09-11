module Arbetsformedlingen
  module API
    module Values
      SoklistaPage = KeyStruct.new(
        :list_name,
        :total_ads,
        :total_vacancies,
        :data,
        :raw_data,
        :response
      )
      class SoklistaPage
        include Enumerable

        def each(&block)
          data.each(&block)
        end

        def to_h
          hash = super.to_h
          hash.delete(:response) # we don't want to return the raw response object
          hash[:data].map!(&:to_h)
          hash
        end

        def method_missing(method_name, *arguments, &block)
          if response.respond_to?(method_name)
            response.public_send(method_name, *arguments, &block)
          else
            super
          end
        end

        def respond_to_missing?(method_name, include_private = false)
          response.respond_to?(method_name) || super
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
