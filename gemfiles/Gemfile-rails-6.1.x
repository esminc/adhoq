source 'https://rubygems.org'

gemspec path: '..'

gem 'rails', '~> 6.1.0'
gem 'logger', '< 1.6'    # logger 1.6+ breaks Rails 6.0/6.1 (LoggerThreadSafeLevel::Logger uninitialized)
gem 'sqlite3', '~> 1.4'  # sqlite3 2.0+ is incompatible with Rails < 7.1

if RUBY_VERSION < '2.7'
  gem 'factory_bot_rails', '< 6.3'         # 6.3+ requires factory_bot ~> 6.4
  gem 'factory_bot',       '< 6.4'         # 6.4+ uses ... (argument forwarding) syntax (Ruby 2.7+)
  gem 'puma',              '< 6'           # Puma 6+ removed Puma::Events.strings used by Capybara
end
