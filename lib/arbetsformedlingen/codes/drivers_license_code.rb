# frozen_string_literal: true

require 'set'

module Arbetsformedlingen
  module DriversLicenseCode
    CODES = Set.new([
                      'AM', 'A1', 'A2', 'A', 'B', 'Utökad B', 'BE',
                      'C1', 'C1E', 'C', 'CE', 'D1', 'D1E', 'D', 'DE'
                    ]).freeze

    def self.codes
      CODES.to_a
    end

    def self.to_code(drivers_license)
      normalize(drivers_license)
    end

    def self.valid?(drivers_license)
      to_a(drivers_license).all? { |dl| CODES.include?(dl) }
    end

    def self.normalize(drivers_license)
      to_a(drivers_license).join(',')
    end

    def self.to_a(drivers_license)
      drivers_license.to_s.
        split(',').
        map(&:strip).
        reject(&:empty?).
        map(&:upcase)
    end
  end
end
