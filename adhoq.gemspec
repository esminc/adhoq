$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "adhoq/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "adhoq"
  s.version     = Adhoq::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Adhoq."
  s.description = "TODO: Description of Adhoq."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE.txt", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 4.1.6"

  s.add_dependency 'axlsx'
  s.add_dependency 'coffee-rails'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'sass-rails'
  s.add_dependency 'slim-rails'

  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'pry-byebug'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'simple_xlsx_reader'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'tapp'

  s.test_files = Dir['spec/**/*']
end
