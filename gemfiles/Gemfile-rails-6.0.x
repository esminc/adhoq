source 'http://rubygems.org'

gemspec path: '..'

gem 'rails', '~> 6.0.0.rc1'
gem 'sqlite3', '>= 1.4'
group :test do
  gem 'codeclimate-test-reporter', require: false
end
