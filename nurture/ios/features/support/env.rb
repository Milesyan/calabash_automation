# Requiring this file will import Calabash and the Calabash predefined Steps.
require 'calabash-cucumber/cucumber'
require 'minitest/autorun'
require 'active_support/all'
require_relative '../../../www/public/nurture_ios_forum_test'
require_relative 'app'
require_relative 'pages'

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

include NurtureForumIOS
include Nurture
include Minitest::Assertions

ENV['SCREENSHOT_PATH'] = "./features/screenshots/"
ENV["APP_BUNDLE_PATH"] = "/Users/Miles/repos/kaylee/ios/kaylee_no_t.app"
ENV["DEVICE_TARGET"] = "068BE9E1-CE89-439B-8654-50785707D0CA"
GLOW_PASSWORD = "Glow12345"
