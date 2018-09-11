require 'uri'
require 'net/http'

begin
  require 'nokogiri'
rescue LoadError
end

module Arbetsformedlingen
  module API
    # API SOAP request
    class SOAPRequest
      # SOAP response
      Response = KeyStruct.new(:code, :body, :xml)

      attr_reader :locale, :uri, :url

      # Initialize SOAP request
      def initialize(url, locale: nil)
        unless Object.const_defined?(:Nokogiri)
          raise(ArgumentError, "unable to require 'nokogiri' gem, please install it")
        end

        @url = url
        @uri = URI(url)
        @locale = locale
      end

      # Performs a POST request
      # @param [String] the post body
      # @return [Response] the response
      def post(body)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true if uri.scheme == 'https'

        request = Net::HTTP::Post.new(uri)
        request['Content-Type'] = 'text/xml'
        request['Accept-Language'] = locale if locale
        request.body = body

        response = http.request(request)

        Response.new(
          code: response.code,
          body: response.read_body,
          xml: parse_xml(response.read_body)
        )
      end

      def parse_xml(string)
        Nokogiri::XML(string).tap { |doc| doc.remove_namespaces! }
      end
    end
  end
end
