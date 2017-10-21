ENV['RAILS_ENV'] ||= 'test'

require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'timecop'
require 'ffaker'
require 'capybara/rails'

ActiveRecord::Migration.maintain_test_schema!

require 'webmock'
require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f unless f.include?('features/') }

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
