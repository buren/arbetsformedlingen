require 'csv'

module Arbetsformedlingen
  class MunicipalityCode
    CODE_MAP = CSV.read(
      File.expand_path('../../../../data/municipality-codes.csv', __FILE__)
    ).to_h.freeze
    CODES_MAP_INVERTED = CODE_MAP.invert.freeze

    def self.to_code(name)
      normalized = normalize(name)
      CODE_MAP.fetch(normalized) do
        normalized if CODES_MAP_INVERTED[normalized]
      end
    end

    def self.valid?(name)
      !to_code(name).nil?
    end

    def self.normalize(name)
      name.to_s.strip
    end
  end
end
