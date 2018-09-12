# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'json'
require 'arbetsformedlingen/api/response'

module Arbetsformedlingen
  module API
    # API request object
    class Request
      attr_reader :locale, :base_url

      # Initialize request
      def initialize(base_url: '', locale: 'sv')
        @base_url = base_url
        @locale = locale
      end

      # Perform GEt request
      # @param [String] url to be fetched
      # @param [Hash] query params
      # @return [Response] response object
      def get(url, query: {})
        uri = URI("#{base_url}#{url}?#{URI.encode_www_form(query.to_a)}")

        http = Net::HTTP.new(uri.host, uri.port)

        request = Net::HTTP::Get.new(uri)
        request['Content-Type'] = 'application/json'
        request['Accept-Language'] = locale

        response = http.request(request)

        Response.new(response)
      end
    end
  end
end
