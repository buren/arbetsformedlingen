# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Arbetsformedlingen::API::TaxonomyClient do
  [
    {
      method_name: :occupation_names,
      args: { language_id: 502 },
      css: 'OccupationName Term',
      expected: { value: '1:e Fartygsingenjör/1:e Maskinist', length: 3262 },
    },
    {
      method_name: :aid_occupation_names,
      css: 'AIDOccupationName OccupationNameID',
      expected: { value: '6818', length: 199 },
    },
    {
      method_name: :continents,
      args: { language_id: 502 },
      css: 'Continent Term',
      expected: { value: 'Antarktis', length: 22 },
    },
    {
      method_name: :countries,
      args: { language_id: 502 },
      css: 'Country Term',
      expected: { value: 'Afghanistan', length: 250 },
    },
    {
      method_name: :drivers_licenses,
      args: { language_id: 502 },
      css: 'DrivingLicence Term',
      expected: { value: 'A1', length: 15 },
    },
    {
      method_name: :eu_regions,
      args: { language_id: 502 },
      css: 'EURegion Term',
      expected: { value: 'A Coruña', length: 1362 },
    },
    {
      method_name: :employment_durations,
      args: { language_id: 502 },
      css: 'EmploymentDuration Term',
      expected: { value: 'Tillsvidare', length: 5 },
    },
    {
      method_name: :employment_types,
      args: { language_id: 502 },
      css: 'EmploymentType Term',
      expected: { value: 'Vanlig anställning', length: 4 },
    },
    {
      method_name: :experiences_last,
      args: { language_id: 502 },
      css: 'OccupationExperienceLast OccupationExperienceLastID',
      expected: { value: '1', length: 28 },
    },
    {
      method_name: :experiences_year,
      args: { language_id: 502 },
      css: 'OccupationExperienceYear OccupationExperienceYearID',
      expected: { value: '1', length: 5 },
    },
    {
      method_name: :aido_occupation_names,
      args: { label: '101010' },
      css: 'GetAIDOccupationNameByLabelResult OccupationNameID',
      expected: { value: '6818', length: 1 },
    },
    {
      method_name: :internal_job_situations,
      css: 'JobSituation Term',
      expected: { value: 'Öppet arbetslös', length: 49 },
    },
    {
      method_name: :job_situations,
      args: { language_id: 502 },
      css: 'JobSituation Term',
      expected: { value: 'Arbetslös/Studerande', length: 5 },
    },
    {
      method_name: :language_levels,
      args: { language_id: 502 },
      css: 'LanguageLevel Term',
      expected: { value: 'Lite', length: 4 },
    },
    {
      method_name: :languages,
      args: { language_id: 502 },
      css: 'Language Term',
      expected: { value: 'Abkhasiska', length: 435 },
    },
    {
      method_name: :locale_fields,
      args: { language_id: 502 },
      css: 'LocaleField Term',
      expected: { value: 'Administration, ekonomi, juridik', length: 21 },
    },
    {
      method_name: :municipalities,
      args: { language_id: 502 },
      css: 'Municipality NationalNUTSLAU2Code',
      expected: { value: '1440', length: 290 },
    },
    {
      method_name: :occupation_names_art,
      args: { language_id: 502 },
      css: 'OccupationName Term',
      expected: { value: 'Akrobat', length: 178 },
    },
    {
      method_name: :sun_guide_tree,
      args: { language_id: 502 },
      css: 'SUNGuideBranch SUNLevel1 Term',
      expected: { value: 'Saknar formell, grundläggande utbildning', length: 7 },
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