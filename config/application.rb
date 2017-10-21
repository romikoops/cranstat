require_relative 'boot'

require 'rails'

require 'active_model/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'

Bundler.require(*Rails.groups)
Dotenv::Railtie.load
HOSTNAME = ENV['HOSTNAME']

module Cranstat
  class Application < Rails::Application
    config.load_defaults 5.1
    config.generators do |g|
      g.system_tests false
      g.helper false
      g.assets false
      g.view_specs false
      g.test_framework :rspec,
                       fixtures: true,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false,
                       controller_specs: false,
                       request_specs: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end
  end
end
