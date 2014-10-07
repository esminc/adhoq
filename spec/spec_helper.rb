ENV['RAILS_ENV'] ||= 'test'
require_relative 'dummy/config/environment'

require 'rspec/rails'
require 'factory_girl_rails'

require 'pry-byebug'

Rails.backtrace_cleaner.remove_silencers!
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f }

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.use_transactional_fixtures = true
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.warnings = ENV['SHOW_WARNING']

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.profile_examples = 10
  config.order = :random

  config.include FactoryGirl::Syntax::Methods
  Kernel.srand config.seed
end
