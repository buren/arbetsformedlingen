# frozen_string_literal: true

require 'builder'
require 'arbetsformedlingen/models/packet_xml_builder'

module Arbetsformedlingen
  PacketSchema = Dry::Validation.Params do
    configure do
      config.type_specs = true
      config.messages_file = File.expand_path('../../../config/locales/errors.yml', __dir__)

      predicates(Predicates)
    end

    required(:active, Types::Bool).filled
    required(:job_id, Types::StrippedString).filled
    required(:id, Types::StrippedString).filled
    required(:number_to_fill, Types::Integer).filled(gt?: 0)
    required(:occupation, Types::Occupation).filled(:occupation_code?)
  end

  class Packet < Model
    DEFAULT_PACKET_ID = 1

    def initialize(attributes:, publication:, document:, position:)
      hash = attributes
      @publication = publication
      @document = document
      @position = position
      id = hash.fetch(:id, DEFAULT_PACKET_ID)
      super(PacketSchema.call(hash.merge(id: id)))
    end

    def to_h
      hash = super
      hash[:publication] = @publication.to_h
      hash[:document] = @document.to_h
      hash[:position] = @position.to_h
      hash
    end

    def to_xml
      PacketXMLBuilder.new(self).to_xml
    end
  end
end
