# frozen_string_literal: true

require 'spec_helper'

require 'arbetsformedlingen/api/ontology_client'

RSpec.describe Arbetsformedlingen::API::OntologyClient do
  describe 'errors' do
    it 'raises error if passed unknown type' do
      client = described_class.new
      expect { client.concepts(type: 'watman') }.to raise_error(ArgumentError)
    end

    it 'works for 404', vcr: true do
      client = described_class.new
      response = client.concept('watman')

      expect(response.code).to eq('404')
      expect(response.json).to eq({})
    end
  end

  describe '#concepts', vcr: true do
    it 'returns correct data' do
      client = described_class.new
      result = client.concepts(filter: 'ruby').json

      expect(result.first['name']).to eq('Ruby')
      expect(result.first['type']).to eq('skill')
    end
  end

  describe '#concept', vcr: true do
    it 'returns correct data' do
      client = described_class.new
      result = client.concept('4808a9d5-f35a-53b7-bb67-16b972c2a1de').json

      expect(result['name']).to eq('Kunder')
      expect(result['type']).to eq('skill')
    end
  end

  describe '#concepts_relations', vcr: true do
    it 'returns correct data' do
      client = described_class.new
      response = client.concepts_relations(
        names: ['ruby', 'ruby on rails'],
        type: 'skill'
      )
      result = response.json

      expect(result['relations'].first['name']).to eq('Redis')
      expect(result['relations'].length).to eq(20)
    end
  end

  describe '#concept_terms', vcr: true do
    it 'returns correct data' do
      client = described_class.new
      result = client.concept_terms('4808a9d5-f35a-53b7-bb67-16b972c2a1de').json

      expect(result['name']).to eq('Kunder')
      expect(result['type']).to eq('skill')
    end
  end

  describe '#concept_relations', vcr: true do
    it 'returns correct data' do
      client = described_class.new
      result = client.concept_relations('4808a9d5-f35a-53b7-bb67-16b972c2a1de', 'trait').json

      expect(result['relations'].first['name']).to eq('Relationssskapande')
      expect(result['relations'].first['type']).to eq('trait')
    end
  end

  describe '#terms', vcr: true do
    it 'returns correct data' do
      client = described_class.new
      result = client.terms(filter: 'ruby').json

      expect(result.first['name']).to eq('ruby')
      expect(result.first['type']).to eq('skill')
    end
  end

  describe '#type_description', vcr: true do
    it 'returns correct data' do
      client = described_class.new
      result = client.type_description('skill', 'ruby').json

      expect(result['uuid']).to eq('035fc466-605e-5684-a106-a458929f27c6')
      expect(result['name']).to eq('Ruby')
      expect(result['type']).to eq('skill')
    end
  end

  describe '#type_description_relations', vcr: true do
    it 'returns correct data' do
      client = described_class.new
      result = client.type_description_relations('skill', 'ruby', 'trait').json

      first_relation = result['relations'].first
      expect(first_relation['name']).to eq('Easy going')
      expect(first_relation['type']).to eq('trait')
    end
  end

  describe '#text_to_structure', vcr: true do
    it 'returns correct data' do
      text = 'Som rekryteringsassistent kommer du att stötta våra rekryterare i olika delar av rekryteringsprocessen. Du kommer bland annat att. Skriva annonser för våra tjänster Göra telefonavstämningar med intressanta kandidater Intervjua kandidater Skriva kandidatpresentationer som sedan skickas till kunder. Skriva arbetsgivarintyg.'
      expected = %w[Arbetsgivarintyg Kunder Rekryterare Rekryteringsassistent]

      client = described_class.new
      result = client.text_to_structure(text).json

      expect(result.map { |e| e['name'] }).to contain_exactly(*expected)
    end
  end
end
