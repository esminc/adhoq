require 'adhoq-core'

require 'database_cleaner'
require 'pry-byebug'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f }

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: ":memory:"
)

# Test Class
class User < ActiveRecord::Base
end

ActiveRecord::Migration.verbose = false
ActiveRecord::Migrator.migrate File.expand_path("../db/migrate", __FILE__), nil

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.warnings = ENV['SHOW_WARNING']

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.profile_examples = 10
  config.order = :random

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
