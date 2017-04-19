module Arbetsformedlingen
  PublicationSchema = Dry::Validation.Form do
    configure do
      config.type_specs = true
      config.messages_file = File.expand_path('../../../../config/locales/errors.yml', __FILE__)

      predicates(Predicates)
    end

    required(:publish_at_date, :string).filled(:yyyy_mm_dd?)
    required(:name, Types::StrippedString).filled
    required(:email, Types::StrippedString).filled(:str?, :email?)
  end

  class Publication < Model
    def initialize(hash)
      data = hash.dup
      publish_date = data[:publish_at_date] || Time.now.utc

      data[:publish_at_date] = publish_date.strftime('%Y-%m-%d')

      super(PublicationSchema.call(data))
    end
  end
end
