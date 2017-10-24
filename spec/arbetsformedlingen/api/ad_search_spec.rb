require 'spec_helper'

require 'arbetsformedlingen/api/platsannonser/matchning_client'

RSpec.describe Arbetsformedlingen::Platsannonser::MatchningClient do
  describe '#ads' do
    it 'raises argument error if missing required arguments' do
      client = described_class.new
      expect { client.ads }.to raise_error(ArgumentError)
    end
  end
end
