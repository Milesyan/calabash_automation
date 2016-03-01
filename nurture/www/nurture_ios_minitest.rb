require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'nurture_ios_test'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class NurtureTest < Minitest::Test
  include NurtureIOS

  def pp(my_json)
    puts JSON.pretty_generate(my_json)
  end

  def create_user
    NurtureUser.new.signup
  end

  def test_assert_true
    assert true
  end

  def test_signup_user
    create_user
  end

  def test_add_vitamin
    u = create_user
    u.add_vitamin date: 2.days.ago
  end


end