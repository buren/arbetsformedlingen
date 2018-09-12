# frozen_string_literal: true

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
    # Main API client
    class Client
      # Base URL for platsannonser
      BASE_URL = 'http://api.arbetsformedlingen.se/af/v0/platsannonser/'.freeze

      attr_reader :request, :locale

      # Initialize client
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
      # @return [Values::CreateAdPage] the result.
      # @param [Arbetsformedlingen::Packet] Packet object.
      # @example Post ad
      #    client.ad(packet)
      def create_ad(packet)
        client = LedigtarbeteClient.new
        client.create_ad(packet)
      end

      # Fetch ad from API (ad => annons)
      # @return [Values::Ad] the result.
      # @param id [String] Ad ID.
      # @example Get ad
      #    client.ad(id: id)
      # @see Values::Ad
      def ad(id:)
        response = request.get(id)

        AdResult.build(response)
      end

      # Fetch ads from API (areas => landområde/värdsdel)
      # @return [Values::MatchningPage] the result.
      # @see Values::MatchningPage
      def ads(**args)
        client = MatchningClient.new(request: request)
        client.ads(**args)
      end

      # Fetch areas from API (areas => landområde/värdsdel)
      # @return [Values::SoklistaPage] the result.
      # @example Get areas
      #    client.areas
      # @see Values::SoklistaPage
      def areas
        response = request.get('soklista/omrade')

        SoklistaResult.build(response, list_name: 'omrade')
      end

      # Fetch counties from API (countries => land)
      # @return [Values::SoklistaPage] the result.
      # @param area_id [String] Area ID.
      # @example Get countries within area
      #    client.countries(area_id: id)
      # @see Values::SoklistaPage
      def countries(area_id:)
        query = { omradeid: area_id }
        response = request.get('soklista/land', query: query)

        SoklistaResult.build(response, list_name: 'land')
      end

      # Fetch municipalities from API (municipality => kommun)
      # @return [Values::SoklistaPage] the result.
      # @param county_id [String] County ID.
      # @example Get counties
      #    client.counties
      # @see Values::SoklistaPage
      def municipalities(county_id: nil)
        # NOTE: Due to a quirck in the API the lanid-param
        #       *must* be present though it *can* be nil
        query = { lanid: county_id }
        response = request.get('soklista/kommuner', query: query)

        SoklistaResult.build(response, list_name: 'kommuner')
      end

      # Fetch counties from API (county => län)
      # @return [Values::SoklistaPage] the result.
      # @example Get counties
      #    client.counties
      # @see Values::SoklistaPage
      def counties
        response = request.get('soklista/lan')

        SoklistaResult.build(response, list_name: 'lan')
      end

      # Fetch counties2 from API (county2 => län2)
      # @return [Values::SoklistaPage] the result.
      # @example Get counties2
      #    client.counties2
      # @see Values::SoklistaPage
      def counties2
        response = request.get('soklista/lan2')

        SoklistaResult.build(response, list_name: 'lan2')
      end

      # Fetch occupational fields from API (occupational_fields => yrkesområde)
      # @return [Values::SoklistaPage] the result.
      # @example Get occupational fields
      #    client.occupational_field
      # @see Values::SoklistaPage
      def occupational_fields
        response = request.get('soklista/yrkesomraden')

        SoklistaResult.build(response, list_name: 'yrkesomraden')
      end

      # Fetch occupational group from API (occupational_group => yrkesgrupp)
      # @return [Values::SoklistaPage] the result.
      # @param occupational_field_id [String] Occupational field ID.
      # @example Get all occupational group
      #    client.occupational_group
      # @example Get occupational group within occupational field
      #    client.occupational_group(occupational_field_id: id)
      # @see Values::SoklistaPage
      def occupational_group(occupational_field_id: nil)
        # NOTE: Due to a quirck in the API the yrkesomradeid-param
        #       *must* be present though it *can* be nil
        query = { yrkesomradeid: occupational_field_id }
        response = request.get('soklista/yrkesgrupper', query: query)

        SoklistaResult.build(response, list_name: 'yrkesgrupper')
      end

      # Fetch occupation from API (occupation => yrkesnamn)
      # @return [Values::SoklistaPage] the result.
      # @param name [String] Name of the occupation.
      # @example Get occupation
      #    client.occupation(name: 'Marknadskommunikatör')
      # @see Values::SoklistaPage
      def occupation(name:)
        response = request.get("soklista/yrken/#{URI.encode(name)}")

        SoklistaResult.build(response, list_name: 'Yrken')
      end

      # Fetch occupations from API (occupation => yrkesnamn)
      # @return [Values::SoklistaPage] the result.
      # @param occupational_group_id [String] Occupational group ID.
      # @example Get stats of available positions for all occupations
      #    client.occupations
      # @example Get stats of available positions for some occupations
      #    client.occupations(occupational_group_id: id)
      # @see Values::SoklistaPage
      def occupations(occupational_group_id: nil)
        # NOTE: Due to a quirck in the API the yrkesgruppid-param
        #       *must* be present though it *can* be nil
        query = { yrkesgruppid: occupational_group_id }
        response = request.get('soklista/yrken', query: query)

        SoklistaResult.build(response, list_name: 'yrken')
      end
    end
  end
end
