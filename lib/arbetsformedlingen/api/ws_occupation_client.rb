# frozen_string_literal: true

require 'arbetsformedlingen/api/base_soap_client'

module Arbetsformedlingen
  module API
    # WsOccupation API client
    # @see https://api.arbetsformedlingen.se/af/v0/Occupation/wsoccupation.asmx
    class WSOccupationClient < BaseSOAPClient
      # Service URL
      SERVICE_URL = 'https://api.arbetsformedlingen.se/af/v0/Occupation/wsoccupation.asmx'.freeze

      # Namespace
      NAMESPACE = 'urn:ams.se:wsoccupation'

      # Initialize client
      def initialize
        super(SERVICE_URL, NAMESPACE)
      end

      # Returns occupation with specified id
      # @return [Response] the response
      # @see Response
      # @see Response#xml
      def occupation(id)
        client_request('GetOccupationById', args: { occupationId: id })
      end

      # Returns occupations
      # @return [Response] the response
      # @see Response
      # @see Response#xml
      def find_occupations(name)
        client_request('FindOccupation', args: { name: name })
      end

      # Returns occupations response
      # @return [Response] the response
      # @see Response
      # @see Response#xml
      def occupations
        client_request('GetAllOccupations')
      end

      # Returns occupations short
      # @return [Response] the response
      # @see Response
      # @see Response#xml
      def occupations_short
        client_request('GetAllOccupationsShort')
      end

      # Returns occupations detailed
      # @return [Response] the response
      # @see Response
      # @see Response#xml
      def occupations_detailed
        client_request('GetAllOccupationsDetailed')
      end

      # Returns locale groups
      # @return [Response] the response
      # @see Response
      # @see Response#xml
      def locale_groups(id)
        client_request('GetLocaleGroups', args: { occupationId: id })
      end

      # Returns platsbanken link for specified locale group id
      # @return [Response] the response
      # @see Response
      # @see Response#xml
      def platsbanken_link(id)
        client_request('GetPlatsbankenLink', args: { localegroupid: id })
      end

      # Returns education connections
      # @return [Response] the response
      # @see Response
      # @see Response#xml
      def education_connections
        client_request('LoadAllEducationConnections')
      end

      # Returns occupations containing id and name information
      # @return [Response] the response
      # @see Response
      # @see Response#xml
      def occupations_id_and_name
        client_request('LoadAllOccupationIdAndName')
      end

      # Returns article
      # @return [Response] the response
      # @see Response
      # @see Response#xml
      def article(id)
        client_request('GetArticle', args: { articleId: id })
      end
    end
  end
end
