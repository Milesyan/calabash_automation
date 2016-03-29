require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'public/nurture_android_forum_test'
require_relative 'public/android_minitest'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class NurtureTest < Minitest::Test
  include NurtureForumAndroid
  include Minitest_android

  def setup
  end



  def test_premium_login
    up = premium_login
    puts up.res
  end

  def test_forum_new_user
    u = forum_new_user
    puts u.first_name
  end

  def assert_rc(res)
    assert_equal 0, res["rc"]
  end

  def test_nurture_signup
    u = forum_new_user
    puts u.res
  end

  def test_nurture_login
    u = forum_new_user
    u.login
    assert_rc u.res
  end

  def test_exising_email_login
    ForumUser.new(:email => "milesn@g.com", :password => "111111").login.leave_all_groups.join_group
  end
  
  def premium_login
    premium = ForumUser.new(:email=>"milesp@g.com", :password => "111111").login
    premium
  end

end












