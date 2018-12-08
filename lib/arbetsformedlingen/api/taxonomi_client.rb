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
      # @see Response#xml
      def occupation_names(language_id:)
        soap_body = SOAPBuilder.wrap do |body|
          body.GetAllOccupationNames(xmlns: NAMESPACE) do |node|
            node.languageId(language_id)
          end
        end

        request.post(soap_body.to_xml)
      end
    end
  end
end
