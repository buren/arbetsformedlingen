# frozen_string_literal: true

require 'arbetsformedlingen/soap_builder'
require 'arbetsformedlingen/api/soap_request'

module Arbetsformedlingen
  module API
    # WsOccupation API client
    class TaxonomiClient
      attr_reader :request

      # Service URL
      SERVICE_URL = 'http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx'

      # Namespace
      NAMESPACE = 'urn:ams.se:Taxonomy'

      # Initialize client
      def initialize
        @request = SOAPRequest.new(SERVICE_URL)
      end

      # Returns occupation names
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAllOccupationNames
      def occupation_names(language_id:)
        simple_soap_request('GetAllOccupationNames', args: { languageId: language_id })
      end

      # Returns AID occupation names
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAllAIDOccupationNames
      def aid_occupation_names
        simple_soap_request('GetAllAIDOccupationNames')
      end

      # Returns continents
      # @return [Response] the response
      # @see Response
      # @see http://api.arbetsformedlingen.se/taxonomi/v0/TaxonomiService.asmx?op=GetAllContinents
      def continents(language_id:)
        simple_soap_request('GetAllContinents', args: { languageId: language_id })
      end

      private

      def simple_soap_request(name, args: {})
        soap_body = SOAPBuilder.wrap do |body|
          # HACK: Work around the XMLBuilder DSL
          <<-RUBY_EVAL
          body.#{name}(xmlns: NAMESPACE) do |node|
            #{args.map { |k, v| "node.#{k}(#{v})" }.join(';')}
          end
          RUBY_EVAL
        end

        request.post(soap_body.to_xml)
      end
    end
  end
end
