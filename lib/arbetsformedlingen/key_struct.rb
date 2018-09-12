# frozen_string_literal: true

module Arbetsformedlingen
  class KeyStruct < Struct
    def initialize(**keyword_args)
      keyword_args.each do |key, value|
        unless members.include?(key)
          raise ArgumentError, "Unknown key struct member: #{key}"
        end

        self[key] = value
      end
    end
  end
end
