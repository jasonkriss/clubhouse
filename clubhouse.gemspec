$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "clubhouse/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "clubhouse"
  s.version     = Clubhouse::VERSION
  s.authors     = ["Jason Kriss"]
  s.email       = ["jasonkriss@gmail.com"]
  s.homepage    = "https://github.com/jasonkriss/clubhouse"
  s.summary     = "Organizations and memberships for your Rails API"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.2.0"
  s.add_dependency "active_model_serializers", "0.10.0.rc2"
  s.add_dependency "pg"
  s.add_dependency "email_validator"
  s.add_dependency "servitore"
  s.add_dependency "punditry"

  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "shoulda-matchers"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "pollett"
end
