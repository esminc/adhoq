source 'https://rubygems.org'

gemspec path: '..'

gem 'rails', '~> 8.1.0'

group :test do
  gem 'webrick'
end
