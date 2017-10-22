require 'spec_helper'

RSpec.describe Arbetsformedlingen::Client do
  def stub_client_get_request(response_body: '')
    url = Arbetsformedlingen::Client::ROUTES.fetch(:test_post_job_url)
    stub_request(:post, url).
       with(headers: { 'Content-Type' => 'text/xml' }).
       to_return(status: 200, body: response_body, headers: {})
  end

  describe '::post_job' do
    it 'returns a non valid response if passed empty string' do
      stub_client_get_request(response_body: '')
      response = Arbetsformedlingen::Client.post_job('')
      expect(response.valid?).to eq(false)
    end
  end
end
