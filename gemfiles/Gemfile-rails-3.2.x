source 'http://rubygems.org'

gemspec path: '..'

gem 'rails', '~> 3.2.0'

gem 'font-awesome-sass', '4.2.0'
gem 'strong_parameters'

gem 'test-unit'

group :test do
  gem 'codeclimate-test-reporter', require: false
end
