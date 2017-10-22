require 'arbetsformedlingen/api/client'

module Arbetsformedlingen
  module API
    class AdSearch
      attr_reader :request

      def initialize(request: Request.new)
        @request = request
      end

      # Page 14-15 in AF API docs
      def search(
        # one of these must be present
        county_id: nil,
        municipality_id: nil,
        occupation_id: nil,
        keywords: nil,
        # optional
        page: 1,
        page_size: 30,
        area_id: nil,
        occupation_group_id: nil,
        employment_type: nil,
        occupation_field_id: nil,
        published_after: nil,
        organization_number: nil
      )

        one_of_required = [county_id, municipality_id, occupation_id, keywords]
        if one_of_required.all?(&:nil?)
          error_message = 'One of: county_id, municipality_id, occupation_id, keywords is required'
          raise ArgumentError, error_message
        end

        # TODO: Should we validate the IDs passed? What if they're invalid? Do we crash?

        query = {
          lanid: county_id,
          kommunid: municipality_id,
          yrkesid: occupation_id,
          nyckelord: santize_keywords_query(keywords),
          sida: page,
          antalrader: page_size,
          omradeid: area_id,
          yrkesgruppid: occupation_group_id,
          anstallningstyp: santize_employment_type_query(employment_type),
          yrkesomradeid: occupation_field_id,
          sokdatum: published_after,
          organisationsnummer: organization_number
        }

        response = request.get('platsannonser/matchning', query: query)

        MatchningResult.build(response.json)
      end

      def santize_employment_type_query(employment_type)
        # Sökkriterier anställningstyp.
        # Värdena ska ligga mellan 1 och 3.
        # 1 är XXX (EJ DOKUMENTERAT)
        # 2 är somarjobb / feriejobb
        # 3 är utlandsjobb

        # TODO: The question is what we do if an invalid parameter is passed
        #       should we crash?

        employment_type
      end

      def santize_keywords_query(keywords)
        #
        # Sökord kan separeras eller kombineras med något av följande exempel:
        # mellanslag (” ”)
        #
        # [Example]
        # /matchning?nyckelord="bagare""test"
        # /matchning?nyckelord="bagare"OR"test" /matchning?nyckelord="automatisk"AND"test"

        # Valid characters
        # abcdefghijklmnopqrstuvwxyzåäö0123456789: ,.-"

        # TODO: What do we do if invalid characters are passed? Crash?
        keywords
      end
    end
  end
end
