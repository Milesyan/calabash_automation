# Requiring this file will import Calabash and the Calabash predefined Steps.
require 'calabash-cucumber/cucumber'

# To use Calabash without the predefined Calabash Steps, uncomment these
# three lines and delete the require above.
# require 'calabash-cucumber/wait_helpers'
# require 'calabash-cucumber/operations'
# World(Calabash::Cucumber::Operations)


ENV['SCREENSHOT_PATH'] = "./features/screenshots/"
ENV["APP_BUNDLE_PATH"] = 'path/to/your/app'
ENV["DEVICE_TARGET"] ='iPhone 6 (9.0)'


require_relative 'app'
require_relative 'pages'

include Glow
GLOW_PASSWORD = "Glow12345"
