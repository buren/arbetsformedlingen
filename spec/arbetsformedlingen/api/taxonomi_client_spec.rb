# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Arbetsformedlingen::API::TaxonomiClient do
  describe '#occupation_names' do
    let(:sv_lang_id) { 502 }

    it 'returns response that includes first occupation name', vcr: true do
      client = described_class.new
      response = client.occupation_names(language_id: sv_lang_id)

      first_name = response.xml.css('OccupationName Term').first.text
      expect(first_name).to eq('1:e Fartygsingenjör/1:e Maskinist')
    end
  end
end
