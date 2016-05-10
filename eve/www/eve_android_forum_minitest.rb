require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'public/eve_android_forum_test'
require_relative 'public/android_minitest'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class EveTest < Minitest::Test
  include EveForumAndroid
  include Minitest_android

  def setup
  end

    
  def assert_rc(res)
    assert_equal 0, res["rc"]
  end


  def test_forum_user
    u = forum_new_user
    puts u.res
  end
  def premium_login
    premium = ForumUser.new(:email=>"milesp@g.com", :password => "111111").login.reset_all_flags
    premium
  end



end