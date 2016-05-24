require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'noah_android_test'
require_relative 'noah_test_helper'
require 'active_support/all'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class NoahTest < Minitest::Test
  include BabyAndroid  
  def setup
  end

  def assert_rc(res)
    assert_equal 0, res["rc"]
  end

  def date_str(t)
    t.strftime("%Y/%m/%d")
  end

  def parse_date(date)
    Date.strptime(date, "%Y/%m/%d").to_time
  end

  def create_user
    BabyUser.new.signup
  end

 # Dynamic insights, bottle feed

  def test_bottle_feed_insight_this_week_of_week_0
    u = create_user
    u.set_premium
    baby = u.new_born_baby relation: "Mother", birthday: date_str(2.days.ago) #week 0
    u.add_born_baby(baby)
    feed = u.new_feed start_time: 25.hours.ago
    u.add_feed(feed)
    feed = u.new_feed start_time: 15.minutes.ago
    u.add_feed(feed)
    insights = u.res["data"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "#{u.current_baby.first_name} had a bottle.", pi.first["title"]
    assert_equal 4000204, pi.first["reference_id"]
    assert_equal 1, pi.first["is_premium"]
  end

  def test_bottle_feed_insight_last_week_of_week_0
    u = create_user
    u.set_premium
    baby = u.new_born_baby relation: "Mother", birthday: date_str(8.days.ago) #week 1
    u.add_born_baby(baby)
    feed = u.new_feed start_time: 2.days.ago
    u.add_feed(feed)
    feed = u.new_feed start_time: 3.days.ago
    u.add_feed(feed)
    feed = u.new_feed start_time: 15.minutes.ago
    u.add_feed(feed)
    insights = u.res["data"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "#{u.current_baby.first_name} had a bottle.", pi.first["title"]
    assert_equal 4000203, pi.first["reference_id"]
    assert_equal 1, pi.first["is_premium"]
  end 

  def test_bottle_feed_insight_this_week_of_week_28
    u = create_user
    u.set_premium
    baby = u.new_born_baby relation: "Mother", birthday: date_str(197.days.ago) #week 28
    u.add_born_baby(baby)
    feed = u.new_feed start_time: 25.hours.ago
    u.add_feed(feed)
    feed = u.new_feed start_time: 15.minutes.ago
    u.add_feed(feed)
    insights = u.res["data"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "#{u.current_baby.first_name} had a bottle.", pi.first["title"]
    assert_equal 4000204, pi.first["reference_id"]
    assert_equal 1, pi.first["is_premium"]
  end

  def test_bottle_feed_insight_last_week_of_week_28
    u = create_user
    u.set_premium
    baby = u.new_born_baby relation: "Mother", birthday: date_str(204.days.ago) #week 29
    u.add_born_baby(baby)
    feed = u.new_feed start_time: 2.days.ago
    u.add_feed(feed)
    feed = u.new_feed start_time: 3.days.ago
    u.add_feed(feed)
    feed = u.new_feed start_time: 15.minutes.ago
    u.add_feed(feed)
    insights = u.res["data"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "#{u.current_baby.first_name} had a bottle.", pi.first["title"]
    assert_equal 4000203, pi.first["reference_id"]
    assert_equal 1, pi.first["is_premium"]
  end 

   # Dynamic insights, sleep

  def test_sleep_insight_this_week_below_week_20
    #[1-20]
    u = create_user
    u.set_premium
    baby = u.new_born_baby relation: "Mother", birthday: date_str(15.days.ago) #week 2
    u.add_born_baby(baby)
    sleep = u.new_sleep start_time: 30.hours.ago, end_time: 15.hours.ago
    u.add_sleep(sleep)
    sleep = u.new_sleep start_time: 3.hours.ago, end_time: 1.minute.ago
    u.add_sleep(sleep)
    insights = u.res["data"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "#{u.current_baby.first_name} slept!", pi.first["title"]
    assert_equal 4000302, pi.first["reference_id"]
    assert_equal 1, pi.first["is_premium"]
  end 

  def test_sleep_insight_last_week_below_week_20
    #[2-21]
    u = create_user
    u.set_premium
    baby = u.new_born_baby relation: "Mother", birthday: date_str(22.days.ago) #week 3
    u.add_born_baby(baby)
    sleep = u.new_sleep start_time: 48.hours.ago, end_time: 45.hours.ago
    u.add_sleep(sleep)
    sleep = u.new_sleep start_time: 72.hours.ago, end_time: 68.hours.ago
    u.add_sleep(sleep)
    sleep = u.new_sleep start_time: 3.hours.ago, end_time: 1.minute.ago
    u.add_sleep(sleep)
    insights = u.res["data"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "#{u.current_baby.first_name} slept!", pi.first["title"]
    assert_equal 4000301, pi.first["reference_id"]
    assert_equal 1, pi.first["is_premium"]
  end

  def test_sleep_insight_this_week_of_week_20
    u = create_user
    u.set_premium
    baby = u.new_born_baby relation: "Mother", birthday: date_str(141.days.ago) #week 20
    u.add_born_baby(baby)
    sleep = u.new_sleep start_time: 30.hours.ago, end_time: 15.hours.ago
    u.add_sleep(sleep)
    sleep = u.new_sleep start_time: 3.hours.ago, end_time: 1.minute.ago
    u.add_sleep(sleep)
    insights = u.res["data"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "#{u.current_baby.first_name} slept!", pi.first["title"]
    assert_equal 4000302, pi.first["reference_id"]
    assert_equal 1, pi.first["is_premium"]
  end 

  def test_sleep_insight_last_week_of_week_20
    u = create_user
    u.set_premium
    baby = u.new_born_baby relation: "Mother", birthday: date_str(148.days.ago) #week 21
    u.add_born_baby(baby)
    sleep = u.new_sleep start_time: 48.hours.ago, end_time: 45.hours.ago
    u.add_sleep(sleep)
    sleep = u.new_sleep start_time: 72.hours.ago, end_time: 68.hours.ago
    u.add_sleep(sleep)
    sleep = u.new_sleep start_time: 3.hours.ago, end_time: 1.minute.ago
    u.add_sleep(sleep)
    insights = u.res["data"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "#{u.current_baby.first_name} slept!", pi.first["title"]
    assert_equal 4000301, pi.first["reference_id"]
    assert_equal 1, pi.first["is_premium"]
  end

  def test_sleep_insight_this_week_above_week_20
    #[21+]
    u = create_user
    u.set_premium
    baby = u.new_born_baby relation: "Mother", birthday: date_str(148.days.ago) #week 21
    u.add_born_baby(baby)
    sleep = u.new_sleep start_time: 30.hours.ago, end_time: 15.hours.ago
    u.add_sleep(sleep)
    sleep = u.new_sleep start_time: 3.hours.ago, end_time: 1.minute.ago
    u.add_sleep(sleep)
    insights = u.res["data"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "#{u.current_baby.first_name} slept!", pi.first["title"]
    assert_equal 4000304, pi.first["reference_id"]
    assert_equal 1, pi.first["is_premium"]
  end 

  def test_sleep_insight_last_week_above_week_20
    #[21+]
    u = create_user
    u.set_premium
    baby = u.new_born_baby relation: "Mother", birthday: date_str(155.days.ago) #week 22
    u.add_born_baby(baby)
    sleep = u.new_sleep start_time: 48.hours.ago, end_time: 45.hours.ago
    u.add_sleep(sleep)
    sleep = u.new_sleep start_time: 72.hours.ago, end_time: 68.hours.ago
    u.add_sleep(sleep)
    sleep = u.new_sleep start_time: 3.hours.ago, end_time: 1.minute.ago
    u.add_sleep(sleep)
    insights = u.res["data"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "#{u.current_baby.first_name} slept!", pi.first["title"]
    assert_equal 4000303, pi.first["reference_id"]
    assert_equal 1, pi.first["is_premium"]
  end

  def test_sleep_insight_this_week_of_week_0
    u = create_user
    u.set_premium
    baby = u.new_born_baby relation: "Mother", birthday: date_str(2.days.ago) #week 0
    u.add_born_baby(baby)
    sleep = u.new_sleep start_time: 30.hours.ago, end_time: 15.hours.ago
    u.add_sleep(sleep)
    sleep = u.new_sleep start_time: 3.hours.ago, end_time: 1.minute.ago
    u.add_sleep(sleep)
    insights = u.res["data"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "#{u.current_baby.first_name} slept!", pi.first["title"]
    assert_equal 4000304, pi.first["reference_id"]
    assert_equal 1, pi.first["is_premium"]
  end 

  def test_sleep_insight_last_week_of_week_0
    u = create_user
    u.set_premium
    baby = u.new_born_baby relation: "Mother", birthday: date_str(8.days.ago) #week 1
    u.add_born_baby(baby)
    sleep = u.new_sleep start_time: 48.hours.ago, end_time: 45.hours.ago
    u.add_sleep(sleep)
    sleep = u.new_sleep start_time: 72.hours.ago, end_time: 68.hours.ago
    u.add_sleep(sleep)
    sleep = u.new_sleep start_time: 3.hours.ago, end_time: 1.minute.ago
    u.add_sleep(sleep)
    insights = u.res["data"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "#{u.current_baby.first_name} slept!", pi.first["title"]
    assert_equal 4000303, pi.first["reference_id"]
    assert_equal 1, pi.first["is_premium"]
  end

  # Dynamic insights, pee

  def test_pee_insight_this_week_below_week_19
    #[1-19]
    u = create_user
    u.set_premium
    baby = u.new_born_baby relation: "Mother", birthday: date_str(15.days.ago) #week 2
    u.add_born_baby(baby)
    pee = u.new_pee start_time: 25.hours.ago
    u.add_pee(pee)
    pee = u.new_pee start_time: 20.minutes.ago
    u.add_pee(pee)
    insights = u.res["data"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "#{u.current_baby.first_name} had a wet diaper.", pi.first["title"]
    assert_equal 4000502, pi.first["reference_id"]
    assert_equal 1, pi.first["is_premium"]
  end

  def test_pee_insight_last_week_below_week_19
    #[2-20]
    u = create_user
    u.set_premium
    baby = u.new_born_baby relation: "Mother", birthday: date_str(22.days.ago) #week 3
    u.add_born_baby(baby)
    pee = u.new_pee start_time: 2.days.ago
    u.add_pee(pee)
    pee = u.new_pee start_time: 3.days.ago
    u.add_pee(pee)
    pee = u.new_pee start_time: 20.minutes.ago
    u.add_pee(pee)
    insights = u.res["data"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "#{u.current_baby.first_name} had a wet diaper.", pi.first["title"]
    assert_equal 4000501, pi.first["reference_id"]
    assert_equal 1, pi.first["is_premium"]
  end

  def test_pee_insight_this_week_of_week_19
    u = create_user
    u.set_premium
    baby = u.new_born_baby relation: "Mother", birthday: date_str(134.days.ago) #week 19
    u.add_born_baby(baby)
    pee = u.new_pee start_time: 25.hours.ago
    u.add_pee(pee)
    pee = u.new_pee start_time: 20.minutes.ago
    u.add_pee(pee)
    insights = u.res["data"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "#{u.current_baby.first_name} had a wet diaper.", pi.first["title"]
    assert_equal 4000502, pi.first["reference_id"]
    assert_equal 1, pi.first["is_premium"]
  end

  def test_pee_insight_last_week_of_week_19
    u = create_user
    u.set_premium
    baby = u.new_born_baby relation: "Mother", birthday: date_str(141.days.ago) #week 20
    u.add_born_baby(baby)
    pee = u.new_pee start_time: 2.days.ago
    u.add_pee(pee)
    pee = u.new_pee start_time: 3.days.ago
    u.add_pee(pee)
    pee = u.new_pee start_time: 20.minutes.ago
    u.add_pee(pee)
    insights = u.res["data"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "#{u.current_baby.first_name} had a wet diaper.", pi.first["title"]
    assert_equal 4000501, pi.first["reference_id"]
    assert_equal 1, pi.first["is_premium"]
  end

  def test_pee_insight_this_week_above_week_19
    #[1-19]
    u = create_user
    u.set_premium
    baby = u.new_born_baby relation: "Mother", birthday: date_str(141.days.ago) #week 20
    u.add_born_baby(baby)
    pee = u.new_pee start_time: 25.hours.ago
    u.add_pee(pee)
    pee = u.new_pee start_time: 20.minutes.ago
    u.add_pee(pee)
    insights = u.res["data"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "#{u.current_baby.first_name} had a wet diaper.", pi.first["title"]
    assert_equal 4000504, pi.first["reference_id"]
    assert_equal 1, pi.first["is_premium"]
  end

  def test_pee_insight_last_week_above_week_19
    #[2-20]
    u = create_user
    u.set_premium
    baby = u.new_born_baby relation: "Mother", birthday: date_str(148.days.ago) #week 21
    u.add_born_baby(baby)
    pee = u.new_pee start_time: 2.days.ago
    u.add_pee(pee)
    pee = u.new_pee start_time: 3.days.ago
    u.add_pee(pee)
    pee = u.new_pee start_time: 20.minutes.ago
    u.add_pee(pee)
    insights = u.res["data"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "#{u.current_baby.first_name} had a wet diaper.", pi.first["title"]
    assert_equal 4000503, pi.first["reference_id"]
    assert_equal 1, pi.first["is_premium"]
  end

  def test_pee_insight_this_week_of_week_0
    #week 0
    u = create_user
    u.set_premium
    baby = u.new_born_baby relation: "Mother", birthday: date_str(2.days.ago) #week 0
    u.add_born_baby(baby)
    pee = u.new_pee start_time: 25.hours.ago
    u.add_pee(pee)
    pee = u.new_pee start_time: 20.minutes.ago
    u.add_pee(pee)
    insights = u.res["data"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "#{u.current_baby.first_name} had a wet diaper.", pi.first["title"]
    assert_equal 4000504, pi.first["reference_id"]
    assert_equal 1, pi.first["is_premium"]
  end

  def test_pee_insight_last_week_of_week_0
    #week 1
    u = create_user
    u.set_premium
    baby = u.new_born_baby relation: "Mother", birthday: date_str(8.days.ago) #week 1
    u.add_born_baby(baby)
    pee = u.new_pee start_time: 2.days.ago
    u.add_pee(pee)
    pee = u.new_pee start_time: 3.days.ago
    u.add_pee(pee)
    pee = u.new_pee start_time: 20.minutes.ago
    u.add_pee(pee)
    insights = u.res["data"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "#{u.current_baby.first_name} had a wet diaper.", pi.first["title"]
    assert_equal 4000503, pi.first["reference_id"]
    assert_equal 1, pi.first["is_premium"]
  end
 
  # Dynamic insights, poo

  def test_poo_insight_this_week_below_week_18
    #[1-18]
    u = create_user
    u.set_premium
    baby = u.new_born_baby relation: "Mother", birthday: date_str(15.days.ago) #week 2
    u.add_born_baby(baby)
    poo = u.new_poo start_time: 25.hours.ago
    u.add_poo(poo)
    poo = u.new_poo start_time: 20.minutes.ago
    u.add_poo(poo)
    insights = u.res["data"]["insights"]

    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "#{u.current_baby.first_name} pooped!", pi.first["title"]
    assert_equal 4000402, pi.first["reference_id"]
    assert_equal 1, pi.first["is_premium"]
  end

  def test_poo_insight_last_week_below_week_18
    #[2-19]
    u = create_user
    u.set_premium
    baby = u.new_born_baby relation: "Mother", birthday: date_str(22.days.ago) #week 3
    u.add_born_baby(baby)
    poo = u.new_poo start_time: 2.days.ago
    u.add_pee(poo)
    poo = u.new_poo start_time: 3.days.ago
    u.add_pee(poo)
    poo = u.new_poo start_time: 20.minutes.ago
    u.add_poo(poo)
    insights = u.res["data"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "#{u.current_baby.first_name} pooped!", pi.first["title"]
    assert_equal 4000401, pi.first["reference_id"]
    assert_equal 1, pi.first["is_premium"]
  end

  def test_poo_insight_this_week_of_week_18
    u = create_user
    u.set_premium
    baby = u.new_born_baby relation: "Mother", birthday: date_str(127.days.ago) #week 18
    u.add_born_baby(baby)
    poo = u.new_poo start_time: 25.hours.ago
    u.add_poo(poo)
    poo = u.new_poo start_time: 20.minutes.ago
    u.add_poo(poo)
    insights = u.res["data"]["insights"]

    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "#{u.current_baby.first_name} pooped!", pi.first["title"]
    assert_equal 4000402, pi.first["reference_id"]
    assert_equal 1, pi.first["is_premium"]
  end

  def test_poo_insight_last_week_of_week_18
    u = create_user
    u.set_premium
    baby = u.new_born_baby relation: "Mother", birthday: date_str(134.days.ago) #week 19
    u.add_born_baby(baby)
    poo = u.new_poo start_time: 2.days.ago
    u.add_pee(poo)
    poo = u.new_poo start_time: 3.days.ago
    u.add_pee(poo)
    poo = u.new_poo start_time: 20.minutes.ago
    u.add_poo(poo)
    insights = u.res["data"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "#{u.current_baby.first_name} pooped!", pi.first["title"]
    assert_equal 4000401, pi.first["reference_id"]
    assert_equal 1, pi.first["is_premium"]
  end

  def test_poo_insight_this_week_above_week_18
    #[19+]
    u = create_user
    u.set_premium
    baby = u.new_born_baby relation: "Mother", birthday: date_str(134.days.ago) #week 19
    u.add_born_baby(baby)
    poo = u.new_poo start_time: 25.hours.ago
    u.add_poo(poo)
    poo = u.new_poo start_time: 20.minutes.ago
    u.add_poo(poo)
    insights = u.res["data"]["insights"]

    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "#{u.current_baby.first_name} pooped!", pi.first["title"]
    assert_equal 4000404, pi.first["reference_id"]
    assert_equal 1, pi.first["is_premium"]
  end

  def test_poo_insight_last_week_above_week_18
    #[20+]
    u = create_user
    u.set_premium
    baby = u.new_born_baby relation: "Mother", birthday: date_str(141.days.ago) #week 20
    u.add_born_baby(baby)
    poo = u.new_poo start_time: 2.days.ago
    u.add_pee(poo)
    poo = u.new_poo start_time: 3.days.ago
    u.add_pee(poo)
    poo = u.new_poo start_time: 20.minutes.ago
    u.add_poo(poo)
    insights = u.res["data"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "#{u.current_baby.first_name} pooped!", pi.first["title"]
    assert_equal 4000403, pi.first["reference_id"]
    assert_equal 1, pi.first["is_premium"]
  end

  def test_poo_insight_this_week_of_week_0
    #week 0
    u = create_user
    u.set_premium
    baby = u.new_born_baby relation: "Mother", birthday: date_str(2.days.ago) #week 0
    u.add_born_baby(baby)
    poo = u.new_poo start_time: 25.hours.ago
    u.add_poo(poo)
    poo = u.new_poo start_time: 20.minutes.ago
    u.add_poo(poo)
    insights = u.res["data"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "#{u.current_baby.first_name} pooped!", pi.first["title"]
    assert_equal 4000404, pi.first["reference_id"]
    assert_equal 1, pi.first["is_premium"]
  end

  def test_poo_insight_last_week_of_week_0
    #week 1
    u = create_user
    u.set_premium
    baby = u.new_born_baby relation: "Mother", birthday: date_str(8.days.ago) #week 1
    u.add_born_baby(baby)
    poo = u.new_poo start_time: 2.days.ago
    u.add_poo(poo)
    poo = u.new_poo start_time: 3.days.ago
    u.add_poo(poo)
    poo = u.new_poo start_time: 20.minutes.ago
    u.add_poo(poo)
    insights = u.res["data"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "#{u.current_baby.first_name} pooped!", pi.first["title"]
    assert_equal 4000403, pi.first["reference_id"]
    assert_equal 1, pi.first["is_premium"]
  end

  # Dynamic insights, breast feed

  def test_breast_feed_insight_this_week_below_16_week
    #[1-16]
    u = create_user
    u.set_premium
    baby = u.new_born_baby relation: "Mother", birthday: date_str(15.days.ago) #week 2
    u.add_born_baby(baby)
    breast_feed = u.new_breast_feed start_time: 25.hours.ago
    u.add_breast_feed(breast_feed)
    breast_feed = u.new_breast_feed start_time: 15.minutes.ago
    u.add_breast_feed(breast_feed)
    insights = u.res["data"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "You breastfed #{u.current_baby.first_name}.", pi.first["title"]
    assert_equal 4000102, pi.first["reference_id"]
    assert_equal 1, pi.first["is_premium"]
  end

  def test_breast_feed_insight_last_week_below_16_week
    #[2-17]
    u = create_user
    u.set_premium
    baby = u.new_born_baby relation: "Mother", birthday: date_str(22.days.ago) #week 3
    u.add_born_baby(baby)
    breast_feed = u.new_breast_feed start_time: 2.days.ago
    u.add_breast_feed(breast_feed)
    breast_feed = u.new_breast_feed start_time: 3.days.ago
    u.add_breast_feed(breast_feed)
    breast_feed = u.new_breast_feed start_time: 15.minutes.ago
    u.add_breast_feed(breast_feed)
    insights = u.res["data"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "You breastfed #{u.current_baby.first_name}.", pi.first["title"]
    assert_equal 4000101, pi.first["reference_id"]
    assert_equal 1, pi.first["is_premium"]
  end 

  def test_breast_feed_insight_this_week_of_16_week
    u = create_user
    u.set_premium
    baby = u.new_born_baby relation: "Mother", birthday: date_str(113.days.ago) #week 16
    u.add_born_baby(baby)
    breast_feed = u.new_breast_feed start_time: 25.hours.ago
    u.add_breast_feed(breast_feed)
    breast_feed = u.new_breast_feed start_time: 15.minutes.ago
    u.add_breast_feed(breast_feed)
    insights = u.res["data"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "You breastfed #{u.current_baby.first_name}.", pi.first["title"]
    assert_equal 4000102, pi.first["reference_id"]
    assert_equal 1, pi.first["is_premium"]
  end

  def test_breast_feed_insight_last_week_of_16_week
    u = create_user
    u.set_premium
    baby = u.new_born_baby relation: "Mother", birthday: date_str(120.days.ago) #week 17
    u.add_born_baby(baby)
    breast_feed = u.new_breast_feed start_time: 2.days.ago
    u.add_breast_feed(breast_feed)
    breast_feed = u.new_breast_feed start_time: 3.days.ago
    u.add_breast_feed(breast_feed)
    breast_feed = u.new_breast_feed start_time: 15.minutes.ago
    u.add_breast_feed(breast_feed)
    insights = u.res["data"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "You breastfed #{u.current_baby.first_name}.", pi.first["title"]
    assert_equal 4000101, pi.first["reference_id"]
    assert_equal 1, pi.first["is_premium"]
  end 

  def test_breast_feed_insight_this_week_above_16_week
    #[17+]
    u = create_user
    u.set_premium
    baby = u.new_born_baby relation: "Mother", birthday: date_str(120.days.ago) #week 17
    u.add_born_baby(baby)
    breast_feed = u.new_breast_feed start_time: 25.hours.ago
    u.add_breast_feed(breast_feed)
    breast_feed = u.new_breast_feed start_time: 15.minutes.ago
    u.add_breast_feed(breast_feed)
    insights = u.res["data"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "You breastfed #{u.current_baby.first_name}.", pi.first["title"] 
    assert_equal 4000104, pi.first["reference_id"]
    assert_equal 1, pi.first["is_premium"]
  end

   def test_breast_feed_insight_last_week_above_16_week
    #[17+]
    u = create_user
    u.set_premium
    baby = u.new_born_baby relation: "Mother", birthday: date_str(127.days.ago) #week 18
    u.add_born_baby(baby)
    breast_feed = u.new_breast_feed start_time: 2.days.ago
    u.add_breast_feed(breast_feed)
    breast_feed = u.new_breast_feed start_time: 3.days.ago
    u.add_breast_feed(breast_feed)
    breast_feed = u.new_breast_feed start_time: 15.minutes.ago
    u.add_breast_feed(breast_feed)
    insights = u.res["data"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "You breastfed #{u.current_baby.first_name}.", pi.first["title"]
    assert_equal 4000103, pi.first["reference_id"]
    assert_equal 1, pi.first["is_premium"]
  end

  def test_breast_feed_insight_this_week_of_week_0
    #week 0
    u = create_user
    u.set_premium
    baby = u.new_born_baby relation: "Mother", birthday: date_str(2.days.ago) #week 0
    u.add_born_baby(baby)
    breast_feed = u.new_breast_feed start_time: 25.hours.ago
    u.add_breast_feed(breast_feed)
    breast_feed = u.new_breast_feed start_time: 15.minutes.ago
    u.add_breast_feed(breast_feed)
    insights = u.res["data"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "You breastfed #{u.current_baby.first_name}.", pi.first["title"]
    assert_equal 4000104, pi.first["reference_id"]
    assert_equal 1, pi.first["is_premium"]
  end


   def test_breast_feed_insight_last_week_of_week_0
    #week 1
    u = create_user
    u.set_premium
    baby = u.new_born_baby relation: "Mother", birthday: date_str(8.days.ago) #week 1
    u.add_born_baby(baby)
    breast_feed = u.new_breast_feed start_time: 2.days.ago
    u.add_breast_feed(breast_feed)
    breast_feed = u.new_breast_feed start_time: 3.days.ago
    u.add_breast_feed(breast_feed)
    breast_feed = u.new_breast_feed start_time: 15.minutes.ago
    u.add_breast_feed(breast_feed)
    insights = u.res["data"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "You breastfed #{u.current_baby.first_name}.", pi.first["title"]
    assert_equal 4000103, pi.first["reference_id"]
    assert_equal 1, pi.first["is_premium"]
  end

end
