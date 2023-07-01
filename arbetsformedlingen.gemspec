# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'arbetsformedlingen/version'

Gem::Specification.new do |spec|
  spec.name          = 'arbetsformedlingen'
  spec.version       = Arbetsformedlingen::VERSION
  spec.authors       = ['Jacob Burenstam']
  spec.email         = ['burenstam@gmail.com']

  spec.summary       = 'Arbetsförmedlingen API client'
  spec.description   = 'Arbetsförmedlingen API client (Swedish Public Employment Service). Post job ads, Platsannons (ads) API client and WSOccupation SOAP API client.'
  spec.homepage      = 'https://github.com/buren/arbetsformedlingen'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = %w[lib config]

  spec.add_dependency 'builder', '~> 3.2'
  spec.add_dependency 'dry-validation', '~> 0.12'
  spec.add_dependency 'httparty', '~> 0.13' # Easy HTTP requests

  spec.add_development_dependency 'bundler', '> 1.14', '< 3'
  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'nokogiri', '~> 1.8'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.8'
  spec.add_development_dependency 'rubocop', '~> 1.4'
  spec.add_development_dependency 'vcr', '~> 6.2'
  spec.add_development_dependency 'webmock', '~> 3.1'
end
