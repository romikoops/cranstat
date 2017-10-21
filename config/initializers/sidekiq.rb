require 'safe_yaml'
SafeYAML::OPTIONS[:default_mode] = :unsafe
SafeYAML::OPTIONS[:deserialize_symbols] = true

sidekiq_redis_url = ENV['REDIS_URL']

Sidekiq.configure_server do |config|
  config.redis = { url: sidekiq_redis_url, size: 2 + ENV['SIDEKIQ_MAX_THREADS'].to_i }
  database_url = ENV['DATABASE_URL']
  if database_url
    ENV['DATABASE_URL'] = "#{database_url}?pool=#{ENV['SIDEKIQ_MAX_THREADS'] || 5}"
    ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
    # Note that as of Rails 4.1 the `establish_connection` method requires
    # the database_url be passed in as an argument. Like this:
    # ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: sidekiq_redis_url, size: 1 }
end

if ENV['SIDEKIQ_INLINE'] == 'true'
  require 'sidekiq/testing'
  Sidekiq::Testing.inline!
end
