source 'https://rubygems.org'

ruby '2.4.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'airbrake'
gem 'clockwork'
gem 'coffee-rails', '~> 4.2'
gem 'faraday'
gem 'jbuilder', '~> 2.5'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.4'
gem 'sass-rails', '~> 5.0'
gem 'sidekiq'
gem 'sinatra', '>= 2.0.0.beta2', '< 3'
gem 'treetop-dcf', require: 'dcf'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'dotenv-rails'
  gem 'factory_girl_rails', require: false
  gem 'ffaker'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 3.6'
  gem 'rubocop'
end

group :development do
  gem 'foreman'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', require: false
  gem 'capybara-screenshot', require: false
  gem 'database_rewinder'
  gem 'fuubar'
  gem 'launchy'
  gem 'rspec_junit_formatter'
  gem 'selenium-webdriver'
  gem 'timecop', require: false
  gem 'turnip', require: false
  gem 'webmock', require: false
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
