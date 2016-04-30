require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'public/noah_ios_forum_test'
require_relative 'public/ios_minitest'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class NoahTest < Minitest::Test
  include NoahForumIOS
  include Minitest_ios


  def premium_login
    premium = ForumUser.new(:email=>"miles3@g.com", :password => "111111").login.reset_all_flags
    premium
  end
  
  def test_forum_new_user
    u = forum_new_user
    puts u.res
  end

  def test_user_becomes_mother
    u = forum_new_user
    baby = u.new_born_baby(relation: "Mother", gender: "M")
    u.add_born_baby(baby)
    assert_rc u.res
    actual_baby = u.res["data"]["Baby"]["update"].first
    assert_equal u.current_baby.first_name, actual_baby["first_name"]
    assert_equal u.current_baby.last_name, actual_baby["last_name"]
    assert_equal u.current_baby.gender, actual_baby["gender"]
    assert_equal u.user_id, actual_baby["owner_user_id"]
    assert_equal "Mother", u.res["data"]["UserBabyRelation"]["update"].first["relation"]
  end


  def assert_rc(res)
    assert_equal 0, res["rc"]
  end


  def test_noah_signup
    u = forum_new_user
    assert_rc u.res
  end

  def test_noah_login
    u = forum_new_user
    u.login
    assert_rc u.res
  end

  
  def test_add_babies
    u = forum_new_user
    2.times do
      baby = u.new_born_baby(relation: "Mother", gender: "M")
      u.add_born_baby baby
    end
  end

  def test_sign_up
    u = ForumUser.new(:email=>"miles3@g.com", :password => "111111", :first_name=>'miles3').signup.login
    puts u.res
  end

end    












