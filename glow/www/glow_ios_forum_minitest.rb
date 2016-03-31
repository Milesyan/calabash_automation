require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'public/glow_ios_forum_test'
require_relative 'public/ios_minitest'
require_relative 'public/test_helper'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class GlowTest < Minitest::Test
  include GlowForumIOS
  include Minitest_ios
  include TestHelper
  def assert_rc(res)
    assert_equal 0, res["rc"]
  end
  
  def premium_login
    premium = ForumUser.new(:email=>"miles2@g.com", :password => "111111").login
    premium
  end
  
end












