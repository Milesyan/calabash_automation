# Spec
# https://docs.google.com/spreadsheets/d/1_pYHLElfoex4GUb6RmRo1kOeYbuRQQveaNTvZPg61E0/edit#gid=952715512

require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'glow_ios_test'

class GlowTest < Minitest::Test
  include GlowIOS

  def setup
  end

  def create_ttc_user(args = {})
    GlowUser.new(args).ttc_signup.login.complete_tutorial
  end

  def new_ttc_user
    GlowUser.new.ttc_signup.login.complete_tutorial
  end
    
  def new_non_ttc_user
    GlowUser.new.non_ttc_signup.login.complete_tutorial
  end

  def new_ft_user(args = {})
    GlowUser.new.ft_signup(args).login.complete_tutorial
  end

  def assert_rc(res)
    assert_equal 0, res["rc"]
  end

  def test_first_response_pregnancy_negative
    u = create_ttc_user(first_pb: 1.day.ago)
    u.add_pregnancy_test(pregnancy_test: 42)
    insights = u.res["user"]["insights"]

    assert_equal "Do you know the 5 second rule?", insights.first["title"]
    assert_equal("You can pee in a cup or hold the pregnancy test right under your urine stream, but either way, be sure to follow package instructions and apply adequate urine sample.", insights.first["body"])
  end

  def _test_first_res_pregnancy_negative_2nd_time
    # this won't work, becuase it's based on the trigger time, not on the specified date
    # triggerred key can be locked for 1 day
    u = create_ttc_user(first_pb: 100.days.ago)
    u.add_pregnancy_test(pregnancy_test: 42, date: 100.days.ago)
    u.add_pregnancy_test(pregnancy_test: 42)
    insights = u.res["user"]["insights"]
  end

  def test_clearblue_pregnancy_negative
    u = create_ttc_user(first_pb: 1.day.ago)
    u.add_pregnancy_test(pregnancy_test: 22)
    insights = u.res["user"]["insights"]
    u.pull_content
    notifications = u.res["user"]["notifications"]
    assert_equal "Buy now!", notifications.first["action_context"]["button_text"]
    assert_equal "http://www.amazon.com/First-Response-Result-Pregnancy-Packaging/dp/B000052XHI/ref=lp_2591889011_1_1_a_it?srs=2591889011&ie=UTF8&qid=1461255573&sr=8-1", notifications.first["action_context"]["url"]
  end

  def test_others_brand_pregnancy_positive
    u = create_ttc_user(first_pb: 1.day.ago)
    u.add_pregnancy_test(pregnancy_test: 51)
    insights = u.res["user"]["insights"]
    u.pull_content
    notifications = u.res["user"]["notifications"]
    assert_equal "Buy now!", notifications.first["action_context"]["button_text"]
    assert_equal "http://www.amazon.com/First-Response-Result-Pregnancy-Packaging/dp/B000052XHI/ref=lp_2591889011_1_1_a_it?srs=2591889011&ie=UTF8&qid=1461255573&sr=8-1", notifications.first["action_context"]["url"]
  end

  # Notifications
  def test_others_brand_pregnancy_negative
    # should trigger an in-app notification
    u = create_ttc_user(first_pb: 1.day.ago)
    u.add_pregnancy_test(pregnancy_test: 52)
    insights = u.res["user"]["insights"]

    u.pull_content
    notifications = u.res["user"]["notifications"]
    assert_equal "Buy now!", notifications.first["action_context"]["button_text"]
    assert_equal "http://www.amazon.com/First-Response-Result-Pregnancy-Packaging/dp/B000052XHI/ref=lp_2591889011_1_1_a_it?srs=2591889011&ie=UTF8&qid=1461255573&sr=8-1", notifications.first["action_context"]["url"]
  end

  def test_first_response_pregnancy_negative_notifications
    # should not trigger this notification
    u = create_ttc_user(first_pb: 1.day.ago)
    u.add_pregnancy_test(pregnancy_test: 42)
    u.pull_content
    notifications = u.res["user"]["notifications"]

    assert_equal nil, notifications.first["action_context"]["button_text"]
    assert_equal nil, notifications.first["action_context"]["url"]
  end

  def test_clearblue_pregnancy_negative_notifications
    # should not trigger this notification
    u = create_ttc_user(first_pb: 1.day.ago)
    u.add_pregnancy_test(pregnancy_test: 22)
    u.pull_content
    notifications = u.res["user"]["notifications"]

    assert_equal "Buy now!", notifications.first["action_context"]["button_text"]
    assert_equal "http://www.amazon.com/First-Response-Result-Pregnancy-Packaging/dp/B000052XHI/ref=lp_2591889011_1_1_a_it?srs=2591889011&ie=UTF8&qid=1461255573&sr=8-1", notifications.first["action_context"]["url"]
  end


  # Ovulation test
  def test_first_response_digital_ovulation_negative
    u = create_ttc_user(first_pb: 1.day.ago)
    u.add_ovulation_test(ovulation_test: 32)
    insights = u.res["user"]["insights"]

    assert_equal "Once I detect my LH surge, when is the best time to try?", insights.first["title"]
    assert_equal("You should have intercourse within 24-36 hours after you detect your LH surge.", insights.first["body"])
  end

  def test_first_response_fertility_ovulation_negative
    u = create_ttc_user(first_pb: 1.day.ago)
    u.add_ovulation_test(ovulation_test: 42)
    insights = u.res["user"]["insights"]

    assert_equal "Once I detect my LH surge, when is the best time to try?", insights.first["title"]
    assert_equal("You should have intercourse within 24-36 hours after you detect your LH surge.", insights.first["body"])
  end

  # in-app notifications
  # https://docs.google.com/spreadsheets/d/1Q5lCfbdQkkD-wgsHnJgdsq7L8wa9eqArtPIWpezYGZo/edit#gid=0

  def test_clearblue_easy_read_ovulation_positive
    u = create_ttc_user(first_pb: 1.day.ago)
    u.add_ovulation_test(ovulation_test: 21)
    u.pull_content
    notifications = u.res["user"]["notifications"]

    assert_equal "Buy now!", notifications.first["action_context"]["button_text"]
    assert_equal "http://www.amazon.com/First-Response-Ovulation-Pregnancy-Count/dp/B000052XHJ/ref=lp_2591889011_1_7_a_it?srs=2591889011&ie=UTF8&qid=1461255573&sr=8-7", notifications.first["action_context"]["url"]
  end

  def test_first_response_digital_ovulation_negative_notifications
    # should not trigger this notification
    u = create_ttc_user(first_pb: 1.day.ago)
    u.add_ovulation_test(ovulation_test: 32)
    u.pull_content
    notifications = u.res["user"]["notifications"]

    assert_equal nil, notifications.first["action_context"]["button_text"]
    assert_equal nil, notifications.first["action_context"]["url"]
  end

  def test_first_response_fertility_ovulation_negative_notifications
    # should not triiger this notification
    u = create_ttc_user(first_pb: 1.day.ago)
    u.add_ovulation_test(ovulation_test: 42)
    u.pull_content
    notifications = u.res["user"]["notifications"]

    assert_equal nil, notifications.first["action_context"]["button_text"]
    assert_equal nil, notifications.first["action_context"]["url"]
  end

  def test_clearblue_digital_ovulation_low_notifications
    u = create_ttc_user(first_pb: 1.day.ago)
    u.add_ovulation_test(ovulation_test: 12)
    u.pull_content
    notifications = u.res["user"]["notifications"]

    assert_equal "Buy now!", notifications.first["action_context"]["button_text"]
    assert_equal "http://www.amazon.com/First-Response-Ovulation-Pregnancy-Count/dp/B000052XHJ/ref=lp_2591889011_1_7_a_it?srs=2591889011&ie=UTF8&qid=1461255573&sr=8-7", notifications.first["action_context"]["url"]
  end
end