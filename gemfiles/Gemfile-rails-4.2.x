source 'http://rubygems.org'

gemspec path: '..'

if Gem::Version.create(RUBY_VERSION) < Gem::Version.create('2.3.0')
  # fog-core 1.44 depends xmlrpc, requires Ruby version >= 2.3.0
  gem 'fog-core', '< 1.44.0'
end

if Gem::Version.create(RUBY_VERSION) < Gem::Version.create('2.2.2')
  # nio4r 2 requires Ruby version >= 2.2.2
  gem 'nio4r', '< 2.0.0'

  # Rack 2 requires Ruby version >= 2.2.2
  gem 'rack', '~> 1.6.0'
end

gem 'rails', '~> 4.2.0'
group :test do
  gem 'codeclimate-test-reporter', require: false
end
