require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'noah_ios_forum_test'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

DUE_DATE_GROUP = []
CITY_MOMS_ALL = [2175, 2177, 2184, 2185, 72057594037930081,72057594037930082, 72057594037930084]
CITY_MOMS = CITY_MOMS_ALL[0]
ORIGIN_GROUPS_P1 = [2174,72057594037928467,72057594037930055]
POSTPARTUM = 72057594037928003
ORIGIN_GROUPS_P2 = [72057594037928023]+ [CITY_MOMS]+ [72057594037927939, 72057594037927941, 72057594037929371, 72057594037930056]

ORIGIN_GROUP = ORIGIN_GROUPS_P1 + ORIGIN_GROUPS_P2


class NoahSubscribeTest < Minitest::Test
  include NoahForumIOS

  def setup
  end

  def new_noah_user
    NoahUser.new.parent_signup.login
  end

  def test_new_no_baby_user
  	u = new_noah_user
  	group_ids = u.get_all_group_ids
  	puts group_ids
  end

  def test_new_have_upcoming_baby_user
  	u = new_noah_user
  	baby = u.new_upcoming_baby(relation: "Mother", gender: "M")
  	u.add_upcoming_baby(baby)
  	group_ids = u.get_all_group_ids
  	puts group_ids
  end

  def test_new_have_born_baby_user
  	u = new_noah_user
  	baby = u.new_born_baby
  	u.add_born_baby(baby)
  	group_ids = u.get_all_group_ids
  	puts group_ids
  end

  def test_nurture_come_user
  end

end
