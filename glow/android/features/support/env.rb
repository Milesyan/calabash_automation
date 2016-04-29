require 'calabash-android/cucumber'
require 'calabash-android/abase'
require 'minitest/autorun'
require 'active_support/all'
require_relative 'app'
require_relative 'pages'
require_relative '../../../www/public/glow_android_forum_test'

include Glow
include GlowForumAndroid
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