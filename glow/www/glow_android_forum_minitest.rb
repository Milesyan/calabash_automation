require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'glow_android_forum_test'
require_relative 'android_minitest'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class GlowTest < Minitest::Test
  include GlowForumAndroid
  include Minitest_android

  def setup
  end




  def assert_rc(res)
    assert_equal 0, res["rc"]
  end

  def test_non_ttc_user_signup
    u = forum_new_user
    assert_rc u.res
    u.login
    assert_equal 3, u.res["user"]["settings"]["current_status"]
  end

  def premium_login
    premium = ForumUser.new(:email=>"milesp@g.com", :password => "111111").login
    premium
  end

  def test_premium_login
    u = premium_login
    puts u.res
  end

end