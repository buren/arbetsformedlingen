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
      # @param [Hash, Array<Array<#to_s>>] query params
      # @return [Response] response object
      def get(url, query: {})
        uri = to_uri(url, query: query)

        http = Net::HTTP.new(uri.host, uri.port)
        request = Net::HTTP::Get.new(uri)
        request['Content-Type'] = 'application/json'
        request['Accept-Language'] = locale

        response = http.request(request)
        if response.code == '303' && response.header['Location'] # AFs APIs somtimes redirects with HTTP 303
          return get(response.header['Location'], query: query)
        end

        Response.new(response, uri)
      end

      def post(url, data: {})
        uri = to_uri(url)

        http = Net::HTTP.new(uri.host, uri.port)
        request = Net::HTTP::Post.new(uri)
        request['Content-Type'] = 'application/json'
        request['Accept-Language'] = locale
        request['cache-control'] = 'no-cache'
        request.body = JSON.dump(data)

        response = http.request(request)

        Response.new(response, uri)
      end

      private

      def to_uri(url, query: {})
        full_url = URI(url.to_s).absolute ? url : "#{base_url}#{url}"

        URI("#{full_url}?#{URI.encode_www_form(query.to_a)}")
      end
    end
  end
end
