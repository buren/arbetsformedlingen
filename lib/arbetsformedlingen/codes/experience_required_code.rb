module Arbetsformedlingen
  class ExperienceRequiredCode
    CODES = {
      'true' => '1',
      'false' => '4'
    }.freeze

    def self.to_code(value)
      CODES.fetch(value.to_s, nil)
    end

    def self.valid?(value)
      !to_code(value).nil?
    end
  end
end
