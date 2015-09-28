source 'http://rubygems.org'

gemspec path: '..'

gem 'activerecord', '~> 3.2.0'

gem 'test-unit'

group :test do
  gem 'codeclimate-test-reporter', require: false
end
