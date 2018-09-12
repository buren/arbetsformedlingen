# frozen_string_literal: true

require 'csv'
require 'set'

module Arbetsformedlingen
  class CountryCode
    CODES = CSV.read(
      File.expand_path('../../../data/country-codes.csv', __dir__)
    ).to_h.freeze

    COUNTRY_CODES = Set.new(CODES.values).freeze

    def self.to_code(country_code)
      normalize(country_code)
    end

    def self.valid?(country_code)
      COUNTRY_CODES.include?(normalize(country_code))
    end

    def self.normalize(country_code)
      country_code.to_s.upcase
    end
  end
end
