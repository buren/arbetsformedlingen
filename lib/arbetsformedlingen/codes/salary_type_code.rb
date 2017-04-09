require 'set'

module Arbetsformedlingen
  class SalaryTypeCode
    CODE_MAP = {
      'fixed' => '1',
      'fixed_and_commission' => '2',
      'commission' => '3'
    }.freeze

    CODES = Set.new(CODE_MAP.values).freeze

    def self.to_code(value)
      CODE_MAP.fetch(value.to_s, nil)
    end

    def self.valid?(value)
      CODES.include?(value.to_s)
    end
  end
end
