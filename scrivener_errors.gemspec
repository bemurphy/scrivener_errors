lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'scrivener_errors'

Gem::Specification.new do |s|
  s.name        = "scrivener_errors"
  s.version     = ScrivenerErrors::VERSION
  s.summary     = "Basic error messages for Scrivener filters"
  s.description = s.summary
  s.authors     = ["Brendon Murphy"]
  s.email       = ["xternal1+github@gmail.com"]
  s.homepage    = "http://github.com/bemurphy/scrivener_errors"
  s.license     = "MIT"

  s.files = Dir[
    "LICENSE",
    "README.md",
    "Rakefile",
    "lib/**/*.rb",
    "*.gemspec",
    "test/**/*.rb"
  ]
  s.require_paths = ["lib"]

  s.add_development_dependency "cutest", "~> 1.2"
  s.add_development_dependency "scrivener", "~> 0.2"
end
