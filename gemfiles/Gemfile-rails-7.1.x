source 'https://rubygems.org'

gemspec path: '..'

gem 'rails', '~> 7.1.0'
gem 'rackup', '~> 1.0'  # Provides Rack::Handler compatibility for Rack 3 (needed by Capybara < 3.40)
