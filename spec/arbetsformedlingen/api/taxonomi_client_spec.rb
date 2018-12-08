# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Arbetsformedlingen::API::TaxonomiClient do
  describe '#occupation_names' do
    let(:sv_lang_id) { 502 }

    it 'returns response that includes first occupation name', vcr: true do
      client = described_class.new
      response = client.occupation_names(language_id: sv_lang_id)

      names = response.xml.css('OccupationName Term')
      first_name = names.first.text
      expect(first_name).to eq('1:e Fartygsingenjör/1:e Maskinist')
      expect(names.length).to eq(3262)
    end
  end

  describe '#aid_occupation_names' do
    it 'returns response that includes first AID occupation id', vcr: true do
      client = described_class.new
      response = client.aid_occupation_names

      ids = response.xml.css('AIDOccupationName OccupationNameID')
      first_name = ids.first.text
      expect(first_name).to eq('6818')
      expect(ids.length).to eq(199)
    end
  end

  describe '#continents' do
    let(:sv_lang_id) { 502 }

    it 'returns continents', vcr: true do
      client = described_class.new
      response = client.continents(language_id: sv_lang_id)

      names = response.xml.css('Continent Term')
      first_name = names.first.text
      expect(first_name).to eq('Antarktis')
      expect(names.length).to eq(22)
    end
  end

  describe '#countries' do
    let(:sv_lang_id) { 502 }

    it 'returns countries', vcr: true do
      client = described_class.new
      response = client.countries(language_id: sv_lang_id)
      names = response.xml.css('Country Term')
      first_name = names.first.text
      expect(first_name).to eq('Afghanistan')
      expect(names.length).to eq(250)
    end
  end

  describe '#drivers_licenses' do
    let(:sv_lang_id) { 502 }

    it 'returns drivers_licenses', vcr: true do
      client = described_class.new
      response = client.drivers_licenses(language_id: sv_lang_id)
      names = response.xml.css('DrivingLicence Term')
      first_name = names.first.text
      expect(first_name).to eq('A1')
      expect(names.length).to eq(15)
    end
  end

  describe '#eu_regions' do
    let(:sv_lang_id) { 502 }

    it 'returns eu_regions', vcr: true do
      client = described_class.new
      response = client.eu_regions(language_id: sv_lang_id)
      names = response.xml.css('EURegion Term')
      first_name = names.first.text
      expect(first_name).to eq('A Coruña')
      expect(names.length).to eq(1362)
    end
  end
end
