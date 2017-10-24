require 'bundler/setup'
require 'arbetsformedlingen'

require 'vcr'
require 'webmock/rspec'

# Only allow the tests to connect to localhost and  allow codeclimate
# codeclimate (for test coverage reporting)
# WebMock.disable_net_connect!(allow_localhost: true, allow: 'codeclimate.com')

Arbetsformedlingen.configure do |config|
  config.test = true
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
