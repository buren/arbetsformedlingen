module Arbetsformedlingen
  PositionSchema = Dry::Validation.Form do
    configure do
      config.type_specs = true
      config.messages_file = File.expand_path('../../../../config/locales/errors.yml', __FILE__)

      predicates(Predicates)
    end

    required(:title, Types::StrippedString).filled
    required(:purpose, Types::StrippedString).filled
    required(:address).schema do
      required(:municipality, Types::Municipality).filled(:municipality?)
      required(:country_code, Types::Country).filled(:str?, :country_code?)

      optional(:street, Types::StrippedString).filled
      optional(:city, Types::StrippedString).filled
      optional(:zip, Types::Zip).filled(:str?, :zip?)
    end
  end

  class Position < Model
    def initialize(attributes:, company:, schedule:, salary:, qualifications:, application_method:)
      hash = attributes
      @company = company
      @schedule = schedule
      @salary = salary
      @qualifications = qualifications
      @application_method = application_method

      super(PositionSchema.call(hash))
    end

    def to_h
      hash = super
      hash[:company] = @company.to_h
      hash[:schedule] = @schedule.to_h
      hash[:salary] = @salary.to_h
      hash[:qualifications] = @qualifications.map(&:to_h)
      hash[:application_method] = @application_method.to_h
      hash
    end
  end
end
