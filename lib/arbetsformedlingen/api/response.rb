module Arbetsformedlingen
  module API
    class Response
      def initialize(response)
        @response = response
        @json = nil
      end

      def success?
        response.code == '200'
      end

      def body
        response.read_body
      end

      def json
        @json ||= parse_json(body)
      end

      def method_missing(method_name, *arguments, &block)
        if response.respond_to?(method_name)
          response.public_send(method_name, *arguments, &block)
        else
          super
        end
      end

      def respond_to_missing?(method_name, include_private = false)
        response.respond_to?(method_name) || super
      end

      private

      attr_reader :response

      def parse_json(string)
        JSON.parse(string.to_s)
      rescue JSON::ParserError => _e
        {}
      end
    end
  end
end
