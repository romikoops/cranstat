require 'capybara'
require 'capybara/rspec'
require 'capybara-screenshot'
require 'capybara-screenshot/rspec'
require 'selenium/webdriver'

Capybara.register_driver :selenium do |app|
  args = %w[start-maximized window-size=1920x1080]
  args << 'headless' unless ENV['REAL_BROWSER'] == 'true'
  options = Selenium::WebDriver::Chrome::Options.new(args: args)
  params = { browser: :chrome, options: options }
  Capybara::Selenium::Driver.new app, params
end

# use webkit if requested
Capybara.asset_host = 'http://localhost:3000'
Capybara.default_max_wait_time = 4

Capybara.save_path = 'tmp/capybara'
Capybara::Screenshot.register_driver(:chrome) do |driver, path|
  driver.browser.save_screenshot path
end
Capybara::Screenshot.register_filename_prefix_formatter(:rspec) do |example|
  prefix = SecureRandom.random_number(1_000_000)
  "#{prefix}-#{example.description.tr(' ', '-').gsub(%r{^.*/spec/}, '').split('->').last.downcase}"
end
