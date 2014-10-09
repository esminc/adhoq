$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "adhoq/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "adhoq"
  s.version     = Adhoq::VERSION
  s.authors     = ['Kyosuke MOROHASHI']
  s.email       = ['moronatural@gmail.com']
  s.homepage    = 'https://github.com/esminc/adhoq'
  s.summary     = 'DB management console in the wild.'
  s.description = 'Rails engine to generate instant reports from adhoc SQL query.'
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE.txt", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 3.2"

  s.add_dependency 'axlsx', '~> 2.0'
  s.add_dependency 'coffee-rails'
  s.add_dependency 'fog',   '~> 1.23'
  s.add_dependency 'font-awesome-sass'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'sass-rails'
  s.add_dependency 'slim-rails'

  s.add_development_dependency 'capybara', '~> 2.4.3'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'launchy'
  s.add_development_dependency 'poltergeist', '~> 1.5.1'
  s.add_development_dependency 'pry-byebug'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'simple_xlsx_reader'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'tapp'

  s.test_files = Dir['spec/{adhoq,factories,models,support}/**/*', 'spec/spec_helper.rb']
end
