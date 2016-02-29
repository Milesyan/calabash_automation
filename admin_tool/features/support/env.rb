require 'capybara'
require 'capybara/dsl'
require 'selenium/webdriver'
require_relative 'user'
require_relative 'pages'
require_relative 'helper'

include Capybara::DSL

$host = "http://admindash.glowing.com"

Capybara.register_driver :selenium do |app|
  client = Selenium::WebDriver::Remote::Http::Default.new
  client.timeout = 120 
  Capybara::Selenium::Driver.new(app, :browser => :firefox, http_client: client)
end

Capybara.configure do |c|
  c.default_driver = :selenium
  c.app_host = $host
end