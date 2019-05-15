source 'http://rubygems.org'

gemspec path: '..'

gem 'rails', '~> 6.0.0.rc1'
group :test do
  gem 'codeclimate-test-reporter', require: false
end
