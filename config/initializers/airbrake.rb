# rubocop:disable Metrics/BlockLength
Airbrake.configure do |c|
  c.project_id = ENV.fetch('AIRBRAKE_PROJECT_ID', nil)
  c.project_key = ENV.fetch('AIRBRAKE_PROJECT_KEY', nil)
  c.root_directory = Rails.root
  c.logger = Rails.logger
  c.environment = Rails.env
  c.ignore_environments = %w[test development]
  c.blacklist_keys = [/password/i]
end

Airbrake.add_filter do |notice|
  platform_error_types = [
    'Net::ReadTimeout',
    'PG::ConnectionBad',
    'ActiveRecord::ConnectionTimeoutError',
    'Faraday::ConnectionFailed',
    'SignalException' # Heroku dyno restarts
  ]
  rails_error_types = [
    'ActiveRecord::RecordNotFound',
    'ActiveRecord::RecordInvalid',
    'ActionController::RoutingError',
    'ActionController::InvalidAuthenticityToken',
    'ActionController::UnknownAction',
    'ActionController::UnknownHttpMethod',
    'AbstractController::ActionNotFound'
  ]

  white_list_messages = [
    'getaddrinfo: Name or service not known',
    'the server responded with status 503',
    'the server responded with status 504'
  ]

  block = proc do |error|
    white_list_error_types = [
      platform_error_types,
      rails_error_types
    ].flatten

    white_list_error_types.include?(error[:type]) ||
      white_list_messages.any? { |msg| error[:message].include?(msg) }
  end

  notice.ignore! if notice[:errors].any?(&block)
end
# rubocop:enable Metrics/BlockLength
