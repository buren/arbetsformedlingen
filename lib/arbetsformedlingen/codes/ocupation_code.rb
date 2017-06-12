require 'csv'

module Arbetsformedlingen
  class OcupationCode
    CODE_MAP = CSV.read(
      File.expand_path('../../../../data/ocupation-codes.csv', __FILE__)
    ).to_h.invert.freeze
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

    def self.to_form_array(name_only: false)
      return CODE_MAP.to_a unless name_only

      CODE_MAP.map { |name, _code| [name, name] }
    end
  end
end
