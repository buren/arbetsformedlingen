require 'time'

module Arbetsformedlingen
  module Predicates
    include Dry::Logic::Predicates

    predicate(:iso8601_date?) do |value|
      begin
        Time.iso8601(value)
      rescue ArgumentError => _e
        false
      end
    end

    predicate(:yyyy_mm_dd?) do |value|
      begin
        Date.strptime(value, '%Y-%m-%d')
      rescue ArgumentError => _e
        false
      end
    end

    predicate(:email?) do |value|
      value.include?('@') && value.include?('.')
    end

    predicate(:currency?) do |value|
      value.length == 3
    end

    predicate(:zip?) do |value|
      value.length == 5
    end

    predicate(:cin?) do |value|
      value.length == 10
    end

    predicate(:municipality?) do |value|
      MunicipalityCode.valid?(value)
    end

    predicate(:salary_type?) do |value|
      SalaryTypeCode.valid?(value)
    end

    predicate(:experience_required?) do |value|
      ExperienceRequiredCode.valid?(value)
    end

    predicate(:country_code?) do |value|
      CountryCode.valid?(value)
    end

    predicate(:drivers_license?) do |value|
      DriversLicenseCode.valid?(value)
    end

    predicate(:occupation_code?) do |value|
      OccupationCode.valid?(value)
    end

    predicate(:url?) do |value|
      value.include?('https://') || value.include?('http://')
    end
  end
end
