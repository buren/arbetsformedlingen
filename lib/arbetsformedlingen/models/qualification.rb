module Arbetsformedlingen
  QualificationSchema = Dry::Validation.Form do
    configure do
      config.type_specs = true
      config.messages_file = File.expand_path('../../../../config/locales/errors.yml', __FILE__)

      predicates(Predicates)
    end

    required(:required, Types::Bool).filled
    required(:drivers_license, Types::DriversLicense).filled(:drivers_license?)

    optional(:car, Types::Bool).filled(:bool?)
    optional(:summary, Types::StrippedString).filled
    optional(:experience, Types::ExperienceRequired).filled(:experience_required?)
  end

  class Qualification < Model
    def initialize(hash)
      super(QualificationSchema.call(hash))
    end

    def to_h
      # TODO: Add proper support for #drivers_license attribute (enum)
      super
    end
  end
end
