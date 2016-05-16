APP_CONFIG = 'Glow'
# APP_CONFIG = 'Glow-local'
require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'public/glow_android_forum_test'
require_relative 'public/android_minitest'

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
    u = ForumUser.new.non_ttc_signup.login
    assert_equal 3, u.res["user"]["settings"]["current_status"]
  end

  def premium_login
    premium = ForumUser.new(:email=>"milesp@g.com", :password => "111111").login.reset_all_flags
    premium
  end

  def test_premium_login
    u = premium_login
    puts u.res
  end

end