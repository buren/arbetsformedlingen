# frozen_string_literal: true

require 'httparty'

require 'dry-validation'
require 'dry-types'

require 'arbetsformedlingen/version'

require 'arbetsformedlingen/models/dry/types'
require 'arbetsformedlingen/models/dry/predicates'

require 'arbetsformedlingen/output_builder'

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

module Arbetsformedlingen
  # curl -X POST \
  #   api.arbetsformedlingen.se/ledigtarbete/apiledigtarbete/test/hrxml \
  #   -d ''

  BASE_URL = 'http://api.arbetsformedlingen.se/ledigtarbete'.freeze
  POST_JOB_URL = "#{BASE_URL}/apiledigtarbete/test/hrxml".freeze

  HEADERS = {
    'Content-type' => 'text/xml'
  }.freeze

  def self.post(xml)
    HTTParty.post(POST_JOB_URL, body: xml, headers: HEADERS)
  end
end
