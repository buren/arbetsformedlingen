module Arbetsformedlingen
  module API
    # API response object
    class Response
      # Initialize response
      def initialize(response)
        @response = response
        @json = nil
      end

      # True if response is 200
      # @return [Boolean] true if response code is 200
      def success?
        response.code == '200'
      end

      # Response body
      # @return [String] the response body
      def body
        response.read_body
      end

      # Response JSON
      # @return [Hash] response json Hash, empty is JSON is invalid
      def json
        @json ||= parse_json(body)
      end

      # Delegate missing values to response
      def method_missing(method_name, *arguments, &block)
        if response.respond_to?(method_name)
          response.public_send(method_name, *arguments, &block)
        else
          super
        end
      end

      # Return true if missing method can be delegated
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
