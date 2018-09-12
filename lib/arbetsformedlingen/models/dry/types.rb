# frozen_string_literal: true

module Arbetsformedlingen
  module Types
    include Dry::Types.module

    StrippedString = Types::Strict::String.constructor { |value| value.to_s.strip }
    UUIDString = Types::Strict::String.constrained(size: 36)
    Currency = Types::Strict::String.constructor do |string|
      string&.strip&.upcase
    end
    # Company Identification Number
    CIN = Types::Strict::String.constructor do |string|
      string&.delete(' ')&.delete('-')
    end
    Zip = Types::Strict::String.constructor do |string|
      string&.delete(' ')
    end
    Municipality = Types::Strict::String.constructor do |string|
      MunicipalityCode.to_code(string)
    end
    Country = Types::Strict::String.constructor do |string|
      CountryCode.to_code(string)
    end
    Occupation = Types::Strict::String.constructor do |string|
      OccupationCode.to_code(string)
    end
    PositionDuration = Types::Strict::Integer
    DriversLicense = Types::Strict::String.constructor do |value|
      DriversLicenseCode.to_code(value)
    end
    SalaryType = Types::Strict::String.constructor do |value|
      SalaryTypeCode.to_code(value)
    end
    ExperienceRequired = Types::Strict::String.constructor do |value|
      ExperienceRequiredCode.to_code(value)
    end
  end
end
