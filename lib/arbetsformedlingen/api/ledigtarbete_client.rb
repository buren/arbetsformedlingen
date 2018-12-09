# frozen_string_literal: true

require 'arbetsformedlingen/api/request'
require 'arbetsformedlingen/api/values/create_ad_page'

module Arbetsformedlingen
  module API
    # API client for ledigtarbete
    class LedigtarbeteClient
      # Base URL for ledigtarbete
      BASE_URL = 'http://api.arbetsformedlingen.se/ledigtarbete'.freeze

      # HTTP headers
      HEADERS = {
        'Content-type' => 'text/xml',
      }.freeze

      # Post ad to API
      # @param [Arbetsformedlingen::Packet, #to_xml] packet the data to be sent
      # @return [Values::CreateAdPage] the API result
      def create_ad(packet)
        xml = packet.to_xml

        url = if Arbetsformedlingen.config.test
                'apiledigtarbete/test/hrxml'
              else
                'apiledigtarbete/hrxml'
              end

        response = HTTParty.post("#{BASE_URL}/#{url}", body: xml, headers: HEADERS)
        Values::CreateAdPage.new(response, xml)
      end
    end
  end
end
