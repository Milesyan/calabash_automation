require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'public/baby_android_forum_test'
require_relative 'public/android_minitest'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class NoahTest < Minitest::Test
  include NoahForumAndroid
  include TestHelper
  include Minitest_android

  def setup
  end

  def premium_login
    premium = ForumUser.new(:email=>"milesp@g.com", :password => "111111").login.reset_all_flags
    premium
  end

  def test_forum_new_user
    u = forum_new_user
    assert u.first_name
  end

  def assert_rc(res)
    assert_equal 0, res["rc"]
  end

  def test_signup
    u = forum_new_user
    assert_rc u.res
  end

  def test_login
    u = forum_new_user
    u.login
    assert_rc u.res
  end
  
  def test_temp_chat
    up = premium_login
    up.remove_all_participants
    u = forum_new_user
    up.send_chat_request u.user_id
    u.accept_chat
  end
end












