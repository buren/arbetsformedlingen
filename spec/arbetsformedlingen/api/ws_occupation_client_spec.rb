# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Arbetsformedlingen::API::WSOccupationClient do
  let(:expected_first_name) do
    # TODO: Use a cassette instead
    'Supporttekniker, IT'
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

  describe '#locale_groups' do
    it 'returns response that includes first occupation name', vcr: true do
      client = described_class.new
      response = client.locale_groups(461)

      first_name = response.xml.css('GetLocaleGroupsResult').first.text
      expect(first_name).to eq('1405#Marknadsanalytiker och marknadsförare m.fl.')
    end
  end

  describe '#platsbanken_link' do
    it 'returns response that includes first occupation name', vcr: true do
      client = described_class.new
      response = client.platsbanken_link(1405)

      first_name = response.xml.css('GetPlatsbankenLinkResult').first.text
      expect(first_name).to eq('/4.4d99301a154fd3fb8df3aca3.html#/?yrkesgrupper=2431|0')
    end
  end

  describe '#education_connections' do
    it 'returns education connections', vcr: true do
      client = described_class.new
      response = client.education_connections

      result = response.xml.css('LoadAllEducationConnectionsResult').first.text
      expect(result.start_with?("571\tinfo.ky")).to eq(true)
    end
  end

  describe '#occupations_id_and_name' do
    it 'returns occupations containing id and name information', vcr: true do
      client = described_class.new
      response = client.occupations_id_and_name

      result = response.xml.css('LoadAllOccupationIdAndNameResult').first.text
      expect(result.start_with?("571\tAdministratör/sekreteraryrken")).to eq(true)
    end
  end

  describe '#article' do
    it 'returns empty result for unknown id', vcr: true do
      client = described_class.new
      response = client.article(3)

      result = response.xml.css('GetArticleResult')
      expect(result.length).to eq(1)
      expect(result.css('Id')).to be_empty
    end
  end
end
