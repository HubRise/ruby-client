$LOAD_PATH.unshift File.expand_path("lib", __dir__)
require "hubrise_ruby_lib/version"

Gem::Specification.new do |s|
  s.name        = "hubrise_ruby_lib"
  s.version     = HubriseRubyLib::VERSION
  s.date        = "2015-06-03"
  s.summary     = "Hubrise API helper"
  s.description = "Hubrise API helper ruby library"
  s.authors     = [
    "Antoine Monnier",
    "Nick Save"
  ]
  s.files = [
    "lib/hubrise_ruby_lib.rb",
    "lib/hubrise_ruby_lib/api_response.rb",
    "lib/hubrise_ruby_lib/api_clients/base.rb",
    "lib/hubrise_ruby_lib/api_clients/v1.rb"
  ]

  s.add_development_dependency "rspec"
  s.add_development_dependency "rubocop"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "webmock"
end
