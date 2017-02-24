source 'http://rubygems.org'

gemspec path: '..'

gem 'rails', '~> 5.1.0.beta1'
gem 'sass-rails', '~> 6.0.0.beta1'
group :test do
  gem 'codeclimate-test-reporter', require: false
end
