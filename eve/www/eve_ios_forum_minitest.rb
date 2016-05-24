APP_CONFIG = 'Eve'
# APP_CONFIG = 'Eve-local'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/ci'

require_relative 'public/eve_ios_forum_test'
require_relative 'public/ios_minitest'

Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new, 
                          Minitest::Reporters::JUnitReporter.new,
                          Minitest::Reporters::HtmlReporter.new]

class EveTest < Minitest::Test
  include EveForumIOS
  include Minitest_ios

  def premium_user
    premium = ForumUser.new(:email=>"miles3@g.com", :password => "111111").login.reset_all_flags
    premium
  end

  def test_signup_or_login
    begin 
      premium = ForumUser.new(:email => "miles3@g.com", :password => '111111').login
    rescue 
      log_error "RESCUE"
      premium = forum_new_user :email => "miles3@g.com", :password => '111111'
    end
    begin 
      premium = ForumUser.new(:email => "milesn@g.com", :password => '111111').login
    rescue 
      log_error "RESCUE"
      premium = forum_new_user :email => "milesn@g.com", :password => '111111'
    end
  end

  def test_forum_new_user
    u = forum_new_user
    assert u.first_name
  end

  def assert_rc(res)
    assert_equal 0, res["rc"]
  end
end












