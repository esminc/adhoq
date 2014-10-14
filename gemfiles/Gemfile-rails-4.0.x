source 'http://rubygems.org'

gemspec path: '..'

gem 'rails', '~> 4.0.0'
gem 'sass-rails', '~> 4.0.0'
group :test do
  gem 'codeclimate-test-reporter', require: false
end
