source 'http://rubygems.org'

gemspec path: '..'

gem 'rails', '~> 4.2.0'
group :test do
  gem 'codeclimate-test-reporter', require: false
end
