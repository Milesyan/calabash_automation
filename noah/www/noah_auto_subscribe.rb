require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'noah_ios_forum_test'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new


class NoahSubscribeTest < Minitest::Test
  include NoahForumIOS

  def setup
  end

  def new_noah_user
    NoahUser.new.parent_signup.login
  end

