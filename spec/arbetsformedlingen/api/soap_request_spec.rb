# frozen_string_literal: true

require 'spec_helper'

require 'arbetsformedlingen/api/soap_request'

RSpec.describe Arbetsformedlingen::API::SOAPRequest do
  describe '#initialize' do
    it 'raises ArgumentError if Nokogiri constant is not defined' do
      allow(Object).to receive(:const_defined?).and_return(false)
      expect { described_class.new('') }.to raise_error(ArgumentError)
    end

    it 'does not raise ArgumentError if Nokogiri constant is defined' do
      expect { described_class.new('') }.not_to raise_error(ArgumentError)
    end
  end
end
