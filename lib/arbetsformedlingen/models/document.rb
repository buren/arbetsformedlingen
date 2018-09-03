require 'securerandom'

module Arbetsformedlingen
  DocumentSchema = Dry::Validation.Params do
    configure do
      config.type_specs = true
      config.messages_file = File.expand_path('../../../../config/locales/errors.yml', __FILE__)

      predicates(Predicates)
    end

    required(:id, Types::UUIDString).filled
    required(:timestamp, :string).filled(:iso8601_date?)
    required(:customer_id, Types::StrippedString).filled
    required(:email, Types::StrippedString).filled(:str?, :email?)
  end

  class Document < Model
    def initialize(hash)
      data = {
        id: SecureRandom.uuid,
        timestamp: Time.now.utc.iso8601
      }.merge!(hash)

      super(DocumentSchema.call(data))
    end
  end
end
