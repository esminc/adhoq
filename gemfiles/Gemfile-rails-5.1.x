source 'http://rubygems.org'

gemspec path: '..'

gem 'rails', '~> 5.1.0'
gem 'sass-rails', '~> 5.0.0'
group :test do
  gem 'codeclimate-test-reporter', require: false
end