APP_CONFIG = 'Glow'
# APP_CONFIG = 'Glow-local'
require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'public/glow_ios_forum_test'
require_relative 'public/ios_minitest'
require_relative 'public/test_helper'
require 'minitest/ci'
Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new, 
                          Minitest::Reporters::JUnitReporter.new,
                          Minitest::Reporters::HtmlReporter.new]

class GlowTest < Minitest::Test
  include GlowForumIOS
  include Minitest_ios
  include TestHelper
  
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
  
  def assert_rc(res)
    assert_equal 0, res["rc"]
  end
  
end












