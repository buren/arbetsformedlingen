require 'arbetsformedlingen/soap_builder'
require 'arbetsformedlingen/api/soap_request'

module Arbetsformedlingen
  module API
    class WSOccupationClient
      attr_reader :request

      BASE_URL = 'https://api.arbetsformedlingen.se/af/v0/Occupation'.freeze

      def initialize(locale: 'sv')
        @request = request || SOAPRequest.new(base_url: BASE_URL, locale: locale)
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
    end
  end
end
