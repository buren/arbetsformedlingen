# frozen_string_literal: true

module Arbetsformedlingen
  CompanySchema = Dry::Validation.Params do
    configure do
      config.type_specs = true
      config.messages_file = File.expand_path('../../../config/locales/errors.yml', __dir__)

      predicates(Predicates)
    end

    required(:name, Types::StrippedString).filled
    required(:cin, Types::CIN).filled(:str?, :cin?)

    optional(:description, Types::StrippedString).filled

    required(:address).schema do
      required(:municipality, Types::Municipality).filled(:municipality?)
      required(:country_code, Types::Country).filled(:str?, :country_code?)
      required(:street, Types::StrippedString).filled
      required(:city, Types::StrippedString).filled
      required(:zip, Types::Zip).filled(:str?, :zip?)
    end
  end

  class Company < Model
    def initialize(hash)
      super(CompanySchema.call(hash))
    end

    def to_h
      hash = super
      address = hash.fetch(:address)
      hash[:address][:full_address] = [
        address.fetch(:street),
        address.fetch(:zip),
        address.fetch(:city),
      ].join(', ')
      hash[:cin_arbetsformedlingen] = cin_arbetsformedlingen(hash.fetch(:cin))
      hash
    end

    # Formats a Company Identification Number the way Arbetsformedlingen likes it
    def cin_arbetsformedlingen(cin)
      String.new(cin.dup).
        delete('-').
        insert(6, '-').
        insert(0, '46-')
    end
  end
end
