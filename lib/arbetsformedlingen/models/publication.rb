module Arbetsformedlingen
  PublicationSchema = Dry::Validation.Form do
    configure do
      config.type_specs = true
      config.messages_file = File.expand_path('../../../../config/locales/errors.yml', __FILE__)

      predicates(Predicates)
    end

    required(:unpublish_at, :string).filled(:yyyy_mm_dd?)
    required(:name, Types::StrippedString).filled
    required(:email, Types::StrippedString).filled(:str?, :email?)

    optional(:publish_at, :string).filled(:yyyy_mm_dd?)
  end

  class Publication < Model
    def initialize(hash)
      data = hash.dup
      publish_date = data[:publish_at] || Time.now.utc

      data[:publish_at] = publish_date.strftime('%Y-%m-%d')
      data[:unpublish_at] = data[:unpublish_at]&.strftime('%Y-%m-%d')

      # TODO: Validate that unpublish_at - publish_at is not greater that 180 days

      super(PublicationSchema.call(data))
    end
  end
end
