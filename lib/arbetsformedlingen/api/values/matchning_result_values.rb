# frozen_string_literal: true

module Arbetsformedlingen
  module API
    module Values
      MatchningPage = KeyStruct.new(
        :list_name,
        :total_ads,
        :total_ads_exact,
        :total_ads_nearby,
        :total_vacancies_on_page,
        :total_places_total,
        :total_pages,
        :data,
        :raw_data,
        :response
      )
      class MatchningPage
        include Enumerable

        def each(&block)
          data.each(&block)
        end

        def to_h
          hash = super.to_h
          hash.delete(:response) # don't return the raw response object
          hash[:data].map!(&:to_h)
          hash
        end

        def success?
          success
        end
      end

      MatchningAd = KeyStruct.new(
        :id,
        :title,
        :occupation,
        :occupation_id,
        :company,
        :municipalities,
        :municipality_id,
        :published_at,
        :last_application_at,
        :url,
        :relevance,
        :total_vacancies,
        :total_vacancies_with_visa,
        :duration_id,
        :counties,
        :country_id,
        :employment_type
      )
    end
  end
end
