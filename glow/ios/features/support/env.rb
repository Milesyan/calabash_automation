# Requiring this file will import Calabash and the Calabash predefined Steps.
require 'calabash-cucumber/cucumber'

# To use Calabash without the predefined Calabash Steps, uncomment these
# three lines and delete the require above.
# require 'calabash-cucumber/wait_helpers'
# require 'calabash-cucumber/operations'
# World(Calabash::Cucumber::Operations)


ENV['SCREENSHOT_PATH'] = "./features/screenshots/"
ENV["APP_BUNDLE_PATH"] = '/Users/Miles/automation/AutomationTests/emma/ios/emmadev_3.app'
#ENV["APP_BUNDLE_PATH"] = '/Users/Miles/automation/AutomationTests/emma/ios/emmadev_sandbox.app'

ENV["DEVICE_TARGET"] = "F4F0DFF2-C7DD-4518-9CAA-D3A0AF274438"

require_relative 'app'
require_relative 'pages'

include Glow
GLOW_PASSWORD = "Glow12345"
