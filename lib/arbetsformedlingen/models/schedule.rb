module Arbetsformedlingen
  ScheduleSchema = Dry::Validation.Form do
    configure do
      config.type_specs = true
      config.messages_file = File.expand_path('../../../../config/locales/errors.yml', __FILE__)

      predicates(Predicates)
    end

    required(:summary, Types::StrippedString).filled
    required(:full_time, Types::Strict::Bool).filled
    required(:position_duration_code, Types::PositionDuration).filled
    required(:start_date, Types::StrippedString).filled(:yyyy_mm_dd?)

    optional(:end_date, Types::StrippedString)
  end

  class Schedule < Model
    DURATION_MAP = {
      regular: -1,
      from_0_days_to_10_days: 8,
      from_11_days_to_3_months: 7,
      from_june_to_august: 4, # summer months (June to August)
      from_3_months_to_6_months: 3,
      from_6_months_to_longer: 2
    }.freeze

    def initialize(hash)
      data = hash.dup
      data[:position_duration_code] = duration_code(data[:start_date], data[:end_date])
      data[:full_time] = data[:position_duration_code] == DURATION_MAP[:full_time]
      super(ScheduleSchema.call(data))
    end

    private

    def duration_code(start_date, end_date)
      return DURATION_MAP.fetch(:regular) if end_date.nil?

      days = end_date - start_date

      return DURATION_MAP.fetch(:from_0_days_to_10_days) if days <= 10
      return DURATION_MAP.fetch(:from_11_days_to_3_months) if days > 10 && days < 92
      return DURATION_MAP.fetch(:from_june_to_august) if summer_job?(start_date, end_date)
      return DURATION_MAP.fetch(:from_3_months_to_6_months) if days >= 92 && days < 183

      DURATION_MAP.fetch(:from_6_months_to_longer)
    end

    def summer_job?(start_date, end_date)
      start_date.month == 6 && start_date.day == 1 &&
        end_date.month == 8 && end_date.day == 31
    end
  end
end
