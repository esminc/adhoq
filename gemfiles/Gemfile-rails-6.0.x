source 'http://rubygems.org'

gemspec path: '..'

gem 'rails', '~> 6.0.0.beta3'
group :test do
  gem 'codeclimate-test-reporter', require: false
end
