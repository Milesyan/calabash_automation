require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'glow_android_test'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class GlowTest < Minitest::Test
  include GlowAndroid

  def setup
  end

  def new_ttc_user
    GlowUser.new.ttc_signup.login.complete_tutorial
  end
    
  def new_non_ttc_user(args)
    GlowUser.new(args).non_ttc_signup.login.complete_tutorial
  end

  def new_ft_user(args = {})
    GlowUser.new.ft_signup(args).login.complete_tutorial
  end

  def assert_rc(res)
    assert_equal 0, res["rc"]
  end

  def create_ttc_user(args = {})
    GlowUser.new(args).ttc_signup.login.complete_tutorial
  end

  def create_non_ttc_user(args = {})
    GlowUser.new(args).non_ttc_signup.login.complete_tutorial
  end

  def test_ttc_first_response_pregnancy_negative
    u = create_ttc_user(first_pb: 1.day.ago)
    u.add_pregnancy_test(pregnancy_test: 42)
    u.pull_content
    insights = u.res["insights"]
    fri = insights.select { |i| i['source'] == "First Response"}
    assert_equal "Do you know the 5 second rule?", fri.first["title"]
    assert_equal("You can pee in a cup or hold the pregnancy test right under your urine stream, but either way, be sure to follow package instructions and apply adequate urine sample.", fri.first["body"])
  end

  def test_ttc_first_response_pregnancy_negative_notifications
    # should not trigger this notification
    u = create_ttc_user(first_pb: 1.day.ago)
    u.add_pregnancy_test(pregnancy_test: 42)
    u.pull_content
    notifications = u.res["notifications"]

    assert_equal nil, notifications.first["action_context"]["button_text"]
    assert_equal nil, notifications.first["action_context"]["url"]
  end

  def test_non_ttc_user_should_not_receive_first_response_insight
    # should not trigger this notification
    u = create_non_ttc_user(first_pb: 1.day.ago)
    u.add_pregnancy_test(pregnancy_test: 42)
    u.pull_content
    notifications = u.res["notifications"]

    assert_equal nil, notifications.first["action_context"]["button_text"]
    assert_equal nil, notifications.first["action_context"]["url"]
  end

  def test_clearblue_pregnancy_negative_notifications
    # should not trigger this notification
    u = create_ttc_user(first_pb: 1.day.ago)
    u.add_pregnancy_test(pregnancy_test: 22)
    u.pull_content
    notifications = u.res["notifications"]

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
    notifications = u.res["notifications"]

    assert_equal "Buy now!", notifications.first["action_context"]["button_text"]
    assert_equal "http://www.amazon.com/First-Response-Ovulation-Pregnancy-Count/dp/B000052XHJ/ref=lp_2591889011_1_7_a_it?srs=2591889011&ie=UTF8&qid=1461255573&sr=8-7", notifications.first["action_context"]["url"]
  end

  def test_first_response_digital_ovulation_negative_notifications
    # should not trigger this notification
    u = create_ttc_user(first_pb: 1.day.ago)
    u.add_ovulation_test(ovulation_test: 32)
    u.pull_content
    notifications = u.res["notifications"]

    assert_equal nil, notifications.first["action_context"]["button_text"]
    assert_equal nil, notifications.first["action_context"]["url"]
  end

  def test_first_response_fertility_ovulation_negative_notifications
    # should not triiger this notification
    u = create_ttc_user(first_pb: 1.day.ago)
    u.add_ovulation_test(ovulation_test: 42)
    u.pull_content
    notifications = u.res["notifications"]

    assert_equal nil, notifications.first["action_context"]["button_text"]
    assert_equal nil, notifications.first["action_context"]["url"]
  end

  def test_clearblue_digital_ovulation_low_notifications
    u = create_ttc_user(first_pb: 1.day.ago)
    u.add_ovulation_test(ovulation_test: 12)
    u.pull_content
    notifications = u.res["notifications"]

    assert_equal "Buy now!", notifications.first["action_context"]["button_text"]
    assert_equal "http://www.amazon.com/First-Response-Ovulation-Pregnancy-Count/dp/B000052XHJ/ref=lp_2591889011_1_7_a_it?srs=2591889011&ie=UTF8&qid=1461255573&sr=8-7", notifications.first["action_context"]["url"]
  end
 
end