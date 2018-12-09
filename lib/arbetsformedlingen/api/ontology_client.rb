# frozen_string_literal: true

module Arbetsformedlingen
  module API
    # API client for ontology
    # @see http://ontologi.arbetsformedlingen.se/ontology/v1/?url=swagger.json
    class OntologyClient
      attr_reader :request

      BASE_URL = 'http://ontologi.arbetsformedlingen.se/ontology/v1'

      VALID_TYPES = %w[skill occupation trait].freeze

      # Initialize client
      def initialize(request: Request.new(base_url: BASE_URL))
        @request = request
      end

      # GET /concept
      def concepts(filter: nil, offset: nil, limit: nil, type: nil)
        query = to_params(filter: filter, offset: offset, limit: limit, type: type)

        request.get('/concept', query: query)
      end

      # GET /concept/{uuid}
      def concept(uuid)
        request.get("/concept/#{uuid}")
      end

      # GET /concept/related
      def concepts_relations(uuids: [], names: [], limit: nil, type: nil)
        concepts = (
          names.map { |name| ['concept', name] } +
          uuids.map { |name| ['uui', name] }
        ).reject(&:empty?)

        query = to_params(limit: limit, type: type).to_a.concat(concepts)

        request.get('/concept/related', query: query)
      end

      # GET /concept/{uuid}/terms
      def concept_terms(concept_uuid, offset: nil, limit: nil)
        query = to_params(offset: offset, limit: limit)

        request.get("/concept/#{concept_uuid}/terms", query: query)
      end

      # GET /concept/{uuid}/related/{type}
      def concept_relations(concept_uuid, type, offset: nil, limit: nil)
        query = to_params(offset: offset, limit: limit)

        request.get("/concept/#{concept_uuid}/related/#{type}", query: query)
      end

      # GET /terms
      def terms(filter: nil, offset: nil, limit: nil, type: nil)
        query = to_params(filter: filter, offset: offset, limit: limit, type: type)

        request.get('/terms', query: query)
      end

      # GET /{type}/{description}
      def type_description(type, description)
        request.get("/#{type}/#{description}")
      end

      # GET /{type}/{description}/related/{totype}
      def type_description_relations(type, description, relation_type)
        request.get("/#{type}/#{description}/related/#{relation_type}")
      end

      # POST /text-to-structure
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
