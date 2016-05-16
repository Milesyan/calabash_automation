APP_CONFIG = 'Baby'
# APP_CONFIG = 'Baby-local'
require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'public/baby_android_forum_test'
require_relative 'public/android_minitest'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class NoahTest < Minitest::Test
  include NoahForumAndroid
  include TestHelper
  include Minitest_android

  def premium_login
    premium = ForumUser.new(:email=>"milesp@g.com", :password => "111111").login.reset_all_flags
    premium
  end


  def test_signup_or_login
    begin 
      premium = ForumUser.new(:email => "milesp@g.com", :password => '111111').login
    rescue 
      puts "RESCUE"
      premium = forum_new_user :email => "milesp@g.com", :password => '111111'
    end
    begin 
      premium = ForumUser.new(:email => "milesn@g.com", :password => '111111').login
    rescue 
      puts "RESCUE"
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












