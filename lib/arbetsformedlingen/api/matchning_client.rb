require 'date'
require 'time'
require 'arbetsformedlingen/api/request'
require 'arbetsformedlingen/api/results/matchning_result'

module Arbetsformedlingen
  module API
    class MatchningClient
      attr_reader :request

      def initialize(request: Request.new)
        @request = request
      end

      # Find matching ads from API
      # @return [MatchningResult] the result.
      # @param area_id [String] Area ID.
      # @param county_id [String] County ID.
      # @param municipality_id [String] Municipality ID.
      # @param occupation_id [String] Occupation ID.
      # @param keywords [String] Keywords.
      # @param page [Integer] Page ID.
      # @param page_size [Integer] Page size ID.
      # @param occupation_group_id [String] Occupation_group ID.
      # @param employment_type [String] Employment type ID.
      # @param occupation_field_id [String] Occupation field ID.
      # @param published_after [Time, Date, String] Published after ID (ISO8601 format: YYYY-MM-DDThh:mm:ssTZD).
      # @param organization_number [String] Organization_number ID.
      # @example Get ads within county
      #    client.ads(county: id)
      # @example Get ads within municipality
      #    client.ads(municipality: id)
      # @example Get ads with keyword
      #    client.ads(keywrods: 'ruby')
      # @example Get ads with keyword on page 3 and with a page size of 10
      #    client.ads(keywrods: 'ruby', page: 3, page_size: 10)
      # @example Get ads with keyword and organsiation numer
      #    client.ads(keywrods: 'ruby', organization_number: org_no)
      def ads(
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
        #
        #       Currently when an invalid value is passed MatchningResult::build returns
        #         => KeyError: key not found: "matchningslista"
        #       which isn't really helpful..

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
          sokdatum: normalize_date_to_iso8601(published_after),
          organisationsnummer: organization_number
        }

        response = request.get('matchning', query: query)

        MatchningResult.build(response)
      end

      private

      # @raise [ArgumentError] raises error if passed invalid value
      def normalize_date_to_iso8601(date_time_or_string)
        return unless date_time_or_string

        time = date_time_or_string
        time = time.to_time if time.is_a?(Date)
        time = Time.parse(time) if time.is_a?(String)

        time.iso8601
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
