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

  def export_html(name, content)
    File.open("./#{name}", 'w') { |file| file.write(content) }
  end

  # Dynamic insights, TTC, Sex

  def test_non_ttc_d_insight_sex_cd2
    u = create_non_ttc_user(first_pb: 1.day.ago)
    u.add_sex
    insights = u.res["user"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "You had sex!", pi.first["title"]
    assert_equal 1, pi.first["is_premium"]
    export_html('non_ttc_sex_cd2.html', pi.first["html_body"])
  end

  def test_non_ttc_d_insight_sex_cd30
    u = create_non_ttc_user(first_pb: 29.days.ago, cycle_length: 40)
    u.add_sex
    insights = u.res["user"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "You had sex!", pi.first["title"]
    assert_equal 1, pi.first["is_premium"]
    export_html('non_ttc_sex_cd30.html', pi.first["html_body"])
  end

  def test_non_ttc_d_insight_sex_cd1
    u = create_non_ttc_user(first_pb: Time.now, cycle_length: 40)
    u.add_sex
    insights = u.res["user"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "You had sex!", pi.first["title"]
    assert_equal 1, pi.first["is_premium"]
    export_html('non_ttc_sex_cd1.html', pi.first["html_body"])
  end

  def test_non_ttc_d_insight_sex_cd3
    u = create_non_ttc_user(first_pb: 2.days.ago)
    u.add_sex
    insights = u.res["user"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 1, pi.size
    assert_equal "You had sex!", pi.first["title"]
    assert_equal 1, pi.first["is_premium"]
    export_html('non_ttc_sex_cd3.html', pi.first["html_body"])
  end

  def test_non_ttc_d_insight_sex_cd30
    u = create_non_ttc_user(first_pb: 29.days.ago, cycle_length: 40)
    u.add_sex(sex: 8194)
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You had sex!", pi.first["title"]
    assert_equal 1, pi.first["is_premium"]
    export_html('non_ttc_sex_cd30.html', pi.first["html_body"])
  end

  def test_non_ttc_d_insight_sex_3_day_streak
    u = create_non_ttc_user(first_pb: 29.days.ago, cycle_length: 40)
    u.add_sex(date: 2.days.ago, sex: 8194)
    u.add_sex(date: 1.day.ago, sex: 8194)
    u.add_sex(sex: 8194)
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You had sex!", pi.first["title"]
    assert_equal 1, pi.first["is_premium"]
    export_html('non_ttc_sex_3_day_streak.html', pi.first["html_body"])
  end

  def test_non_ttc_d_insight_sex_cd31
    u = create_non_ttc_user(first_pb: 30.days.ago, cycle_length: 40)
    u.add_sex(sex: 8194)
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You had sex!", pi.first["title"]
    assert_equal 1, pi.first["is_premium"]
    export_html('non_ttc_sex_cd31.html', pi.first["html_body"])
  end

  def test_non_ttc_d_insight_sex_no_sex
    u = create_non_ttc_user(first_pb: 2.days.ago)
    u.add_sex(sex: 1)
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You didn't have sex.", pi.first["title"]
    assert_equal 1, pi.first["is_premium"]
    assert_equal "How much sex is healthy? The simple answer is that everyone is different and there is no \"normal\" for sexual behavior. As long as your sex life isn't affecting your self-esteem, hurting your relationship, or otherwise leading to negative life consequences, there's no need to worry!", pi.first["body"]
    export_html('non_ttc_no_sex.html', pi.first["html_body"])
  end

  # Menstrual Flow insights

  def test_non_ttc_d_insights_period_flow_premium_user_cd1
    u = create_non_ttc_user(first_pb: Time.now)
    u.set_premium
    u.add_period_flow
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You recorded your menstrual flow.", pi.first["title"]
    assert_equal "Your period, how heavy or light it is, how long it lasts, are all indicators of your health. Take note of your flow, your cramps, your other symptoms. Drastic changes from one month to another are worth mentioning to your doctor.", pi.first["body"]
    export_html('non_ttc_menstrual_flow_cd1.html', pi.first["html_body"])
  end

  def test_non_ttc_d_insights_period_flow_premium_user_cd4
    u = create_non_ttc_user(first_pb: 3.days.ago)
    u.set_premium
    u.add_period_flow
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You recorded your menstrual flow.", pi.first["title"]
    assert_equal "Your period, how heavy or light it is, how long it lasts, are all indicators of your health. Take note of your flow, your cramps, your other symptoms. Drastic changes from one month to another are worth mentioning to your doctor.", pi.first["body"]
    export_html('non_ttc_menstrual_flow_cd4.html', pi.first["html_body"])
  end

  def test_non_ttc_d_insights_period_flow_premium_user_cd5
    u = create_non_ttc_user(first_pb: 4.days.ago)
    u.set_premium
    u.add_period_flow
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }

    assert_equal 0, pi.size
  end

  # CM Insights

  def test_non_ttc_d_insights_cm_donot_show_during_period_premium_user_cd1
    u = create_non_ttc_user(first_pb: Time.now, period_length: 4)
    u.set_premium
    u.add_cm
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_non_ttc_d_insights_cm_donot_show_during_period_premium_user_cd3
    u = create_non_ttc_user(first_pb: 2.days.ago, period_length: 4)
    u.set_premium
    u.add_cm
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }

    assert_equal 0, pi.size
  end

  def test_non_ttc_d_insights_cm_donot_show_during_period_premium_user_cd5
    # the actual period length = period_length + 1
    u = create_non_ttc_user(first_pb: 4.days.ago, period_length: 4)
    u.set_premium
    u.add_cm
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_non_ttc_d_insights_cm_premium_user_cd6
    # the actual period length = period_length + 1
    u = create_non_ttc_user(first_pb: 5.days.ago, period_length: 4)
    u.set_premium
    u.add_cm
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }

    assert_equal 1, pi.size
    export_html('non_ttc_cm_cd6.html', pi.first["html_body"])
  end

  def test_non_ttc_d_insights_cm_premium_user_cd16
    u = create_non_ttc_user(first_pb: 15.days.ago, cycle_length: 28)
    u.set_premium
    u.add_cm
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    export_html('non_ttc_cm_cd16.html', pi.first["html_body"])
  end

  def test_non_ttc_d_insights_cm_premium_user_cd17
    # if today is after the period end date, and not in the fertile window, do not show this insight
    # Day 17 is 1 day after the fertile window
    u = create_non_ttc_user(first_pb: 16.days.ago, cycle_length: 28)
    u.set_premium
    u.add_cm
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_non_ttc_d_insights_cm_premium_user_cd19
    # show this insight for CD 19
    u = create_non_ttc_user(first_pb: 18.days.ago, cycle_length: 40)
    u.set_premium
    u.add_cm
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    export_html('non_ttc_cm_cd19.html', pi.first["html_body"])
  end

  def test_non_ttc_d_insights_cm_premium_user_cd20
    # do not show this insight since CD 20
    u = create_non_ttc_user(first_pb: 19.days.ago, cycle_length: 40)
    u.set_premium
    u.add_cm
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_non_ttc_d_insights_cm_donot_show_during_period_premium_user_no_cm_cd3
    u = create_non_ttc_user(first_pb: 2.days.ago, period_length: 4)
    u.set_premium
    u.add_cm(cm: 1)
    insights = u.res["user"]["insights"]
    pi = insights.select do |i|
      i['is_premium'] == 1
    end
    assert_equal 0, pi.size
  end

  def test_non_ttc_d_insights_cm_premium_user_no_cm_cd6
    u = create_non_ttc_user(first_pb: 5.days.ago, period_length: 4)
    u.set_premium
    u.add_cm(cm: 1) # 1 for No
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }

    assert_equal 1, pi.size
    assert_equal "You did not check your cervical mucus.", pi.first["title"]
    assert_equal "Keeping track of your cervical mucus can help clue you into what's going on with your fertility throughout your menstrual cycle. It's called the cervical mucus method and it helps you to know when your peak fertile times are so you can take extra care to avoid unprotected sex.", pi.first["body"]
    export_html('non_ttc_no_cm_cd6.html', pi.first["html_body"])
  end

  def test_non_ttc_d_insights_cm_premium_user_no_cm_cd19
    # show no CM insight for CD 19
    u = create_non_ttc_user(first_pb: 18.days.ago, cycle_length: 40)
    u.set_premium
    u.add_cm(cm: 1)
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You did not check your cervical mucus.", pi.first["title"]
    assert_equal "Keeping track of your cervical mucus can help clue you into what's going on with your fertility throughout your menstrual cycle. It's called the cervical mucus method and it helps you to know when your peak fertile times are so you can take extra care to avoid unprotected sex.", pi.first["body"]
    export_html('non_ttc_no_cm_cd19.html', pi.first["html_body"])
  end

  # Exercise

  def test_non_ttc_d_insights_exercise_cd1
    # no insights for CD 1
    u = create_non_ttc_user(first_pb: Time.now, cycle_length: 40)
    u.add_exercise
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_non_ttc_d_insights_exercise_cd2
    # lambda trigger: trigger.has_exercise_today and 2 <= trigger.cycle_day <= 30
    u = create_non_ttc_user(first_pb: 1.day.ago, cycle_length: 40)
    u.add_exercise
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal("You exercised!", pi.first["title"])
    assert_equal("When it comes to exercise, more is better! Pushing yourself beyond the recommended 150 minutes each week will lead to more gain in health benefits. Researchers found that the more people exercised, the more their risk of disease mortality decreased.", pi.first["body"])
  end

  def test_non_ttc_d_insights_exercise_cd30
    u = create_non_ttc_user(first_pb: 29.days.ago, cycle_length: 40)
    u.add_exercise
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal("You exercised!", pi.first["title"])
    assert_equal("When it comes to exercise, more is better! Pushing yourself beyond the recommended 150 minutes each week will lead to more gain in health benefits. Researchers found that the more people exercised, the more their risk of disease mortality decreased.", pi.first["body"])
  end

  def test_non_ttc_d_insights_cd31
    u = create_non_ttc_user(first_pb: 30.days.ago, cycle_length: 40)
    u.add_exercise
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_non_ttc_d_insights_no_exercise_cd1
    u = create_non_ttc_user(first_pb: Time.now, cycle_length: 40)
    u.add_exercise(exercise: 1)
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_non_ttc_d_insights_no_exercise_cd2
    u = create_non_ttc_user(first_pb: 1.day.ago, cycle_length: 40)
    u.add_exercise(exercise: 1)
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal("You didn't exercise.", pi.first["title"])
    assert_equal("Regular physical activity is one of the best things you can do for your health. Aim for at least 150 minutes of exercise each week. It's okay to spread out your activity during the week, or you can break it up into sessions as short as 10 minutes. Every little bit helps! ", pi.first["body"])
  end

  def test_non_ttc_d_insights_no_exercise_cd30
    u = create_non_ttc_user(first_pb: 29.days.ago, cycle_length: 40)
    u.add_exercise(exercise: 1)
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal("You didn't exercise.", pi.first["title"])
    assert_equal("Regular physical activity is one of the best things you can do for your health. Aim for at least 150 minutes of exercise each week. It's okay to spread out your activity during the week, or you can break it up into sessions as short as 10 minutes. Every little bit helps! ", pi.first["body"])
  end

  def test_ttc_d_insights_no_exercise_cd31
    u = create_non_ttc_user(first_pb: 30.days.ago, cycle_length: 40)
    u.add_exercise(exercise: 1)
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  # Physical symptoms

  def test_non_ttc_d_insights_physical_symptoms_cd1
    u = create_non_ttc_user(first_pb: Time.now)
    u.add_physical_discomfort
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_non_ttc_d_insights_physical_symptoms_cd2
    u = create_non_ttc_user(first_pb: 1.day.ago)
    u.add_physical_discomfort
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
  end

  def test_non_ttc_d_insights_physical_symptoms_cd2_yes_without_symptom
    u = create_non_ttc_user(first_pb: 1.day.ago)
    u.add_physical_discomfort( :symptoms => {})
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal("You're feeling a little off.", pi.first["title"])
    assert_equal("The menstrual cycle can affect women differently. Symptoms vary from woman to woman, and the most commonly reported ones are acne, sore breasts, fatigue, insomnia, GI upset, headache, backache, appetite changes or food cravings, and changes in mood.", pi.first["body"])
  end

  def test_non_ttc_d_insights_physical_symptoms_cd2_no
    u = create_non_ttc_user(first_pb: 1.day.ago)
    u.add_physical_discomfort( :symptoms => {}, physical_discomfort: 1)
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You didn't log any physical symptoms.", pi.first["title"]
    assert_equal "The physical symptoms experienced during the menstrual cycle can vary from woman to woman and even from month to month in some cases. What's considered \"normal\" can be highly subjective so it's important to pay attention to and understand your own monthly patterns.", pi.first["body"]
  end

 # Mood insights

  def test_non_ttc_d_insights_mood_cd1
    u = create_non_ttc_user(first_pb: Time.now)
    u.add_mood
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_non_ttc_d_insights_mood_cd2
    u = create_non_ttc_user(first_pb: 1.day.ago)
    u.add_mood
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You logged your mood.", pi.first["title"]
    assert_equal "It's good for us to be in touch with our emotions. Experiencing and accepting a wide, complex range of feelings is healthy and good for our mental health. It's important to acknowledge and embrace all the emotions that we feel without becoming overwhelmed by them or denying that they exist -- this is how we achieve emotional health.", pi.first["body"]
  end

  def test_non_ttc_d_insights_mood_cd2_yes_without_mood
    u = create_non_ttc_user(first_pb: 1.day.ago)
    u.add_mood( :emotional_symptoms => {})
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You logged your mood.", pi.first["title"]
    assert_equal("It's good for us to be in touch with our emotions. Experiencing and accepting a wide, complex range of feelings is healthy and good for our mental health. It's important to acknowledge and embrace all the emotions that we feel without becoming overwhelmed by them or denying that they exist -- this is how we achieve emotional health.", pi.first["body"])
  end

  def test_non_ttc_d_insights_mood_cd2_no_mood
    u = create_non_ttc_user(first_pb: 1.day.ago)
    u.add_mood(moods: 1, :emotional_symptoms => {})
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You didn't log your mood.", pi.first["title"]
    assert_equal "It's okay and completely normal to have days when you just feel neutral. Experiencing and accepting a wide, complex range of emotions is healthy and good for our emotional well-being.", pi.first["body"]
  end

  # Stress insights

  def test_non_ttc_d_insights_stress_cd1
    u = create_non_ttc_user(first_pb: Time.now)
    u.add_stress
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_non_ttc_d_insights_medium_stress_cd2
    # low/med/hight -> 0-33/34-66/67-100
    # on client side, stress level range is 1 - 102, 1 means No
    # medium stress
    u = create_non_ttc_user(first_pb: 1.day.ago)
    u.add_stress(stress_level: 48)
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You're feeling stressed.", pi.first["title"]
    assert_equal "Managing stress effectively is very important for your health. The most commonly reported stress management activities include listening to music, exercising or walking, going online, watching TV or movies for more than two hours a day, and reading. Try one!", pi.first["body"]
  end

  def test_non_ttc_d_insights_low_stress_cd2
    # low stress
    u = create_non_ttc_user(first_pb: 1.day.ago)
    u.add_stress(stress_level: 32)
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You're feeling stressed.", pi.first["title"]
    assert_equal "Managing stress effectively is very important for your health. The most commonly reported stress management activities include listening to music, exercising or walking, going online, watching TV or movies for more than two hours a day, and reading. Try one!", pi.first["body"]
  end

  def test_non_ttc_d_insights_medium_stress_cd2
    # medium stress
    u = create_non_ttc_user(first_pb: 1.day.ago)
    u.add_stress(stress_level: 68)
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You're feeling stressed.", pi.first["title"]
    assert_equal "Managing stress effectively is very important for your health. The most commonly reported stress management activities include listening to music, exercising or walking, going online, watching TV or movies for more than two hours a day, and reading. Try one!", pi.first["body"]
    export_html('non_ttc_medium_stress_cd2.html', pi.first["html_body"])
  end

  def test_non_ttc_d_insights_high_stress_cd2
    # medium stress
    u = create_non_ttc_user(first_pb: 1.day.ago)
    u.add_stress(stress_level: 69)
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You're feeling stressed.", pi.first["title"]
    assert_equal "Managing stress effectively is very important for your health. The most commonly reported stress management activities include listening to music, exercising or walking, going online, watching TV or movies for more than two hours a day, and reading. Try one!", pi.first["body"]
    export_html('non_ttc_high_stress_cd2.html', pi.first["html_body"])
  end

  def test_non_ttc_d_insights_stress_no_stress_cd2
    # show Your current streak and Your longest streak
    u = create_non_ttc_user(first_pb: 1.day.ago)
    u.add_stress(stress_level: 1)
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You're not stressed!", pi.first["title"]
    assert_equal "You deserve a high five! Stress can have really negative impacts on your health so the fact that you've got yours in check is great. Whatever it is that you're doing is working, so keep it up!", pi.first["body"]
    export_html('non_ttc_no_stress_cd2.html', pi.first["html_body"])
  end

  def test_non_ttc_d_insights_stress_cd21
    # from CD 2 to CD 21, show both percentage and bar chart
    u = create_non_ttc_user(first_pb: 20.days.ago)
    u.add_stress
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal("You're feeling stressed.", pi.first["title"])
    assert_equal("Managing stress effectively is very important for your health. The most commonly reported stress management activities include listening to music, exercising or walking, going online, watching TV or movies for more than two hours a day, and reading. Try one!", pi.first["body"])
    export_html('non_ttc_stress_cd21.html', pi.first["html_body"])
  end

  def test_non_ttc_d_insights_stress_cd22
    # from CD 22 to CD 30, there should be no bar chart
    u = create_non_ttc_user(first_pb: 21.days.ago)
    u.add_stress
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    export_html('non_ttc_stress_cd22.html', pi.first["html_body"])
  end

  def test_non_ttc_d_insights_stress_cd30
    # from CD 22 to CD 30, there should be no bar chart
    u = create_non_ttc_user(first_pb: 29.days.ago, cycle_length: 40)
    u.add_stress
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size 
    export_html('non_ttc_stress_cd30.html', pi.first["html_body"]) 
  end

  def test_non_ttc_d_insights_stress_cd31
    # no comparative insight since CD 31
    u = create_non_ttc_user(first_pb: 30.days.ago, cycle_length: 40)
    u.add_stress
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  # Sleep
  # lambda user: user.has_sleep_today and 2 <= user.cycle_day <= 28
  def test_non_ttc_d_insights_sleep_cd1
    u = create_non_ttc_user(first_pb: Time.now)
    u.add_sleep
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_non_ttc_d_insights_sleep_cd2
    u = create_non_ttc_user(first_pb: 1.day.ago)
    u.add_sleep
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You slept 5.0 hours!", pi.first["title"]
    assert_equal "Sleep plays a vital role in good health and well-being throughout your life. Getting enough quality sleep at the right times can help protect your mental health, physical health, quality of life, and safety.", pi.first["body"]
    export_html('non_ttc_sleep_cd2_5hour.html', pi.first["html_body"]) 
  end

  def test_non_ttc_d_insights_sleep_cd28
    u = create_non_ttc_user(first_pb: 27.days.ago, cycle_length: 40)
    u.add_sleep
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You slept 5.0 hours!", pi.first["title"]
    assert_equal "Sleep plays a vital role in good health and well-being throughout your life. Getting enough quality sleep at the right times can help protect your mental health, physical health, quality of life, and safety.", pi.first["body"]
    export_html('non_ttc_sleep_cd28_5hour.html', pi.first["html_body"]) 
  end

  def test_non_ttc_d_insights_sleep_cd29
    u = create_non_ttc_user(first_pb: 29.days.ago, cycle_length: 40)
    u.add_sleep
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  # ovulation test
  # There should be no ovulation test insights for !TTC users
  def test_non_ttc_d_insights_ov_test_cd10
    u = create_non_ttc_user(first_pb: 9.days.ago, cycle_length: 40)
    u.add_ovulation_test
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_non_ttc_d_insights_ov_test_cd11
    u = create_non_ttc_user(first_pb: 10.days.ago, cycle_length: 40)
    u.add_ovulation_test
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
 end

  def test_non_ttc_d_insights_ov_test_cd19
    u = create_non_ttc_user(first_pb: 18.days.ago, cycle_length: 40)
    u.add_ovulation_test
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  # pregnancy test 
  # should be no pregnancy test for !TTC users
  def test_non_ttc_d_insights_pregnancy_test_cd1
    u = create_non_ttc_user(first_pb: Time.now)
    u.add_pregnancy_test
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_non_ttc_d_insights_pregnancy_test_cd21
    u = create_non_ttc_user(first_pb: 20.days.ago, cycle_length: 40)
    u.add_pregnancy_test
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_non_ttc_d_insights_pregnancy_test_cd22
    u = create_non_ttc_user(first_pb: 21.days.ago, cycle_length: 40)
    u.add_pregnancy_test
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  # Smoke 

  def test_non_ttc_d_insights_smoke_cd1
    # should be not insight
    u = create_non_ttc_user(first_pb: Time.now, cycle_length: 40)
    u.add_smoke
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_non_ttc_d_insights_smoke_cd2
    # lambda user: user.has_smoke_today and 2 <= user.cycle_day <= 28
    u = create_non_ttc_user(first_pb: 1.day.ago, cycle_length: 40)
    u.add_smoke
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal("You smoked.", pi.first["title"])
    assert_equal("There are tons of reasons to stop smoking, but the issue is that it's a lot easier said than done. But don't let that discourage you -- you can do it! First, learn about your options. The more prepared you are, the easier the process will be. Then, make a game plan tailored to your needs to break the addiction and quit for good.", pi.first["body"])
    export_html('non_ttc_smoke_cd2.html', pi.first["html_body"])
  end

  def test_non_ttc_d_insights_smoke_cd28
    # lambda user: user.has_smoke_today and 2 <= user.cycle_day <= 28
    u = create_non_ttc_user(first_pb: 27.days.ago, cycle_length: 40)
    u.add_smoke
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal("You smoked.", pi.first["title"])
    assert_equal("There are tons of reasons to stop smoking, but the issue is that it's a lot easier said than done. But don't let that discourage you -- you can do it! First, learn about your options. The more prepared you are, the easier the process will be. Then, make a game plan tailored to your needs to break the addiction and quit for good.", pi.first["body"])
    export_html('non_ttc_smoke_cd28.html', pi.first["html_body"])
  end

  def test_non_ttc_d_insights_smoke_cd29
    # lambda user: user.has_smoke_today and 2 <= user.cycle_day <= 28
    u = create_non_ttc_user(first_pb: 28.days.ago, cycle_length: 40)
    u.add_smoke
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_no_smoke
    u = create_non_ttc_user(first_pb: 1.day.ago, cycle_length: 40)
    u.add_smoke(smoke: 1)
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  # Drink
  def test_non_ttc_d_insights_drink_cd1
    u = create_non_ttc_user(first_pb: Time.now, cycle_length: 40)
    u.add_drink
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_non_ttc_d_insights_drink_cd2
    u = create_non_ttc_user(first_pb: 1.day.ago, cycle_length: 40)
    u.add_drink
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal("You had alcohol.", pi.first["title"])
    assert_equal("Light to moderate drinking, when spread throughout the week, has been linked to health benefits like reduced inflammation, good cholesterol levels, and improved insulin resistance. Women who had 3-15 drinks per week had 28% higher odds of being healthy. Moderation is key!", pi.first["body"])
  end

  def test_non_ttc_d_insights_drink_cd28
    u = create_non_ttc_user(first_pb: 27.days.ago, cycle_length: 40)
    u.add_drink
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal("You had alcohol.", pi.first["title"])
    assert_equal("Light to moderate drinking, when spread throughout the week, has been linked to health benefits like reduced inflammation, good cholesterol levels, and improved insulin resistance. Women who had 3-15 drinks per week had 28% higher odds of being healthy. Moderation is key!", pi.first["body"])
    export_html('non_ttc_drink_cd28.html', pi.first["html_body"])
  end

  def test_non_ttc_d_insights_drink_cd29
    u = create_non_ttc_user(first_pb: 28.days.ago, cycle_length: 40)
    u.add_drink
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_no_drink_cd2
    u = create_non_ttc_user(first_pb: 1.day.ago, cycle_length: 40)
    u.add_drink(drink: 1)
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

end