require 'spec_helper'
require 'rspec/core'
require 'capybara/dsl'
require 'capybara/rspec/matchers'
require 'capybara/rspec/features'
require 'capybara/rspec/matcher_proxies'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?

ActiveRecord::Migration.maintain_test_schema!
require 'rspec/rails'
require "capybara/rspec"
RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.raise_errors_for_deprecations!
  config.include(Shoulda::Matchers::ActiveModel, type: :model)
  config.include(Shoulda::Matchers::ActiveRecord, type: :model)
  config.include FactoryBot::Syntax::Methods
  config.include Capybara::DSL, type: :feature
  config.include Capybara::RSpecMatchers, type: :feature
  config.include Capybara::RSpecMatchers, type: :view
  config.after do
    if self.class.include?(Capybara::DSL)
      Capybara.reset_sessions!
      Capybara.use_default_driver
    end
  end
  config.before do
    if self.class.include?(Capybara::DSL)
      example = RSpec.current_example
      Capybara.current_driver = Capybara.javascript_driver if example.metadata[:js]
      Capybara.current_driver = example.metadata[:driver] if example.metadata[:driver]
    end
  end
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::TestHelpers, :type => :controller
end
