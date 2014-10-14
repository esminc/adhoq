source 'http://rubygems.org'

gemspec path: '..'

gem 'rails', '~> 3.2.0'
gem 'strong_parameters'
group :test do
  gem 'codeclimate-test-reporter', require: false
end
