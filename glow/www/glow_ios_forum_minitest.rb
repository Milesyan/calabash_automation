require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'glow_ios_forum_test'
require_relative 'test_helper'
require_relative 'ios_minitest'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class GlowTest < Minitest::Test
  include GlowForumIOS
  extend TestHelper 
  include Minitest_ios

  def assert_rc(res)
    assert_equal 0, res["rc"]
  end

  def assert_same(exp,res)
    assert_equal exp,res
  end

end












