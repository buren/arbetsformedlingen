# frozen_string_literal: true

require 'arbetsformedlingen/soap_builder'
require 'arbetsformedlingen/api/soap_request'

module Arbetsformedlingen
  module API
    # Base client for SOAP clients
    class BaseSOAPClient
      attr_reader :request, :namespace, :service_url

      # Initialize client
      def initialize(url, namespace)
        @service_url = url
        @namespace = namespace
        @request = SOAPRequest.new(url)
      end

      # Perform client request
      # @param [String] name of the main node
      # @param args [Hash] optional arguments
      # @return [Response]
      def client_request(name, args: {})
        soap_body = SOAPBuilder.wrap do |body| # rubocop:disable Lint/UnusedBlockArgument
          # HACK: Work around the XMLBuilder DSL
          ruby_statements = args.map do |key, value|
            if value.is_a?(Array)
              inner_ruby_statements = value.map do |(k, v)|
                "inode.#{k}('#{v}')"
              end

              <<~RUBY_EVAL
                node.#{key} { |inode| #{inner_ruby_statements.join(';')} }
              RUBY_EVAL
            else
              "node.#{key}('#{value}')"
            end
          end

          ruby_xml_builder_code = <<~RUBY_EVAL
            body.#{name}(xmlns: namespace) { |node| #{ruby_statements.join(';')} }
          RUBY_EVAL

          instance_eval(ruby_xml_builder_code)
        end

        request.post(soap_body.to_xml)
      end
    end
  end
end
