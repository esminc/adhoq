$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "adhoq/core/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "adhoq-core"
  s.version     = Adhoq::Core::VERSION
  s.authors     = ['Kyosuke MOROHASHI', 'Tomohiro Hashidate']
  s.email       = ['moronatural@gmail.com']
  s.homepage    = 'https://github.com/esminc/adhoq'
  s.summary     = 'DB management console in the wild.'
  s.description = 'generate instant reports from adhoc SQL query.'
  s.license     = "MIT"

  s.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  s.bindir        = "exe"
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'axlsx', '~> 2.0'
  s.add_dependency 'fog',   '~> 1.23'
  s.add_dependency 'activesupport', '>= 3.2'
  s.add_dependency 'activerecord', '>= 3.2'

  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'pry-byebug'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'simple_xlsx_reader'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'tapp'

  s.test_files = Dir['spec/{adhoq,factories,models,support}/**/*', 'spec/spec_helper.rb']
end
