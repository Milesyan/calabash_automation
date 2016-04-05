require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'public/eve_ios_forum_test'
require_relative 'public/ios_minitest'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class EveTest < Minitest::Test
  include EveForumIOS
  include Minitest_ios

  def setup
  end


  def test_forum_new_user
    u = forum_new_user
    puts u.first_name
  end

  def assert_rc(res)
    assert_equal 0, res["rc"]
  end



  def test_eve_signup
    u = forum_new_user
    assert_rc u.res
  end

  def test_eve_login
    u = forum_new_user
    u.login_with_email
    assert_rc u.res
  end

  def premium_login
    premium = ForumUser.new(:email=>"miles2@g.com", :password => "111111").login
    premium
  end

  def test_premium
    up = premium_login
  end
  
end












