require 'calabash-cucumber/cucumber'
require 'minitest/autorun'
require 'active_support/all'
require_relative '../../../www/public/nurture_ios_forum_test'
require_relative 'app'
require_relative 'pages'

include NurtureForumIOS
include Nurture
include Minitest::Assertions

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

ENV['SCREENSHOT_PATH'] = "./features/screenshots/"
ENV["APP_BUNDLE_PATH"] = "/Users/Miles/repos/kaylee/ios/kaylee_no_t.app"
ENV["DEVICE_TARGET"] = ["97A373AC-E811-473A-A14D-127B4B2EA78A", "BB34C63B-2740-40E7-9889-C8D40D7CB1BB"].sample