module Arbetsformedlingen
  SalarySchema = Dry::Validation.Form do
    configure do
      config.type_specs = true
      config.messages_file = 'config/locales/errors.yml'

      predicates(Predicates)
    end

    required(:summary, Types::StrippedString).filled
    required(:currency, Types::Currency).filled(:str?, :currency?)
    required(:type, Types::SalaryType).filled(:str?, :salary_type?)
  end

  class Salary < Model
    def initialize(hash)
      super(SalarySchema.call(hash))
    end
  end
end
