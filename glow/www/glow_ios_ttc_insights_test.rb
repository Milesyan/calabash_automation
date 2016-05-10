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

  # Dynamic insights, TTC, Sex

  def test_ttc_d_insight_sex_cd2
    u = create_ttc_user(first_pb: 1.day.ago)
    u.add_sex
    insights = u.res["user"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "You had sex!", pi.first["title"]
    assert_equal 1, pi.first["is_premium"]
  end

  def test_ttc_d_insight_sex_cd3
    u = create_ttc_user(first_pb: 2.days.ago)
    u.add_sex
    insights = u.res["user"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "You had sex!", pi.first["title"]
    assert_equal 1, pi.first["is_premium"]
  end

  def test_ttc_d_insight_sex_cd1
    u = create_ttc_user(first_pb: Time.now)
    u.add_sex
    insights = u.res["user"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "You had sex!", pi.first["title"]
    assert_equal 1, pi.first["is_premium"]
  end

  def test_ttc_d_insight_sex_cd35
    u = create_ttc_user(first_pb: 34.days.ago, cycle_length: 40)
    u.add_sex
    insights = u.res["user"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "You had sex!", pi.first["title"]
    assert_equal 1, pi.first["is_premium"]
  end

  def test_ttc_d_insight_sex_cd36
    u = create_ttc_user(first_pb: 35.days.ago, cycle_length: 40)
    u.add_sex
    insights = u.res["user"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "You had sex!", pi.first["title"]
    assert_equal 1, pi.first["is_premium"]
  end

  def test_ttc_d_insight_sex_no_sex
    u = create_ttc_user(first_pb: 2.days.ago)
    u.add_sex(sex: 1)
    insights = u.res["user"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "You didn't have sex.", pi.first["title"]
    assert_equal 1, pi.first["is_premium"]
  end

  # Test premium users
  def test_set_premium
    u = create_ttc_user(first_pb: 2.days.ago)
    u.set_premium
    assert_equal 200, u.res["code"]
  end

  # Menstrual Flow insights

  def test_ttc_d_insights_period_flow_premium_user_cd1
    u = create_ttc_user(first_pb: Time.now)
    u.set_premium
    u.add_period_flow
    insights = u.res["user"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "You recorded your menstrual flow.", pi.first["title"]
    assert_equal "Your period, how heavy or light it is, how long it lasts, are all indicators of your health. Take note of your flow, your cramps, your other symptoms. Drastic changes from one month to another are worth mentioning to your doctor.", pi.first["body"]
  end

  def test_ttc_d_insights_period_flow_premium_user_cd3
    u = create_ttc_user(first_pb: 2.days.ago)
    u.set_premium
    u.add_period_flow
    insights = u.res["user"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "You recorded your menstrual flow.", pi.first["title"]
    assert_equal "Your period, how heavy or light it is, how long it lasts, are all indicators of your health. Take note of your flow, your cramps, your other symptoms. Drastic changes from one month to another are worth mentioning to your doctor.", pi.first["body"]
  end

  def test_ttc_d_insights_period_flow_premium_user_cd4
    u = create_ttc_user(first_pb: 3.days.ago)
    u.set_premium
    u.add_period_flow
    insights = u.res["user"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "You recorded your menstrual flow.", pi.first["title"]
    assert_equal "Your period, how heavy or light it is, how long it lasts, are all indicators of your health. Take note of your flow, your cramps, your other symptoms. Drastic changes from one month to another are worth mentioning to your doctor.", pi.first["body"]
  end

  def test_ttc_d_insights_period_flow_premium_user_cd5
    u = create_ttc_user(first_pb: 4.days.ago)
    u.set_premium
    u.add_period_flow
    insights = u.res["user"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 0, pi.size
  end

  # CM Insights

  def test_ttc_d_insights_cm_donot_show_during_period_premium_user_cd1
    u = create_ttc_user(first_pb: Time.now, period_length: 4)
    u.set_premium
    u.add_cm
    insights = u.res["user"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 0, pi.size
  end

  def test_ttc_d_insights_cm_donot_show_during_period_premium_user_cd3
    u = create_ttc_user(first_pb: 2.days.ago, period_length: 4)
    u.set_premium
    u.add_cm
    insights = u.res["user"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 0, pi.size
  end

  def test_ttc_d_insights_cm_donot_show_during_period_premium_user_cd5
    # the actual period length = period_length + 1
    u = create_ttc_user(first_pb: 4.days.ago, period_length: 4)
    u.set_premium
    u.add_cm
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_ttc_d_insights_cm_premium_user_cd6
    # the actual period length = period_length + 1
    u = create_ttc_user(first_pb: 5.days.ago, period_length: 4)
    u.set_premium
    u.add_cm
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }

    assert_equal 1, pi.size
  end

  def test_ttc_d_insights_cm_premium_user_cd16
    u = create_ttc_user(first_pb: 15.days.ago, cycle_length: 28)
    u.set_premium
    u.add_cm
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
  end

  def test_ttc_d_insights_cm_premium_user_cd17
    # if today is after the period end date, and not in the fertile window, do not show this insight
    # Day 17 is 1 day after the fertile window
    u = create_ttc_user(first_pb: 16.days.ago, cycle_length: 28)
    u.set_premium
    u.add_cm
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_ttc_d_insights_cm_premium_user_cd19
    # show this insight for CD 19
    u = create_ttc_user(first_pb: 18.days.ago, cycle_length: 40)
    u.set_premium
    u.add_cm
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
  end

  def test_ttc_d_insights_cm_premium_user_cd20
    # do not show this insight since CD 20
    u = create_ttc_user(first_pb: 19.days.ago, cycle_length: 40)
    u.set_premium
    u.add_cm
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_ttc_d_insights_cm_donot_show_during_period_premium_user_cd1
    # do not show no cm insight for CD 1
    u = create_ttc_user(first_pb: Time.now, period_length: 4)
    u.set_premium
    u.add_cm(cm: 1)
    insights = u.res["user"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 0, pi.size
  end

  def test_ttc_d_insights_cm_donot_show_during_period_premium_user_no_cm_cd3
    u = create_ttc_user(first_pb: 2.days.ago, period_length: 4)
    u.set_premium
    u.add_cm(cm: 1)
    insights = u.res["user"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 0, pi.size
  end

  def test_ttc_d_insights_cm_premium_user_no_cm_cd6
    u = create_ttc_user(first_pb: 5.days.ago, period_length: 4)
    u.set_premium
    u.add_cm(cm: 1) # 1 for No
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }

    assert_equal 1, pi.size
    assert_equal "You did not check your cervical mucus.", pi.first["title"]
    assert_equal "One study found that women who consistently monitored their cervical mucus had a significantly higher chance of conceiving in a given cycle and showed higher cumulative pregnancy rates.", pi.first["body"]
  end

  def test_ttc_d_insights_cm_premium_user_cd19
    # show no CM insight for CD 19
    u = create_ttc_user(first_pb: 18.days.ago, cycle_length: 40)
    u.set_premium
    u.add_cm(cm: 1)
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You did not check your cervical mucus.", pi.first["title"]
    assert_equal "One study found that women who consistently monitored their cervical mucus had a significantly higher chance of conceiving in a given cycle and showed higher cumulative pregnancy rates.", pi.first["body"]
 
  end

  # Exercise insights

  def test_ttc_d_insights_exercise_cd1
    # no insights for CD 1
    u = create_ttc_user(first_pb: Time.now, cycle_length: 40)
    u.add_exercise
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_ttc_d_insights_exercise_cd2
    u = create_ttc_user(first_pb: 1.day.ago, cycle_length: 40)
    u.add_exercise
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal("You exercised!", pi.first["title"])
    assert_equal("Go you! When it comes to exercise and fertility, moderation is key. Getting the recommended 150 minutes each week will lead you to gain more health and fertility benefits.", pi.first["body"])
  end

  def test_ttc_d_insights_exercise_cd30
    u = create_ttc_user(first_pb: 29.days.ago, cycle_length: 40)
    u.add_exercise
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal("You exercised!", pi.first["title"])
    assert_equal("Go you! When it comes to exercise and fertility, moderation is key. Getting the recommended 150 minutes each week will lead you to gain more health and fertility benefits.", pi.first["body"])
  end

  def test_ttc_d_insights_cd35
    u = create_ttc_user(first_pb: 34.days.ago, cycle_length: 40)
    u.add_exercise
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal("You exercised!", pi.first["title"])
    assert_equal("Go you! When it comes to exercise and fertility, moderation is key. Getting the recommended 150 minutes each week will lead you to gain more health and fertility benefits.", pi.first["body"])
  end

  def test_ttc_d_insights_cd36
    u = create_ttc_user(first_pb: 35.days.ago, cycle_length: 40)
    u.add_exercise
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_ttc_d_insights_no_exercise_cd1
    u = create_ttc_user(first_pb: Time.now, cycle_length: 40)
    u.add_exercise(exercise: 1)
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_ttc_d_insights_no_exercise_cd2
    u = create_ttc_user(first_pb: 1.day.ago, cycle_length: 40)
    u.add_exercise(exercise: 1)
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal("You didn't exercise.", pi.first["title"])
    assert_equal("Regular physical activity is one of the best things you can do for your health. Aim for at least 150 minutes of exercise each week. It's okay to spread out your activity during the week, or you can break it up into sessions as short as 10 minutes. Every little bit helps! ", pi.first["body"])
  end

  def test_ttc_d_insights_no_exercise_cd35
    u = create_ttc_user(first_pb: 34.days.ago, cycle_length: 40)
    u.add_exercise(exercise: 1)
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal("You didn't exercise.", pi.first["title"])
    assert_equal("Regular physical activity is one of the best things you can do for your health. Aim for at least 150 minutes of exercise each week. It's okay to spread out your activity during the week, or you can break it up into sessions as short as 10 minutes. Every little bit helps! ", pi.first["body"])
  end

  def test_ttc_d_insights_no_exercise_cd36
    u = create_ttc_user(first_pb: 35.days.ago, cycle_length: 40)
    u.add_exercise(exercise: 1)
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  # Physical symptoms

  def test_ttc_d_insights_physical_symptoms_cd1
    u = create_ttc_user(first_pb: Time.now)
    u.add_physical_discomfort
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_ttc_d_insights_physical_symptoms_cd2
    u = create_ttc_user(first_pb: 1.day.ago)
    u.add_physical_discomfort
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
  end

  def test_ttc_d_insights_physical_symptoms_cd2_yes_without_symptom
    u = create_ttc_user(first_pb: 1.day.ago)
    u.add_physical_discomfort( :symptoms => {})
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
  end

  def test_ttc_d_insights_physical_symptoms_cd2_no
    u = create_ttc_user(first_pb: 1.day.ago)
    u.add_physical_discomfort( :symptoms => {}, physical_discomfort: 1)
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You didn't log any physical symptoms.", pi.first["title"]
    assert_equal "The physical symptoms experienced during the menstrual cycle can vary from woman to woman and even from month to month in some cases. What's considered \"normal\" can be highly subjective so it's important to pay attention to and understand your own monthly patterns.", pi.first["body"]
  end

  # Mood insights

  def test_ttc_d_insights_mood_cd1
    u = create_ttc_user(first_pb: Time.now)
    u.add_mood
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_ttc_d_insights_mood_cd2
    u = create_ttc_user(first_pb: 1.day.ago)
    u.add_mood
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    puts pi.first["title"]
    assert_equal "It's good for us to be in touch with our emotions. Experiencing and accepting a wide, complex range of feelings is healthy and good for our mental health. It's important to acknowledge and embrace all the emotions that we feel without becoming overwhelmed by them or denying that they exist -- this is how we achieve emotional health.", pi.first["body"]
  end

  def test_ttc_d_insights_mood_cd2_yes_without_mood
    u = create_ttc_user(first_pb: 1.day.ago)
    u.add_mood( :emotional_symptoms => {})
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You did not log your mood.", pi.first["title"]
  end

  def test_ttc_d_insights_mood_cd2_no
    u = create_ttc_user(first_pb: 1.day.ago)
    u.add_mood(moods: 1, :emotional_symptoms => {})
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You didn't log your mood.", pi.first["title"]
    assert_equal "It's okay and completely normal to have days when you just feel neutral. Experiencing and accepting a wide, complex range of emotions is healthy and good for our emotional well-being.", pi.first["body"]
  end

  # Stress insights

  def test_ttc_d_insights_stress_cd1
    u = create_ttc_user(first_pb: Time.now)
    u.add_stress
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_ttc_d_insights_medium_stress_cd2
    # low/med/hight -> 0-33/34-66/67-100
    # on client side, stress level range is 1 - 102, 1 means No
    # medium stress
    u = create_ttc_user(first_pb: 1.day.ago)
    u.add_stress(stress_level: 48)
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You're feeling stressed.", pi.first["title"]
    assert_equal "Managing stress effectively is very important for your health. The most commonly reported stress management activities include listening to music, exercising or walking, going online, watching TV or movies for more than two hours a day, and reading. Try one!", pi.first["body"]
  end

  def test_ttc_d_insights_low_stress_cd2
    # low stress
    u = create_ttc_user(first_pb: 1.day.ago)
    u.add_stress(stress_level: 32)
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You're feeling stressed.", pi.first["title"]
    assert_equal "Managing stress effectively is very important for your health. The most commonly reported stress management activities include listening to music, exercising or walking, going online, watching TV or movies for more than two hours a day, and reading. Try one!", pi.first["body"]
  end

  def test_ttc_d_insights_high_stress_cd2
    # high stress
    u = create_ttc_user(first_pb: 1.day.ago)
    u.add_stress(stress_level: 68)
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You're feeling stressed.", pi.first["title"]
    assert_equal "Managing stress effectively is very important for your health. The most commonly reported stress management activities include listening to music, exercising or walking, going online, watching TV or movies for more than two hours a day, and reading. Try one!", pi.first["body"]
  end

  def test_ttc_d_insights_stress_no
    # high stress
    u = create_ttc_user(first_pb: 1.day.ago)
    u.add_stress(stress_level: 1)
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You're not stressed!", pi.first["title"]
    assert_equal "Stress can have really negative impacts on your health so the fact that you've got yours in check is great. Whatever it is that you're doing is working, so keep it up!", pi.first["body"]
  end

  def test_ttc_d_insights_stress_cd21
    u = create_ttc_user(first_pb: 20.days.ago)
    u.add_stress
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
  end

  def test_ttc_d_insights_stress_cd22
    u = create_ttc_user(first_pb: 21.days.ago)
    u.add_stress
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
  end

  def test_ttc_d_insights_stress_cd30
    u = create_ttc_user(first_pb: 29.days.ago, cycle_length: 40)
    u.add_stress
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size  
  end

  def test_ttc_d_insights_stress_cd31
    u = create_ttc_user(first_pb: 30.days.ago, cycle_length: 40)
    u.add_stress
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  # Sleep
  def test_ttc_d_insights_sleep_cd1
    u = create_ttc_user(first_pb: Time.now)
    u.add_sleep
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_ttc_d_insights_sleep_cd2
    u = create_ttc_user(first_pb: 1.day.ago)
    u.add_sleep
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You slept 5.0 hours!", pi.first["title"]
    assert_equal "Sleep plays a vital role in good health and well-being throughout your life. Getting enough quality sleep at the right times can help protect your mental health, physical health, quality of life, and safety.", pi.first["body"]
  end

  def test_ttc_d_insights_sleep_cd30
    u = create_ttc_user(first_pb: 29.days.ago, cycle_length: 40)
    u.add_sleep
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You slept 5.0 hours!", pi.first["title"]
    assert_equal "Sleep plays a vital role in good health and well-being throughout your life. Getting enough quality sleep at the right times can help protect your mental health, physical health, quality of life, and safety.", pi.first["body"]
  end

  def test_ttc_d_insights_sleep_cd31
    u = create_ttc_user(first_pb: 30.days.ago, cycle_length: 40)
    u.add_sleep
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  # ovulation test

  def test_ttc_d_insights_ov_test_cd10
    u = create_ttc_user(first_pb: 9.days.ago, cycle_length: 40)
    u.add_ovulation_test
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_ttc_d_insights_ov_test_cd11
    u = create_ttc_user(first_pb: 10.days.ago, cycle_length: 40)
    u.add_ovulation_test
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You took an ovulation test.", pi.first["title"]
    assert_equal "Ovulation kits help determine your fertile window by monitoring a surge in luteinizing hormone (LH), which triggers ovulation. Once the LH surge occurrs, ovulation typically follows within 12 to 36 hours.", pi.first["body"]
  end

  def test_ttc_d_insights_ov_test_cd19
    u = create_ttc_user(first_pb: 18.days.ago, cycle_length: 40)
    u.add_ovulation_test
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You took an ovulation test.", pi.first["title"]
    assert_equal "Ovulation kits help determine your fertile window by monitoring a surge in luteinizing hormone (LH), which triggers ovulation. Once the LH surge occurrs, ovulation typically follows within 12 to 36 hours.", pi.first["body"]
  end

  def test_ttc_d_insights_ov_test_cd20
    u = create_ttc_user(first_pb: 19.days.ago, cycle_length: 40)
    u.add_ovulation_test
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  # pregnancy test 

  def test_ttc_d_insights_pregnancy_tst_cd1
    u = create_ttc_user(first_pb: Time.now)
    u.add_pregnancy_test
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_ttc_d_insights_pregnancy_tst_cd21
    u = create_ttc_user(first_pb: 20.days.ago, cycle_length: 40)
    u.add_pregnancy_test
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_ttc_d_insights_pregnancy_tst_cd22
    u = create_ttc_user(first_pb: 21.days.ago, cycle_length: 40)
    u.add_pregnancy_test
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You took a pregnancy test.", pi.first["title"]
    assert_equal "Home pregnancy tests can detect pregnancy with almost 99% accuracy if used correctly. To get the most accurate reading and avoid false results (negative or positive), it's best to wait to take a test until the first day of your missed period.", pi.first["body"]
  end

  def test_trigger_multipe_insights_cd4
    # at most 3 insights can be triggered
    u = create_ttc_user(first_pb: 3.days.ago)
    u.add_sex
    u.add_period_flow
    u.add_stress
    u.add_sleep
    u.add_exercise
    u.add_mood
    insights = u.res["user"]["insights"]
    assert_equal 0, insights.size
  end

  # Articles
  # def test_article_today
  #   u = create_ttc_user
  #   u.get_articles
  #   articles = u.res["articles"]
  #   pi = articles.select {|a| a["is_premium"] == 1}
  #   puts pi
  # end

  # def test_article_yesterday
  #   u = create_ttc_user
  #   u.get_articles(date: 1.day.ago)
  #   articles = u.res["articles"]
  #   pi = articles.select {|a| a["is_premium"] == 1}
  #   puts pi
  # end

  # def test_article_2_days
  #   u = create_ttc_user

  #   u.get_articles(date: 1.day.since)
  #   articles = u.res["articles"]
  #   pi = articles.select {|a| a["is_premium"] == 1}
  #   puts pi

  #   u.get_articles
  #   articles = u.res["articles"]
  #   pi = articles.select {|a| a["is_premium"] == 1}
  #   puts pi
  # end

end