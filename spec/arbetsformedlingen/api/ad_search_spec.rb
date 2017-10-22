require 'spec_helper'

require 'arbetsformedlingen/api/ad_search'

RSpec.describe Arbetsformedlingen::API::AdSearch do
  describe '::search' do
    it 'raises argument error if missing required arguments' do
      client = described_class.new
      expect { client.search }.to raise_error(ArgumentError)
    end
  end
end
