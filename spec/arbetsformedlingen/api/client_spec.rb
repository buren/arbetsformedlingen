require 'spec_helper'

require 'arbetsformedlingen/api/client'

RSpec.describe Arbetsformedlingen::API::Client do
  describe '#version', vcr: true do
    it 'returns the version of the API' do
      client = described_class.new

      expect(client.version).to eq('version: 1.0.90')
    end
  end

  describe '#ad', vcr: true do
    it 'returns an ad' do
      client = described_class.new

      page_size = 30
      ad = client.ad(id: 7333612)

      expect(ad.id).not_to be_nil
      expect(ad.title).not_to be_nil
      expect(ad.body).not_to be_nil
      expect(ad.occupation).not_to be_nil
      expect(ad.occupation_id).not_to be_nil
      expect(ad.municipality).not_to be_nil
      expect(ad.municipality_id).not_to be_nil
      expect(ad.published_at).not_to be_nil
      expect(ad.total_vacancies).not_to be_nil
      expect(ad.total_vacancies_with_visa).not_to be_nil
      expect(ad.url).not_to be_nil
      expect(ad.employment_type).not_to be_nil

      expect(ad.terms).not_to be_nil
      expect(ad.application).not_to be_nil
      expect(ad.workplace).not_to be_nil

      # check terms
      terms = ad.terms

      expect(terms.duration).not_to be_nil
      expect(terms.working_hours).not_to be_nil
      expect(terms.working_hours_description).not_to be_nil
      expect(terms.salary_type).not_to be_nil
      expect(terms.salary_form).not_to be_nil

      # check application
      application = ad.application

      expect(application.reference).not_to be_nil
      expect(application.application_url).not_to be_nil
      expect(application.last_application_at).not_to be_nil
      expect(application.application_comment).not_to be_nil

      # check workplace
      workplace = ad.workplace

      expect(workplace.name).not_to be_nil
      expect(workplace.postal).not_to be_nil
      expect(workplace.country).not_to be_nil
      expect(workplace.visit_address).not_to be_nil
      expect(workplace.logotype_url).not_to be_nil
      expect(workplace.website).not_to be_nil
      expect(workplace.contacts).to be_a(Array)

      # check workplace postal
      postal = ad.workplace.postal

      expect(postal.code).not_to be_nil
      expect(postal.address).not_to be_nil
      expect(postal.city).not_to be_nil
      expect(postal.country).not_to be_nil

      # check requirements
      requirements = ad.requirements

      expect(requirements.own_car).to eq(false)
    end
  end

  describe '#ads', vcr: true do
    it 'returns a list of ads' do
      client = described_class.new

      page_size = 30
      county = client.ads(county_id: 1, page_size: page_size)

      expect(county.list_name).to eq('annonser')
      expect(county.raw_data).to be_a(Hash)
      expect(county.total_ads).not_to be_nil
      expect(county.list_name).not_to be_nil
      expect(county.total_vacancies_on_page).not_to be_zero
      expect(county.data.length).to eq(page_size)
      expect(county.data).to be_a(Array)

      result = county.data.first

      expect(result.id).not_to be_nil
      expect(result.title).not_to be_nil
      expect(result.occupation).not_to be_nil
      expect(result.occupation_id).not_to be_nil
      expect(result.company).not_to be_nil
      expect(result.municipality).not_to be_nil
      expect(result.municipality_id).not_to be_nil
      expect(result.published_at).not_to be_nil
      expect(result.last_application_at).not_to be_nil
      expect(result.url).not_to be_nil
      expect(result.relevance).not_to be_nil
      expect(result.total_vacancies).not_to be_nil
      expect(result.total_vacancies_with_visa).not_to be_nil
      expect(result.duration_id).not_to be_nil
      expect(result.county).not_to be_nil
      expect(result.country_id).not_to be_nil
      expect(result.employment_type).not_to be_nil
    end
  end

  describe '#areas', vcr: true do
    it 'returns a list of areas' do
      client = described_class.new

      county = client.areas

      expect(county.list_name).to eq('omrade')
      expect(county.raw_data).to be_a(Hash)
      expect(county.total_ads).not_to be_nil
      expect(county.list_name).not_to be_nil
      expect(county.total_vacancies).not_to be_nil
      expect(county.data.length).to eq(21)
      expect(county.data).to be_a(Array)

      result = county.data.first

      expect(result.id).to eq('8')
      expect(result.name).to eq('Antarktis')
      expect(result.total_ads).not_to be_nil
      expect(result.total_vacancies).not_to be_nil
    end
  end

  describe '#countries', vcr: true do
    it 'returns a list of countries' do
      client = described_class.new

      county = client.countries(area_id: 2)

      expect(county.list_name).to eq('land')
      expect(county.raw_data).to be_a(Hash)
      expect(county.total_ads).not_to be_nil
      expect(county.list_name).not_to be_nil
      expect(county.total_vacancies).not_to be_nil
      expect(county.data.length).to eq(33)
      expect(county.data).to be_a(Array)

      result = county.data.first

      expect(result.id).to eq('21')
      expect(result.name).to eq('Belgien')
      expect(result.total_ads).not_to be_nil
      expect(result.total_vacancies).not_to be_nil
    end
  end

  describe '#municipality', vcr: true do
    it 'returns a list of municipality' do
      client = described_class.new

      county = client.municipality

      expect(county.list_name).to eq('kommuner')
      expect(county.raw_data).to be_a(Hash)
      expect(county.total_ads).not_to be_nil
      expect(county.list_name).not_to be_nil
      expect(county.total_vacancies).not_to be_nil
      expect(county.data.length).to eq(47)
      expect(county.data).to be_a(Array)

      result = county.data.first

      expect(result.id).to eq('10165')
      expect(result.name).to eq('Albertslund')
      expect(result.total_ads).not_to be_nil
      expect(result.total_vacancies).not_to be_nil
    end
  end

  describe '#county', vcr: true do
    it 'returns a list of county' do
      client = described_class.new

      county = client.county

      expect(county.list_name).to eq('lan')
      expect(county.raw_data).to be_a(Hash)
      expect(county.total_ads).not_to be_zero
      expect(county.list_name).not_to be_nil
      expect(county.total_vacancies).not_to be_zero
      expect(county.data.length).to eq(22)
      expect(county.data).to be_a(Array)

      result = county.data.first

      expect(result.id).to eq('10')
      expect(result.name).to eq('Blekinge län')
      expect(result.total_ads).not_to be_nil
      expect(result.total_vacancies).not_to be_nil
    end
  end

  describe '#county2', vcr: true do
    it 'returns a list of county2' do
      client = described_class.new

      county = client.county2

      expect(county.list_name).to eq('lan2')
      expect(county.raw_data).to be_a(Hash)
      expect(county.total_ads).not_to be_zero
      expect(county.list_name).not_to be_nil
      expect(county.total_vacancies).not_to be_zero
      expect(county.data.length).to eq(23)
      expect(county.data).to be_a(Array)

      result = county.data.first

      expect(result.id).to eq('199')
      expect(result.name).to eq('Utomlands')
      expect(result.total_ads).not_to be_nil
      expect(result.total_vacancies).not_to be_nil
    end
  end

  describe '#occupational_field', vcr: true do
    it 'returns a list of occupational_field' do
      client = described_class.new

      field = client.occupational_field

      expect(field.list_name).to eq('yrkesomraden')
      expect(field.raw_data).to be_a(Hash)
      expect(field.total_ads).not_to be_zero
      expect(field.list_name).not_to be_nil
      expect(field.total_vacancies).not_to be_zero
      expect(field.data.length).to eq(21)
      expect(field.data).to be_a(Array)

      result = field.data.first

      expect(result.id).to eq('1')
      expect(result.name).to eq('Administration, ekonomi, juridik')
      expect(result.total_ads).not_to be_nil
      expect(result.total_vacancies).not_to be_nil
    end
  end

  describe '#occupational_group', vcr: true do
    it 'returns a list of occupational_group' do
      client = described_class.new

      group = client.occupational_group

      expect(group.list_name).to eq('yrkesgrupper')
      expect(group.raw_data).to be_a(Hash)
      expect(group.total_ads).not_to be_zero
      expect(group.list_name).not_to be_nil
      expect(group.total_vacancies).not_to be_zero
      expect(group.data.length).to eq(400)
      expect(group.data).to be_a(Array)

      result = group.data.first

      expect(result.id).to eq('2611')
      expect(result.name).to eq('Advokater')
      expect(result.total_ads).not_to be_nil
      expect(result.total_vacancies).not_to be_nil
    end
  end

  describe '#occupation', vcr: true do
    it 'returns an occupation' do
      client = described_class.new

      occupations = client.occupation(name: 'Marknadskommunikatör')

      expect(occupations.list_name).to eq('Yrken')
      expect(occupations.raw_data).to be_a(Hash)
      expect(occupations.total_ads).not_to be_zero
      expect(occupations.list_name).not_to be_nil
      expect(occupations.total_vacancies).not_to be_nil
      expect(occupations.data.length).to eq(1)
      expect(occupations.data).to be_a(Array)

      result = occupations.data.first

      expect(result.id).to eq('406')
      expect(result.name).to eq('Marknadskommunikatör')
      expect(result.total_ads).not_to be_nil
      expect(result.total_vacancies).not_to be_nil
    end
  end

  describe '#occupations', vcr: true do
    it 'returns a list of occupations' do
      client = described_class.new

      occupations = client.occupations

      expect(occupations.list_name).to eq('yrken')
      expect(occupations.raw_data).to be_a(Hash)
      expect(occupations.total_ads).not_to be_zero
      expect(occupations.list_name).not_to be_nil
      expect(occupations.total_vacancies).not_to be_zero
      expect(occupations.data.length).to eq(3262)
      expect(occupations.data).to be_a(Array)

      result = occupations.data.first

      expect(result.id).to eq('5370')
      expect(result.name).to eq('1:e Fartygsingenjör/1:e Maskinist')
      expect(result.total_ads).not_to be_nil
      expect(result.total_vacancies).not_to be_nil
    end
  end
end
