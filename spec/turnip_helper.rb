require 'feature_helper'
Dir.glob('spec/steps/**/*steps.rb') { |f| load f, true }

RSpec.configure do |config|
  config.raise_error_for_unimplemented_steps = true

  config.after(return_to_present_time: true) do
    Timecop.return
  end
end
