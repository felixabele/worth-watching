require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/cassettes'
  c.ignore_localhost = true
  c.configure_rspec_metadata!
  c.hook_into :webmock
end
