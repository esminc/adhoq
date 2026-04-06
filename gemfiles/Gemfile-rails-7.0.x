source 'https://rubygems.org'

gemspec path: '..'

gem 'rails', '~> 7.0.0'

group :test do
  gem 'webrick'
end
