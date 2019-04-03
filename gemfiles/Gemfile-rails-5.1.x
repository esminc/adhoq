source 'http://rubygems.org'

gemspec path: '..'

gem 'rails', '~> 5.1.2'
group :test do
  gem 'codeclimate-test-reporter', require: false
end
