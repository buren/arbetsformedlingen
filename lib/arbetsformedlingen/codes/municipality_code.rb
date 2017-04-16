require 'csv'
require 'set'

module Arbetsformedlingen
  class MunicipalityCode
    CODE_MAP = CSV.read(
      File.expand_path('../../../../data/municipality-codes.csv', __FILE__)
    ).to_h.freeze
    CODES = Set.new(CODE_MAP.values).freeze

    def self.to_code(name)
      CODE_MAP.fetch(normalize(name), nil)
    end

    def self.valid?(name)
      CODES.include?(normalize(name))
    end

    def self.normalize(name)
      name.to_s.strip
    end
  end
end
