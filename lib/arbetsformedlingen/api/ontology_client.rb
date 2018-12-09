# frozen_string_literal: true

module Arbetsformedlingen
  module API
    # API client for ontology
    # @see http://ontologi.arbetsformedlingen.se/ontology/v1/?url=swagger.json
    class OntologyClient
      attr_reader :request

      # Base API URL
      BASE_URL = 'http://ontologi.arbetsformedlingen.se/ontology/v1'

      # Valid types
      VALID_TYPES = %w[skill occupation trait].freeze

      # Initialize client
      def initialize(request: Request.new(base_url: BASE_URL))
        @request = request
      end

      # GET /concept - Fetches a list of concepts
      # @return [Response]
      def concepts(filter: nil, offset: nil, limit: nil, type: nil)
        query = to_params(filter: filter, offset: offset, limit: limit, type: type)

        request.get('/concept', query: query)
      end

      # GET /concept/:uuid} - Fetch a concept given an uuid
      # @return [Response]
      def concept(uuid)
        request.get("/concept/#{uuid}")
      end

      # GET /concept/related - Fetches related concepts for any number of
      # concepts and/or uuids
      # @return [Response]
      def concepts_relations(uuids: [], names: [], limit: nil, type: nil)
        concepts = (
          names.map { |name| ['concept', name] } +
          uuids.map { |name| ['uui', name] }
        ).reject(&:empty?)

        query = to_params(limit: limit, type: type).to_a.concat(concepts)

        request.get('/concept/related', query: query)
      end

      # GET /concept/:uuid/terms - Fetches the terms for the given uuid
      # @return [Response]
      def concept_terms(concept_uuid, offset: nil, limit: nil)
        query = to_params(offset: offset, limit: limit)

        request.get("/concept/#{concept_uuid}/terms", query: query)
      end

      # GET /concept/:uuid/related/:type - Fetches related concepts for the
      # given uuid, returning only concepts of the given type
      # @return [Response]
      def concept_relations(concept_uuid, type, offset: nil, limit: nil)
        query = to_params(offset: offset, limit: limit)

        request.get("/concept/#{concept_uuid}/related/#{type}", query: query)
      end

      # GET /terms - Fetches a list of terms
      # @return [Response]
      def terms(filter: nil, offset: nil, limit: nil, type: nil)
        query = to_params(filter: filter, offset: offset, limit: limit, type: type)

        request.get('/terms', query: query)
      end

      # GET /:type/:description - Redirects to the concepts UUID
      # @return [Response]
      def type_description(type, description)
        request.get("/#{type}/#{description}")
      end

      # GET /:type/:description/related/:totype - Redirects to the concepts
      # UUID related concepts
      # @return [Response]
      def type_description_relations(type, description, relation_type)
        request.get("/#{type}/#{description}/related/#{relation_type}")
      end

      # POST /text-to-structure - Analyzes a text and returns the concepts found
      # @return [Response]
      def text_to_structure(text)
        request.post('/text-to-structure', data: { text: text })
      end

      private

      def to_params(filter: nil, offset: nil, limit: nil, type: nil)
        if type && !VALID_TYPES.include?(type)
          raise(ArgumentError, "invalid type #{type}, valid types are #{VALID_TYPES.join(', ')}") # rubocop:disable Metrics/LineLength
        end

        {
          filter: filter,
          offset: offset,
          limit: limit,
          type: type,
        }.delete_if { |_k, v| v.nil? }
      end
    end
  end
end
