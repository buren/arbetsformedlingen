# frozen_string_literal: true

require 'spec_helper'

require 'arbetsformedlingen/routes'

RSpec.describe Arbetsformedlingen::Routes do
  subject { described_class.new }
  let(:base_url) { 'http://api.arbetsformedlingen.se/' }

  it 'can read routes file' do
    expect(subject.routes).to be_a(Hash)
  end

  it 'has base url' do
    expect(subject.base_url).to include(base_url)
  end

  it 'returns route with base url' do
    expect(subject.draw(:version)).to include(base_url)
  end

  it 'has ::build method' do
    expect(subject.draw(:version)).to include(base_url)
  end

  it 'returns route for jobs' do
    result = subject.draw(:version)
    expected = "#{base_url}platsannonser/version"
    expect(result).to eq(expected)
  end
end
