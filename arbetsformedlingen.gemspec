# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'arbetsformedlingen/version'

Gem::Specification.new do |spec|
  spec.name          = "arbetsformedlingen"
  spec.version       = Arbetsformedlingen::VERSION
  spec.authors       = ["Jacob Burenstam"]
  spec.email         = ["burenstam@gmail.com"]

  spec.summary       = %q{Arbetsförmedlingen API client}
  spec.description   = %q{Arbetsförmedlingen API client (Swedish Public Employment Service)}
  spec.homepage      = "https://github.com/buren/arbetsformedlingen"
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
