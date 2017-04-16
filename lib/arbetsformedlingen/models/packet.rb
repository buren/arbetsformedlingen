require 'builder'

module Arbetsformedlingen
  PacketSchema = Dry::Validation.Form do
    configure do
      config.type_specs = true
      config.messages_file = File.expand_path('../../../../config/locales/errors.yml', __FILE__)

      predicates(Predicates)
    end

    required(:active, Types::Bool).filled
    required(:job_id, Types::StrippedString).filled
    required(:id, Types::StrippedString).filled
    required(:number_to_fill, Types::Int).filled(gt?: 0)
    required(:ssyk_id, Types::Int).filled(:ssyk_id?)
  end

  class Packet < Model
    def initialize(attributes:, publication:, document:, position:)
      hash = attributes
      @publication = publication
      @document = document
      @position = position
      super(PacketSchema.call(hash.merge(id: hash[:job_id])))
    end

    def to_h
      hash = super
      hash[:publication] = @publication.to_h
      hash[:document] = @document.to_h
      hash[:position] = @position.to_h
      hash
    end
  end
end
