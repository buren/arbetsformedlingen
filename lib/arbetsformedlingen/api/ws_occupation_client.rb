require 'arbetsformedlingen/soap_builder'
require 'arbetsformedlingen/api/soap_request'

module Arbetsformedlingen
  module API
    # WsOccupation API client
    class WSOccupationClient
      attr_reader :request

      # Service URL
      SERVICE_URL = 'https://api.arbetsformedlingen.se/af/v0/Occupation/wsoccupation.asmx'.freeze

      # Initialize client
      def initialize
        @request = SOAPRequest.new(SERVICE_URL)
      end

      def occupation(id)
        soap_body = SOAPBuilder.wrap do |body|
          body.GetOccupationById(xmlns: 'urn:ams.se:wsoccupation') do |node|
            node.occupationId(id)
          end
        end

        request.post(soap_body.to_xml)
      end

      def find_occupations(name)
        soap_body = SOAPBuilder.wrap do |body|
          body.FindOccupation(xmlns: 'urn:ams.se:wsoccupation') do |node|
            node.name(name)
          end
        end

        request.post(soap_body.to_xml)
      end

      def occupations
        soap_body = SOAPBuilder.wrap do |body|
          body.GetAllOccupations(xmlns: 'urn:ams.se:wsoccupation')
        end

        request.post(soap_body.to_xml)
      end

      def occupations_short
        soap_body = SOAPBuilder.wrap do |body|
          body.GetAllOccupationsShort(xmlns: 'urn:ams.se:wsoccupation')
        end

        request.post(soap_body.to_xml)
      end

      def occupations_detailed
        soap_body = SOAPBuilder.wrap do |body|
          body.GetAllOccupationsDetailed(xmlns: 'urn:ams.se:wsoccupation')
        end

        request.post(soap_body.to_xml)
      end
    end
  end
end
