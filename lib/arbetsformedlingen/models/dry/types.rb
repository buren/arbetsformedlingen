module Arbetsformedlingen
  module Types
    include Dry::Types.module

    StrippedString = Types::Strict::String.constructor { |value| value.to_s.strip }
    UUIDString = Types::Strict::String.constrained(size: 36)
    Currency = Types::Strict::String.constructor do |string|
      string.strip.upcase if string
    end
    # Company Identification Number
    CIN = Types::Strict::String.constructor do |string|
      string.delete(' ').delete('-') if string
    end
    Zip = Types::Strict::String.constructor do |string|
      string.delete(' ') if string
    end
    Municipality = Types::Strict::String.constructor do |string|
      MunicipalityCode.to_code(string)
    end
    Country = Types::Strict::String.constructor do |string|
      CountryCode.to_code(string)
    end
    PositionDuration = Types::Strict::Int
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
