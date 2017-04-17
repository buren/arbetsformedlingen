require 'set'

module Arbetsformedlingen
  class ExperienceRequiredCode
    CODES_MAP = {
      'true' => '1',
      'false' => '4'
    }.freeze
    CODES_MAP_INVERTED = CODES_MAP.invert.freeze

    def self.to_code(value)
      CODES_MAP.fetch(value.to_s) do
        CODES_MAP_INVERTED.fetch(value.to_s, nil)
      end
    end

    def self.valid?(value)
      !to_code(value).nil?
    end
  end
end
