# frozen_string_literal: true

require 'set'

module Arbetsformedlingen
  class ExperienceRequiredCode
    CODES_MAP = {
      'true' => '1',
      'false' => '4',
    }.freeze
    CODES_MAP_INVERTED = CODES_MAP.invert.freeze

    def self.to_code(value)
      CODES_MAP.fetch(value.to_s) do
        value.to_s if CODES_MAP_INVERTED[value.to_s]
      end
    end

    def self.valid?(value)
      !to_code(value).nil?
    end
  end
end
