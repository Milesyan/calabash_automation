require 'calabash-android/cucumber'
require 'active_support/all'
require 'minitest'
require_relative 'app'
require_relative 'pages'
require_relative '../../../www/public/nurture_android_forum_test'

include NurtureForumAndroid
include NurtureHelper

module MiniTestAssertions
  def self.extended(base)
    base.extend(MiniTest::Assertions)
    base.assertions = 0
  end

  attr_accessor :assertions
end
World(MiniTestAssertions)

ENV['SCREENSHOT_PATH'] = "./features/screenshots/"