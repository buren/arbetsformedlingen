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
          xml_builder = <<-RUBY
          body.#{name}(xmlns: namespace) do |node|
            #{args.map { |k, v| "node.#{k}('#{v}')" }.join(';')}
          end
          RUBY

          instance_eval(xml_builder)
        end

        request.post(soap_body.to_xml)
      end
    end
  end
end
