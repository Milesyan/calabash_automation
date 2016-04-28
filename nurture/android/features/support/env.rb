require 'calabash-android/cucumber'
require 'active_support/all'
# require 'minitest/autorun'

require_relative 'app'
require_relative 'pages'
require_relative '../../../www/public/nurture_android_forum_test'


include NurtureForumAndroid
include NurtureHelper


require 'minitest'
module MiniTestAssertions
  def self.extended(base)
    base.extend(MiniTest::Assertions)
    base.assertions = 0
  end

  attr_accessor :assertions
end
World(MiniTestAssertions)

ENV['SCREENSHOT_PATH'] = "./features/screenshots/"
GLOW_EVENTS_URL = "http://titan-appevents.glowing.com"
URL = "http://www.google.com"