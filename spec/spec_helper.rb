require 'webmock/rspec'
require 'json'
require 'webmock'
require 'kaminari_rspec'
WebMock.allow_net_connect!
require_relative 'support/spec_helper_rspec'
require 'kaminari_rspec'

include KaminariRspec::TestHelpers


RSpec.configure do |config|

config.include KaminariRspec::TestHelpers, :type => :controller

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.disable_monkey_patching!

  if config.files_to_run.one?
    config.default_formatter = "doc"
  end
  config.profile_examples = 10

  config.order = :random

  Kernel.srand config.seed
end
