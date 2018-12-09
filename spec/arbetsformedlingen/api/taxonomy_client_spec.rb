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
      method_name: :occupation_names_art,
      args: { language_id: 502 },
      css: 'OccupationName Term',
      expected: { value: 'Akrobat', length: 178 },
    },
    {
      method_name: :locale_group_skills,
      css: 'LocaleGroupSkill LocaleCode',
      expected: { value: '0110', length: 13334 },
    },
    {
      method_name: :locale_groups,
      args: { language_id: 502 },
      css: 'LocaleGroup Term',
      expected: { value: 'Officerare', length: 400 },
    },
    {
      method_name: :locale_level3,
      args: { language_id: 502 },
      css: 'LocaleLevel3 Term',
      expected: { value: 'Andra bevaknings- och säkerhetsyrken', length: 147 },
    },
    {
      method_name: :municipalities,
      args: { language_id: 502 },
      css: 'Municipality NationalNUTSLAU2Code',
      expected: { value: '1440', length: 290 },
    },
    {
      method_name: :municipality_homepages,
      css: 'MunicipalityHomePage Url',
      expected: { value: 'http://www.upplandsvasby.se/', length: 290 },
    },
    {
      method_name: :occupation_name_synonyms,
      args: { language_id: 502 },
      css: 'OccupationNameSynonym SynonymTerm',
      expected: { value: 'Sjöman', length: 1577 },
    },
    {
      method_name: :occupation_name_versions,
      args: { language_id: 502 },
      css: 'OccupationNameExt Term',
      expected: { value: '1:e Fartygsingenjör/1:e Maskinist', length: 4595 },
    },
    {
      method_name: :post_codes,
      args: { language_id: 502 },
      css: 'PostCode Code',
      expected: { value: '10005', length: 17389 },
    },
    {
      method_name: :post_localities,
      args: { language_id: 502 },
      css: 'PostLocality Term',
      expected: { value: 'Abbekås', length: 1742 },
    },
    {
      method_name: :sni_level1,
      args: { language_id: 502 },
      css: 'SNILevel1 Term',
      expected: { value: 'Jordbruk, skogsbruk och fiske', length: 21 },
    },
    {
      method_name: :sni_level2,
      args: { language_id: 502 },
      css: 'SNILevel2 Term',
      expected: { value: 'Service till utvinning', length: 90 },
    },
    {
      method_name: :sun_field1,
      args: { language_id: 502 },
      css: 'SUNField1 Term',
      expected: { value: 'Allmän utbildning', length: 10 },
    },
    {
      method_name: :sun_field2,
      args: { language_id: 502 },
      css: 'SUNField2 Term',
      expected: { value: 'Bred, generell utbildning', length: 26 },
    },
    {
      method_name: :sun_field3,
      args: { language_id: 502 },
      css: 'SUNField3 Term',
      expected: { value: 'Bred, generell utbildning', length: 117 },
    },
    {
      method_name: :sun_level1,
      args: { language_id: 502 },
      css: 'SUNLevel1 Term',
      expected: { value: 'Saknar formell, grundläggande utbildning', length: 7 },
    },
    {
      method_name: :sun_level2,
      args: { language_id: 502 },
      css: 'SUNLevel2 Term',
      expected: { value: 'Förskoleutbildning', length: 14 },
    },
    {
      method_name: :sun_level3,
      args: { language_id: 502 },
      css: 'SUNLevel3 Term',
      expected: { value: 'Övrig/ospec förskoleutbildning', length: 50 },
    },
    {
      method_name: :skill_headlines,
      args: { language_id: 502 },
      css: 'SkillHeadline Term',
      expected: { value: 'Datakunskaper', length: 104 },
    },
    {
      method_name: :skill_main_headlines,
      args: { language_id: 502 },
      css: 'SkillMainHeadline Term',
      expected: { value: 'Datakunskaper', length: 2 },
    },
    {
      method_name: :skills,
      args: { language_id: 502 },
      css: 'SkillHeadline Term',
      expected: { value: 'Övriga kompetensrubriker', length: 11028 },
    },
    {
      method_name: :skill_versions,
      args: { language_id: 502 },
      css: 'SkillVersion SkillHeadline Term',
      expected: { value: 'Övriga kompetensrubriker', length: 12138 },
    },
    {
      method_name: :unemployment_benefit_societies,
      args: { language_id: 502 },
      css: 'UnemploymentBenefitSociety Code',
      expected: { value: '00', length: 28 },
    },
    {
      method_name: :wage_types,
      args: { language_id: 502 },
      css: 'WageType Term',
      expected: { value: 'Fast månads- vecko- eller timlön', length: 3 },
    },
    {
      method_name: :work_time_extents,
      args: { language_id: 502 },
      css: 'WorkTimeExtent Term',
      expected: { value: 'Heltid', length: 3 },
    },
    {
      method_name: :eu_regions_by_country,
      args: { language_id: 502, country_id: 199 },
      css: 'EURegion Term',
      expected: { value: 'Blekinge län', length: 21 },
    },
    {
      method_name: :isco_by_locale_code,
      args: { locale_code: 2421 },
      css: 'GetISCOByLocaleCodeResult string',
      expected: { value: '2421', length: 1 },
    },
    {
      method_name: :isco_by_iso2_code,
      args: { iso2_code: nil },
      css: 'GetLanguageIDByISO2CodeResult',
      expected: { value: '10265', length: 1 },
    },
    {
      method_name: :locale_code_by_isco,
      args: { isco: 2421 },
      css: 'GetLocaleCodeByISCOResult string',
      expected: { value: '2421', length: 2 },
    },
    {
      method_name: :locale_fields_by_locale_code,
      args: { language_id: 502, locale_code: 2421 },
      css: 'LocaleField Term',
      expected: { value: 'Administration, ekonomi, juridik', length: 1 },
    },
    {
      method_name: :locale_fields_by_text,
      args: { language_id: 502, text: 'A' },
      css: 'LocaleField Term',
      expected: { value: 'Administration, ekonomi, juridik', length: 18 },
    },
    {
      method_name: :locale_group_by_occupation_name_id,
      args: { language_id: 502, occupation_name_id: 6818 },
      css: 'Term',
      expected: { value: 'General-, landstings- och kommundirektörer m.fl.', length: 1 },
    },
    {
      method_name: :locale_group_skills_by_locale_code,
      args: { locale_code: 2421 },
      css: 'LocaleGroupSkill SkillID',
      expected: { value: '870', length: 37 },
    },
    {
      method_name: :locale_groups_by_locale_field_id,
      args: { language_id: 502, locale_field_id: 1 },
      css: 'LocaleGroup Term',
      expected: { value: 'Statistiker', length: 39 },
    },
    {
      method_name: :locale_groups_by_text,
      args: { language_id: 502, text: 'A' },
      css: 'LocaleGroup Term',
      expected: { value: 'Officerare', length: 338 },
    },
    {
      method_name: :occupation_names_by_locale_code,
      args: { language_id: 502, locale_code: 2421 },
      css: 'OccupationName Term',
      expected: { value: 'Administrativ utvecklare', length: 13 },
    },
    {
      method_name: :occupation_names_by_text,
      args: { language_id: 502, text: 'A' },
      css: 'OccupationName Term',
      expected: { value: '1:e Fartygsingenjör/1:e Maskinist', length: 2654 },
    },
    {
      method_name: :occupation_names_construction,
      args: { language_id: 502 },
      css: 'OccupationName Term',
      expected: { value: 'Anläggningsdykare', length: 168 },
    },
    {
      method_name: :occupation_names_navigation,
      args: { language_id: 502 },
      css: 'OccupationName Term',
      expected: { value: '1:e Fartygsingenjör/1:e Maskinist', length: 30 },
    },
    {
      method_name: :post_codes_by_municipality,
      args: { language_id: 502, municipality_id: 1440 },
      css: 'PostCode Code',
      expected: { value: '44172', length: 63 },
    },
    {
      method_name: :post_codes_by_post_code,
      args: { language_id: 502, post_code: 11846 },
      css: 'PostCode PostLocality',
      expected: { value: 'Stockholm', length: 1 },
    },
    {
      method_name: :post_codes_by_post_locality,
      args: { language_id: 502, post_locality_id: 0 },
      css: 'PostCode PostLocality',
      expected: { value: 'Stockholm', length: 17389 },
    },
    {
      method_name: :sun_field3_by_guide,
      args: { language_id: 502, sun_level1_id: 1 },
      css: 'SUNField3 Term',
      expected: { value: 'Bred, generell utbildning', length: 1 },
    },
    {
      method_name: :sun_guide_tree,
      args: { language_id: 502 },
      css: 'SUNGuideBranch SUNLevel1 Term',
      expected: { value: 'Saknar formell, grundläggande utbildning', length: 7 },
    },
    {
      method_name: :version_information,
      css: 'VersionInformation Version',
      expected: { value: '1', length: 1 },
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
