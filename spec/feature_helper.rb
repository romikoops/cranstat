require 'rails_helper'

# related modules moved separately
require Rails.root.join('spec', 'support', 'features', 'capybara.rb')

Dir[Rails.root.join('spec', 'support', 'features', '**', '*.rb')].each { |f| require f }
