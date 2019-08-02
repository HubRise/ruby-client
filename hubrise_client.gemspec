$LOAD_PATH.unshift File.expand_path("lib", __dir__)
require "hubrise_client/version"

Gem::Specification.new do |s|
  s.name        = "hubrise_client"
  s.version     = HubriseClient::VERSION
  s.authors     = [
    "Antoine Monnier",
    "Nick Save"
  ]
  s.homepage    = 'https://github.com/HubRise/ruby-client'
  s.summary     = 'HubRise Ruby client'
  s.license     = 'MIT'

  s.files = Dir["lib/**/*", "LICENSE", "Rakefile", "README.md", "V1_ENDPOINTS.md"]

  s.add_development_dependency "rspec"
  s.add_development_dependency "rubocop"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "webmock"
end
