require 'uri'
require 'net/http'
require 'json'

require 'arbetsformedlingen/api/request'

require 'arbetsformedlingen/api/results/ad_result'
require 'arbetsformedlingen/api/results/matchning_result'
require 'arbetsformedlingen/api/results/soklista_result'

# Sub-clients
require 'arbetsformedlingen/api/matchning_client'
require 'arbetsformedlingen/api/ledigtarbete_client'

module Arbetsformedlingen
  module API
    class Client
      BASE_URL = 'http://api.arbetsformedlingen.se/af/v0/'.freeze

      attr_reader :request, :locale

      def initialize(locale: 'sv')
        @request = Request.new(base_url: BASE_URL, locale: locale)
        @locale = locale
      end

      # Get version of API
      # @return [String] the version of the API.
      # @example Get API version
      #    client.version
      def version
        request.get('version').body
      end

      # Post ad to API (ad => annons)
      # @return [AdResult] the result.
      # @param [Arbetsformedlingen::Packet] Packet object.
      # @example Post ad
      #    client.ad(packet)
      def create_ad(packet)
        client = LedigtarbeteClient.new
        client.create_ad(packet)
      end

      # Fetch ad from API (ad => annons)
      # @return [AdResult] the result.
      # @param id [String] Ad ID.
      # @example Get ad
      #    client.ad(id: id)
      def ad(id:)
        response = request.get(id)

        AdResult.build(response.json)
      end

      # Fetch areas from API (areas => landområde/värdsdel)
      # @return [MatchningResult] the result.
      # @see MatchningClient#ads
      # @see MatchningResult#build
      def ads(**args)
        client = MatchningClient.new(request: request)
        client.ads(**args)
      end

      # Fetch areas from API (areas => landområde/värdsdel)
      # @return [AdResult] the result.
      # @example Get areas
      #    client.areas
      def areas
        response = request.get('soklista/omrade')

        SoklistaResult.build(response.json)
      end

      # Fetch counties from API (countries => land)
      # @return [AdResult] the result.
      # @param area_id [String] Area ID.
      # @example Get countries within area
      #    client.countries(area_id: id)
      def countries(area_id:)
        query = { omradeid: area_id }
        response = request.get('soklista/land', query: query)

        SoklistaResult.build(response.json)
      end

      # Fetch municipalities from API (municipality => kommun)
      # @return [AdResult] the result.
      # @param county_id [String] County ID.
      # @example Get counties
      #    client.counties
      def municipalities(county_id: nil)
        # NOTE: Due to a quirck in the API the lanid-param
        #       *must* be present though it *can* be nil
        query = { lanid: county_id }
        response = request.get('soklista/kommuner', query: query)

        SoklistaResult.build(response.json)
      end

      # Fetch counties from API (county => län)
      # @return [AdResult] the result.
      # @example Get counties
      #    client.counties
      def counties
        response = request.get('soklista/lan')

        SoklistaResult.build(response.json)
      end

      # Fetch counties2 from API (county2 => län2)
      # @return [AdResult] the result.
      # @example Get counties2
      #    client.counties2
      def counties2
        response = request.get('soklista/lan2')

        SoklistaResult.build(response.json)
      end

      # Fetch occupational fields from API (occupational_fields => yrkesområde)
      # @return [AdResult] the result.
      # @example Get occupational fields
      #    client.occupational_field
      def occupational_fields
        response = request.get('soklista/yrkesomraden')

        SoklistaResult.build(response.json)
      end

      # Fetch occupational group from API (occupational_group => yrkesgrupp)
      # @return [AdResult] the result.
      # @param occupational_field_id [String] Occupational field ID.
      # @example Get all occupational group
      #    client.occupational_group
      # @example Get occupational group within occupational field
      #    client.occupational_group(occupational_field_id: id)
      def occupational_group(occupational_field_id: nil)
        # NOTE: Due to a quirck in the API the yrkesomradeid-param
        #       *must* be present though it *can* be nil
        query = { yrkesomradeid: occupational_field_id }
        response = request.get('soklista/yrkesgrupper', query: query)

        SoklistaResult.build(response.json)
      end

      # Fetch occupation from API (occupation => yrkesnamn)
      # @return [AdResult] the result.
      # @param name [String] Name of the occupation.
      # @example Get occupation
      #    client.occupation(name: 'Marknadskommunikatör')
      def occupation(name:)
        response = request.get("soklista/yrken/#{URI.encode(name)}")

        SoklistaResult.build(response.json)
      end

      # Fetch occupations from API (occupation => yrkesnamn)
      # @return [AdResult] the result.
      # @param occupational_group_id [String] Occupational group ID.
      # @example Get stats of available positions for all occupations
      #    client.occupations
      # @example Get stats of available positions for some occupations
      #    client.occupations(occupational_group_id: id)
      def occupations(occupational_group_id: nil)
        # NOTE: Due to a quirck in the API the yrkesgruppid-param
        #       *must* be present though it *can* be nil
        query = { yrkesgruppid: occupational_group_id }
        response = request.get('soklista/yrken', query: query)

        SoklistaResult.build(response.json)
      end
    end
  end
end
