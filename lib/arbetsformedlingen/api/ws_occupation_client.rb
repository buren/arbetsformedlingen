require 'arbetsformedlingen/soap_builder'
require 'arbetsformedlingen/api/soap_request'

module Arbetsformedlingen
  module API
    class WSOccupationClient
      attr_reader :request

      BASE_URL = 'https://api.arbetsformedlingen.se/af/v0/Occupation'.freeze

      def initialize
        @request = request || SOAPRequest.new(base_url: BASE_URL)
      end

      def occupation(id)
        soap_body = Arbetsformedlingen::SOAPBuilder.wrap do |body|
          body.GetOccupationById(xmlns: 'urn:ams.se:wsoccupation') do |node|
            node.occupationId(id)
          end
        end

        request.post('/wsoccupation.asmx', soap_body.to_xml)
      end

      def occupations
        soap_body = Arbetsformedlingen::SOAPBuilder.wrap do |body|
          body.GetAllOccupations(xmlns: 'urn:ams.se:wsoccupation')
        end

        request.post('/wsoccupation.asmx', soap_body.to_xml)
      end

      def occupations_short
        soap_body = Arbetsformedlingen::SOAPBuilder.wrap do |body|
          body.GetAllOccupationsShort(xmlns: 'urn:ams.se:wsoccupation')
        end

        request.post('/wsoccupation.asmx', soap_body.to_xml)
      end

      def occupations_detailed
        soap_body = Arbetsformedlingen::SOAPBuilder.wrap do |body|
          body.GetAllOccupationsDetailed(xmlns: 'urn:ams.se:wsoccupation')
        end

        request.post('/wsoccupation.asmx', soap_body.to_xml)
      end
    end
  end
end
