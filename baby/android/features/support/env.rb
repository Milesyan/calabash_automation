require 'calabash-android/cucumber'
require 'active_support/all'
require 'minitest/autorun'
require_relative 'app'
require_relative 'pages'
require_relative 'user'
require_relative '../../../www/public/baby_android_forum_test'

include BabyAndroid
include NoahForumAndroid
include BabyHelper

module Pre_config_users
  def premium_email() "milesp@g.com" end
  def non_premium_email() "milesn@g.com" end
  def premium_name() "milesp" end
  def non_premium_name() "milesn" end
  module_function :premium_email, :non_premium_email, :premium_name, :non_premium_name
end

module Myownworld
  include Pre_config_users
  def self.extended(base)
    base.extend(MiniTest::Assertions)
    base.assertions = 0
  end

  attr_accessor :assertions
end
World(Myownworld)

APP_CONFIG = "Baby"
# APP_CONFIG = "Baby-local"
ENV['SCREENSHOT_PATH'] = "./features/screenshots/"
