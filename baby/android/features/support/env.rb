require 'calabash-android/cucumber'
require 'active_support/all'
require 'minitest/autorun'

require_relative 'app'
require_relative 'pages'
require_relative 'user'
require_relative '../../../www/public/noah_android_forum_test'

include BabyAndroid
include NoahForumAndroid
include BabyHelper

module MiniTestAssertions
  def self.extended(base)
    base.extend(MiniTest::Assertions)
    base.assertions = 0
  end

  attr_accessor :assertions
end
World(MiniTestAssertions)

ENV['SCREENSHOT_PATH'] = "./features/screenshots/"
