require 'calabash-android/cucumber'
require 'active_support/all'
require 'minitest/autorun'

require_relative 'app'
require_relative 'pages'
require_relative 'user'
require_relative '../../../www/public/noah_android_forum_test'
require_relative 'event_logger.rb'


include BabyAndroid
include NoahForumAndroid
include GlowLogger
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
NO_STOP=1
