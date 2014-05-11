Gem::Specification.new do |s|
  s.name        = "scrivener_errors"
  s.version     = "0.0.4"
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

  s.add_development_dependency "cutest", "~> 1.2"
  s.add_development_dependency "scrivener", "~> 0.2"
end
