require 'spec_helper'

require 'arbetsformedlingen/api/ws_occupation_client'

RSpec.describe Arbetsformedlingen::API::WSOccupationClient do
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
      expected = 'Landskapsarkitekter och landskapsingenjörer'
      expect(first_name).to eq(expected)
    end
  end

  describe '#occupations_short' do
    it 'returns response that includes first occupation name', vcr: true do
      client = described_class.new
      response = client.occupations_short

      first_name = response.xml.css('Name').first.text
      expected = 'Landskapsarkitekter och landskapsingenjörer'
      expect(first_name).to eq(expected)
    end
  end

  describe '#occupations_detailed' do
    it 'returns response that includes first occupation name', vcr: true do
      client = described_class.new
      response = client.occupations_detailed

      first_name = response.xml.css('Name').first.text
      expected = 'Landskapsarkitekter och landskapsingenjörer'
      expect(first_name).to eq(expected)
    end
  end
end
