require 'uri'
require 'net/http'
require 'json'
require 'arbetsformedlingen/api/response'

module Arbetsformedlingen
  module API
    class Request
      attr_reader :locale, :base_url

      def initialize(base_url: '', locale: 'sv')
        @base_url = base_url
        @locale = locale
      end

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
