require 'spec_helper'

require 'arbetsformedlingen/api/platsannons/ad_search'

RSpec.describe Arbetsformedlingen::Platsannons::AdSearch do
  describe '::search' do
    it 'raises argument error if missing required arguments' do
      client = described_class.new
      expect { client.search }.to raise_error(ArgumentError)
    end
  end
end
