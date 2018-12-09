# frozen_string_literal: true

require 'arbetsformedlingen/soap_builder'
require 'arbetsformedlingen/api/soap_request'

module Arbetsformedlingen
  module API
    class BaseSOAPClient
      attr_reader :request, :namespace, :service_url

      # Initialize client
      def initialize(url, namespace)
        @service_url = url
        @namespace = namespace
        @request = SOAPRequest.new(url)
      end

      def client_request(name, args: {})
        soap_body = SOAPBuilder.wrap do |body| # rubocop:disable Lint/UnusedBlockArgument
          # HACK: Work around the XMLBuilder DSL
          nodes = args.map do |key, value|
            if value.is_a?(Array)
              statements = value.map do |data|
                k, v = data
                "node.#{key} { |inode| inode.#{k}('#{v}') }"
              end

              statements.join(';')
            else
              "node.#{key}('#{value}')"
            end
          end

          xml_builder = <<-RUBY_EVAL
          body.#{name}(xmlns: namespace) do |node|
            #{nodes.join(';')}
          end
          RUBY_EVAL

          instance_eval(xml_builder)
        end

        request.post(soap_body.to_xml)
      end
    end
  end
end
