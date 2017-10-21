require 'rubygems'
require 'clockwork'
require_relative './boot'
require_relative './environment'

module Clockwork
  error_handler do |error|
    Airbrake.notify(error)
  end

  TIME_ZONE = 'Etc/UTC'.freeze

  every(
    1.day,
    'Extract packages from CRAN server',
    at: '12:00',
    tz: TIME_ZONE
  ) { ExtractPackagesWorker.perform_async }
end
