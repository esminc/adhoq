source 'http://rubygems.org'

gemspec path: '..'

gem 'activerecord', '~> 4.0.0'
group :test do
  gem 'codeclimate-test-reporter', require: false
end
