require 'uri'
require 'net/http'
require 'json'

require 'arbetsformedlingen/api/request'

require 'arbetsformedlingen/api/results/matchning_result'
require 'arbetsformedlingen/api/results/soklista_result'

require 'arbetsformedlingen/api/ad_search'
require 'arbetsformedlingen/api/results/ad_result'

module Arbetsformedlingen
  module API
    class Client
      BASE_URL = 'http://api.arbetsformedlingen.se/af/v0/'.freeze

      attr_reader :request, :locale

      def initialize(locale: 'sv')
        @request = Request.new(base_url: BASE_URL, locale: locale)
        @locale = locale
      end

      def version
        request.get('platsannonser/version').body
      end

      def ad(id:)
        response = request.get("platsannonser/#{id}")

        AdResult.build(response.json)
      end

      def ads(**args)
        AdSearch.new(request: request).search(**args)
      end

      # area => landområde/värdsdel
      def area
        response = request.get('platsannonser/soklista/omrade')

        SoklistaResult.build(response.json)
      end

      # countries
      def countries(area_id:)
        query = { omradeid: area_id }
        response = request.get('platsannonser/soklista/land', query: query)

        SoklistaResult.build(response.json)
      end

      # municipality => kommun
      def municipality(county_id: nil)
        # NOTE: Due to a quirck in the API the lanid-param
        #       *must* be present though it *can* be nil
        query = { lanid: county_id }
        response = request.get('platsannonser/soklista/kommuner', query: query)

        SoklistaResult.build(response.json)
      end

      # county => län
      def county
        response = request.get('platsannonser/soklista/lan')

        SoklistaResult.build(response.json)
      end

      # county2 => län2
      def county2
        response = request.get('platsannonser/soklista/lan2')

        SoklistaResult.build(response.json)
      end

      # occupational_field => yrkesområde
      def occupational_field
        response = request.get('platsannonser/soklista/yrkesomraden')

        SoklistaResult.build(response.json)
      end

      # occupational_group => yrkesgrupp
      def occupational_group(occupational_field_id: nil)
        # NOTE: Due to a quirck in the API the yrkesomradeid-param
        #       *must* be present though it *can* be nil
        query = { yrkesomradeid: occupational_field_id }
        response = request.get('platsannonser/soklista/yrkesgrupper', query: query)

        SoklistaResult.build(response.json)
      end

      # occupation => yrkesnamn
      # Fetch occupation from API
      # @example Get one occupation using name
      #    client.occupation(name: 'Marknadskommunikatör')
      def occupation(name:)
        response = request.get("platsannonser/soklista/yrken/#{URI.encode(name)}")

        SoklistaResult.build(response.json)
      end

      # Fetch occupations from API
      # @example Get stats of available positions for all occupations
      #    client.occupations
      # @example Get stats of available positions for some occupations
      #    client.occupations(occupational_group_id: id)
      def occupations(occupational_group_id: nil)
        # NOTE: Due to a quirck in the API the yrkesgruppid-param
        #       *must* be present though it *can* be nil
        query = { yrkesgruppid: occupational_group_id }
        response = request.get('platsannonser/soklista/yrken', query: query)

        SoklistaResult.build(response.json)
      end
    end
  end
end
