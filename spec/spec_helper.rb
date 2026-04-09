ENV['RAILS_ENV'] ||= 'test'
require_relative 'dummy/config/environment'

require 'rspec/rails'

require 'capybara/rspec'
require 'selenium-webdriver'
require 'database_cleaner'
require 'factory_bot_rails'
require 'pry-byebug'

# factory_bot_rails 6.x resolves factory paths relative to Rails.root
# (spec/dummy) and calls find_definitions during after_initialize, before
# spec_helper continues. Re-add the gem root's spec/factories and reload.
FactoryBot.definition_file_paths.unshift File.expand_path('factories', __dir__)
FactoryBot.reload

Rails.backtrace_cleaner.remove_silencers!
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f }

Capybara.register_driver :chrome_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless=new')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('--disable-gpu')
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.default_driver = :chrome_headless

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.use_transactional_fixtures = false
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.warnings = ENV['SHOW_WARNING']

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.profile_examples = 10
  config.order = :random

  config.include FactoryBot::Syntax::Methods
  Kernel.srand config.seed

  config.around(:each, :fog_mock) do |example|
    begin
      Fog.mock!
      Fog::Mock.reset

      example.run
    ensure
      Fog.unmock!
    end
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with :truncation
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
