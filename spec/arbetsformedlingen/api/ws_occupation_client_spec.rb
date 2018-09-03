require 'spec_helper'

RSpec.describe Arbetsformedlingen::API::WSOccupationClient do
  let(:expected_first_name) do
    # TODO: Use a cassette instead
    'Undersköterska inom vårdavdelning och mottagning'
  end

  describe '#occupation' do
    it 'returns response that includes occupation name', vcr: true do
      client = described_class.new
      response = client.occupation('1')

      first_name = response.xml.css('Name').first.text
      expected = 'Utredare/Kvalificerad handläggare'
      expect(first_name).to eq(expected)
    end
  end

  describe '#occupations' do
    it 'returns response that includes first occupation name', vcr: true do
      client = described_class.new
      response = client.occupations

      first_name = response.xml.css('Name').first.text
      expect(first_name).to eq(expected_first_name)
    end
  end

  describe '#find_occupations' do
    it 'returns response that includes first occupation name', vcr: true do
      client = described_class.new
      response = client.find_occupations('Kall')

      first_name = response.xml.css('Name').first.text
      expect(first_name).to eq('Kallskänka')
    end
  end

  describe '#occupations_short' do
    it 'returns response that includes first occupation name', vcr: true do
      client = described_class.new
      response = client.occupations_short

      first_name = response.xml.css('Name').first.text
      expect(first_name).to eq(expected_first_name)
    end
  end

  describe '#occupations_detailed' do
    it 'returns response that includes first occupation name', vcr: true do
      client = described_class.new
      response = client.occupations_detailed

      first_name = response.xml.css('Name').first.text
      expect(first_name).to eq(expected_first_name)
    end
  end
end
