# frozen_string_literal: true

require 'httparty'

require 'dry-validation'
require 'dry-types'

require 'arbetsformedlingen/version'

require 'arbetsformedlingen/key_struct'

require 'arbetsformedlingen/codes/country_code'
require 'arbetsformedlingen/codes/drivers_license_code'
require 'arbetsformedlingen/codes/experience_required_code'
require 'arbetsformedlingen/codes/municipality_code'
require 'arbetsformedlingen/codes/occupation_code'
require 'arbetsformedlingen/codes/salary_type_code'

require 'arbetsformedlingen/models/dry/types'
require 'arbetsformedlingen/models/dry/predicates'

require 'arbetsformedlingen/models/model'
require 'arbetsformedlingen/models/document'
require 'arbetsformedlingen/models/company'
require 'arbetsformedlingen/models/publication'
require 'arbetsformedlingen/models/position'
require 'arbetsformedlingen/models/qualification'
require 'arbetsformedlingen/models/salary'
require 'arbetsformedlingen/models/schedule'
require 'arbetsformedlingen/models/application_method'
require 'arbetsformedlingen/models/packet'

# API Client
require 'arbetsformedlingen/api/client'
require 'arbetsformedlingen/api/ws_occupation_client'
require 'arbetsformedlingen/api/taxonomi_client'

module Arbetsformedlingen
  class << self
    attr_accessor :config
  end

  def self.configure
    self.config ||= Configuration.new
    block_given? ? yield(config) : config
  end

  class Configuration
    attr_accessor :test

    def initialize
      @test = false
    end
  end
end

Arbetsformedlingen.configure
