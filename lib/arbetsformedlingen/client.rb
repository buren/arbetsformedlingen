require 'arbetsformedlingen/response'

module Arbetsformedlingen
  class Client
    BASE_URL = 'http://api.arbetsformedlingen.se/ledigtarbete'.freeze
    ROUTES = {
      post_job_url: "#{BASE_URL}/apiledigtarbete/hrxml",
      test_post_job_url: "#{BASE_URL}/apiledigtarbete/test/hrxml"
    }.freeze

    HEADERS = {
      'Content-type' => 'text/xml'
    }.freeze

    def self.post_job(xml)
      response = HTTParty.post(post_job_url, body: xml, headers: HEADERS)
      Response.new(response, xml)
    end

    def self.post_job_url
      return ROUTES.fetch(:test_post_job_url) if Arbetsformedlingen.config.test
      ROUTES.fetch(:post_job_url)
    end
  end
end
