ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'factory_bot_rails'
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)


RSpec.configure do |config|
  config.include Rails.application.routes.url_helpers
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.strategy = :deletion
  end
  
  config.before(:each) do
    DatabaseCleaner.start
    Rails.cache.clear
    Rails.application.load_seed
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end

  config.mock_with :mocha

  config.order = :random
end

RSpec::Matchers.define_negated_matcher :not_change, :change
RSpec::Matchers.define :be_error_response_of do |expected|
  match { |actual| expected.name == actual.to_mash.name rescue false }
  failure_message { "expected that actual would be a response of #{expected.name}" }
  description { "be error response of #{expected.name}" }
end