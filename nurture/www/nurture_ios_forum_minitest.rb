require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'public/nurture_ios_forum_test'
require_relative 'public/ios_minitest'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class NurtureTest < Minitest::Test
  include NurtureForumIOS
  include Minitest_ios


  def test_exising_email_login
    ForumUser.new(:email => "milesn@g.com", :password => "111111").login.join_group.leave_all_groups.join_group
  end

  def premium_login
    premium = ForumUser.new(:email=>"miles2@g.com", :password => "111111").login
    premium
  end

  def test_create_example_user
    u = forum_new_user
  end

  def test_forum_new_user
    u = forum_new_user
  end

  def test_premium
    u = forum_new_user
    u.get_premium
  end

  def assert_rc(res)
    assert_equal 0, res["rc"]
  end

  def test_kaylee_signup
    u = forum_new_user
    assert_rc u.res
  end

  def test_kaylee_login
    u = forum_new_user
    u.login
    assert_rc u.res
  end



end












