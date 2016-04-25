require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'nurture_ios_test'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class NurtureTest < Minitest::Test
  include NurtureIOS

  def pp(my_json)
    puts JSON.pretty_generate(my_json)
  end

  def create_user(args = {})
    due_date = args[:due_date] || 265.days.since
    NurtureUser.new(due_date: due_date).signup
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

  def test_dynamic_insight
    u = create_user
    u.complete_daily_log(date: 2.days.ago)
    u.complete_daily_log(date: 1.day.ago)
    u.complete_daily_log(date: Time.now)
    puts u.insights
  end

  # def _test_log_200_days
  #   u = create_user(due_date: 10.days.since)
  #   200.times do |i|
  #     u.complete_daily_log(date: i.days.ago)
  #   end
  # end

  def test_medical_log
    u = create_user
    u.add_medical_log(date: 1.day.ago)
    u.add_medical_log(date: Time.now)
  end

end