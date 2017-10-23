require 'uri'
require 'net/http'
require 'json'

module Arbetsformedlingen
  module Platsannons
    class Request
      Response = KeyStruct.new(:code, :body, :json)

      HEADERS = {
        'Content-Type' => 'application/json',
        'Accept-Language' => 'sv'
      }.freeze

      attr_reader :locale, :base_url

      def initialize(base_url: '', locale: 'sv')
        @base_url = base_url
        @locale = locale
      end

      def get(url, query: {})
        uri = URI("#{base_url}#{url}?#{URI.encode_www_form(query.to_a)}")

        http = Net::HTTP.new(uri.host, uri.port)

        request = Net::HTTP::Get.new(uri)
        request['Content-Type'] = HEADERS['Content-Type']
        request['Accept-Language'] = locale

        response = http.request(request)

        Response.new(
          code: response.code,
          body: response.read_body,
          json: parse_json(response.read_body)
        )
      end

      def parse_json(string)
        JSON.parse(string.to_s)
      rescue JSON::ParserError => _e
        {}
      end
    end
  end
end
