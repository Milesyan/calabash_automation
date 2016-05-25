APP_CONFIG = 'Eve-local'
# APP_CONFIG = 'Eve-local'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/ci'

require_relative 'public/eve_android_forum_test'
require_relative 'public/android_minitest'

Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new, 
                          Minitest::Reporters::JUnitReporter.new,
                          Minitest::Reporters::HtmlReporter.new]

class EveTest < Minitest::Test
  include EveForumAndroid
  include Minitest_android
  @@counter = 0
  def assert_rc(res)
    assert_equal 0, res["rc"]
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

  def test_forum_user
    u = forum_new_user
    puts u.res
  end
  
  def premium_user
    premium = ForumUser.new(:email=>"milesp@g.com", :password => "111111").login.reset_all_flags
    premium
  end



end