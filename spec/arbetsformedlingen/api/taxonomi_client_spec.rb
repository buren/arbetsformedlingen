# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Arbetsformedlingen::API::TaxonomiClient do
  [
    {
      method_name: :occupation_names,
      args: { language_id: 502  },
      css: 'OccupationName Term',
      expected: { value: '1:e Fartygsingenjör/1:e Maskinist', length: 3262 }
    },
    {
      method_name: :aid_occupation_names,
      css: 'AIDOccupationName OccupationNameID',
      expected: { value: '6818', length: 199 }
    },
    {
      method_name: :continents,
      args: { language_id: 502  },
      css: 'Continent Term',
      expected: { value: 'Antarktis', length: 22 }
    },
    {
      method_name: :countries,
      args: { language_id: 502  },
      css: 'Country Term',
      expected: { value: 'Afghanistan', length: 250 }
    },
    {
      method_name: :drivers_licenses,
      args: { language_id: 502  },
      css: 'DrivingLicence Term',
      expected: { value: 'A1', length: 15 }
    },
    {
      method_name: :eu_regions,
      args: { language_id: 502  },
      css: 'EURegion Term',
      expected: { value: 'A Coruña', length: 1362 }
    },
  ].each do |data|
    method = data.fetch(:method_name)
    expected = data.fetch(:expected)

    describe "##{method}" do
      it "returns #{method}", vcr: true do
        client = described_class.new
        response = if data.key?(:args)
                     client.public_send(method, **data.fetch(:args))
                   else
                     client.public_send(method)
                   end

        ids = response.xml.css(data.fetch(:css))
        first_name = ids.first.text
        expect(first_name).to eq(expected.fetch(:value))
        expect(ids.length).to eq(expected.fetch(:length))
      end
    end
  end
end
