require 'calabash-android/cucumber'
require 'calabash-android/abase'
require 'minitest/autorun'
require 'active_support/all'

require_relative 'app'
require_relative 'pages'
require_relative '../../../www/public/glow_android_forum_test'
require_relative 'event_logger.rb'

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

include Glow
include GlowForumAndroid
include GlowLogger
include Minitest::Assertions

ENV['SCREENSHOT_PATH'] = "./features/screenshots/"
GLOW_PASSWORD = "Glow12345"
GLOW_ENV = "dev-office"
NO_STOP=1