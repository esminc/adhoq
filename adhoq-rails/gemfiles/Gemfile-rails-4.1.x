source 'http://rubygems.org'

gem 'adhoq-core', path: '../../adhoq-core'
gemspec path: '..'

gem 'rails', '~> 4.1.0'
group :test do
  gem 'codeclimate-test-reporter', require: false
end
