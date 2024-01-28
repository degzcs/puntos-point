require 'factory_bot'
require 'database_cleaner'
require 'warden/test/helpers'
require 'warden/test/mock'

FactoryBot.find_definitions

RSpec.configure do |config|
  config.before(:suite) do
    ActiveSupport::Deprecation.silenced = true
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.include FactoryBot::Syntax::Methods
  config.include Warden::Test::Helpers
  config.include Warden::Test::Mock
end
