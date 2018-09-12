# frozen_string_literal: true

module Arbetsformedlingen
  class Model
    def self.from_schema(schema)
      new(schema)
    end

    attr_reader :schema

    def initialize(schema)
      @schema = schema
    end

    def valid?
      @schema.success?
    end

    def errors
      @schema.errors
    end

    def to_h
      @schema.to_h
    end
  end
end
