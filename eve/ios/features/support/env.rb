# Requiring this file will import Calabash and the Calabash predefined Steps.
require 'calabash-cucumber/cucumber'
require 'minitest/autorun'
require 'active_support/all'

require_relative '../../../www/public/eve_ios_forum_test'
require_relative 'app'
require_relative 'pages'


# To use Calabash without the predefined Calabash Steps, uncomment these
# three lines and delete the require above.
# require 'calabash-cucumber/wait_helpers'
# require 'calabash-cucumber/operations'
# World(Calabash::Cucumber::Operations)



ENV['SCREENSHOT_PATH'] = "./features/screenshots/"
ENV["APP_BUNDLE_PATH"] = "/Users/Miles/repos/lexie/ios/Lexie_3.app"
ENV["DEVICE_TARGET"] = "068BE9E1-CE89-439B-8654-50785707D0CA"
NO_STOP=1

class MinitestWorld
  extend Minitest::Assertions
  attr_accessor :assertions

  def initialize
    self.assertions = 0
  end
end

World do
  MinitestWorld.new
end

include EveForumIOS
include Eve
include Minitest::Assertions


GLOW_PASSWORD = "Glow12345"
