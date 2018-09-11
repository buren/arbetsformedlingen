require 'spec_helper'

require 'arbetsformedlingen/api/response'

RSpec.describe Arbetsformedlingen::API::Response do
  describe '#success?' do
    it 'returns true when response code is 200' do
      response = described_class.new(Struct.new(:code).new('200'))

      expect(response.success?).to eq(true)
    end

    it 'returns false when response code is 500' do
      response = described_class.new(Struct.new(:code).new('500'))

      expect(response.success?).to eq(false)
    end
  end

  context 'delegates missing' do
    it 'returns response value' do
      response = described_class.new(Struct.new(:some_method).new(true))

      expect(response.some_method).to eq(true)
    end

    it 'raises when no method does not exist on response' do
      response = described_class.new(Struct.new(:some_method).new(true))

      expect do
        response.other_method
      end.to raise_error(NoMethodError)
    end
  end
end
