module Arbetsformedlingen
  ApplicationMethodSchema = Dry::Validation.Params do
    configure do
      config.type_specs = true
      config.messages_file = File.expand_path('../../../../config/locales/errors.yml', __FILE__)

      predicates(Predicates)
    end

    required(:external, Types::Bool).filled
    required(:summary, Types::StrippedString).filled
    required(:url, Types::StrippedString).filled(:url?)
  end

  class ApplicationMethod < Model
    def initialize(hash)
      super(ApplicationMethodSchema.call(hash))
    end
  end
end
