# Requiring this file will import Calabash and the Calabash predefined Steps.
require 'calabash-cucumber/cucumber'
require 'minitest/autorun'
require 'active_support/all'
require_relative '../../../www/public/eve_ios_forum_test'
require_relative 'app'
require_relative 'pages'

include EveForumIOS
include Eve
include Minitest::Assertions

module Pre_config_users
  def premium_email() "miles3@g.com" end
  def non_premium_email() "milesn@g.com" end
  def premium_name() "miles3" end
  def non_premium_name() "milesn" end
  module_function :premium_email, :non_premium_email, :premium_name, :non_premium_name
end

class Myownworld
  extend Minitest::Assertions
  include Pre_config_users
  attr_accessor :assertions

  def initialize
    self.assertions = 0
  end
end


World do
  Myownworld.new
end

ENV['SCREENSHOT_PATH'] = "./features/screenshots/"
ENV["APP_BUNDLE_PATH"] = File.dirname(__FILE__) + "/../../../../../test_builds/Lexie_v1.6_can.app"
# ENV["DEVICE_TARGET"] = ["97A373AC-E811-473A-A14D-127B4B2EA78A", "BB34C63B-2740-40E7-9889-C8D40D7CB1BB"].sample
ENV["DEVICE_TARGET"] = "BB34C63B-2740-40E7-9889-C8D40D7CB1BB"
