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

  def create_ft_user(args = {})
    GlowUser.new(args).ft_signup(args).login.complete_tutorial
  end

  def export_html(name, content)
    File.open("./#{name}", 'w') { |file| file.write(content) }
  end
  
  # Dynamic insights, TTC, Sex

  def test_ft_d_insight_sex_cd1
    u = create_ft_user(first_pb: Time.now, type: "iui")
    u.add_sex
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }

    assert_equal 1, pi.size
    assert_equal "You had sex!", pi.first["title"]
    assert_equal 1, pi.first["is_premium"]
    export_html('ft_sex_cd1.html', pi.first["html_body"])
  end

  def test_ft_d_insight_sex_cd2
    # ONLY SHOWS FROM CD 2 TO CD 35
    u = create_ft_user(type: "iui", ft_startdate: 1.day.ago)
    u.add_sex
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }

    assert_equal 1, pi.size
    assert_equal "You had sex!", pi.first["title"]
    assert_equal 1, pi.first["is_premium"]
    export_html('ft_sex_cd2.html', pi.first["html_body"])
  end

  def test_ft_d_insight_sex_cd35
    u = create_ft_user(first_pb: 34.days.ago, cycle_length: 40, type: "iui", ft_startdate: 34.days.ago)
    u.add_sex
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }

    assert_equal 1, pi.size
    assert_equal "You had sex!", pi.first["title"]
    assert_equal 1, pi.first["is_premium"]
    export_html('ft_sex_cd35.html', pi.first["html_body"])
  end

  def test_ft_d_insight_sex_cd36
    u = create_ft_user(first_pb: 35.days.ago, cycle_length: 40, type: "iui", ft_startdate: 35.days.ago)
    u.add_sex
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }

    assert_equal 1, pi.size
    assert_equal "You had sex!", pi.first["title"]
    assert_equal 1, pi.first["is_premium"]
    export_html('ft_sex_cd36.html', pi.first["html_body"])
  end

  def test_ft_d_insight_sex_3_day_streak
    u = create_ft_user(first_pb: 29.days.ago, cycle_length: 40, type: "iui", ft_startdate: 29.days.ago)
    u.add_sex(date: 2.days.ago, sex: 8194)
    u.add_sex(date: 1.day.ago, sex: 8194)
    u.add_sex(sex: 8194)
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You had sex!", pi.first["title"]
    assert_equal 1, pi.first["is_premium"]
    export_html('ft_sex_3_day_streak.html', pi.first["html_body"])
  end

  def test_ft_d_insight_no_sex
    u = create_ft_user(first_pb: 2.days.ago, cycle_length: 40, type: "iui", ft_startdate: 2.days.ago)
    u.add_sex(sex: 1)
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You didn't have sex.", pi.first["title"]
    assert_equal 1, pi.first["is_premium"]
    assert_equal "Sometimes, sex while cycling can be difficult because certain medications can cause enlarged ovaries, which might make you feel uncomfortable. Or you may even feel too stressed. Whatever it is, just be sure to listen to your body and do what it is that feels best for you.", pi.first["body"]
    export_html('ft_no_sex.html', pi.first["html_body"])
  end

  # Menstrual Flow insights
  def test_ft_d_insights_period_flow_premium_user_cd1
    # SHOWS CD 1 - 4
    u = create_ft_user(first_pb: 2.days.ago, cycle_length: 40, type: "iui", ft_startdate: 2.days.ago)
    u.add_period_flow
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You recorded your menstrual flow.", pi.first["title"]
    assert_equal "While most women don't typically look forward to their periods, it's an important time for testing and to start the course of treatment. Be sure to set up your office visit so you don't miss the opportunity to begin cycling this month.", pi.first["body"]
    export_html('ft_menstrual_flow_cd1.html', pi.first["html_body"])
  end

  def test_ft_d_insights_period_flow_premium_user_cd4
    u = create_ft_user(first_pb: 3.days.ago, cycle_length: 40, type: "iui", ft_startdate: 3.days.ago)
    u.add_period_flow
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You recorded your menstrual flow.", pi.first["title"]
    assert_equal "While most women don't typically look forward to their periods, it's an important time for testing and to start the course of treatment. Be sure to set up your office visit so you don't miss the opportunity to begin cycling this month.", pi.first["body"]
    export_html('non_ttc_menstrual_flow_cd4.html', pi.first["html_body"])
  end

  def test_ft_d_insights_period_flow_premium_user_cd5
    u = create_ft_user(first_pb: 4.days.ago, cycle_length: 40, type: "iui", ft_startdate: 4.days.ago)
    u.set_premium
    u.add_period_flow
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  # CM Insights
  def test_ft_d_insights_cm_donot_show_during_cd1
    u = create_ft_user(first_pb: Time.now, cycle_length: 40, type: "iui", ft_startdate: Time.now, period_length: 4)
    u.add_cm
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_ft_d_insights_cm_donot_show_during_cd3
    u = create_ft_user(first_pb: 2.days.ago, cycle_length: 40, type: "iui", ft_startdate: 2.days.ago, period_length: 4)
    u.add_cm
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }

    assert_equal 0, pi.size
  end

  def test_ft_d_insights_cm_donot_show_during_period_cd5
    # the actual period length = period_length + 1
    u = create_ft_user(first_pb: 4.days.ago, cycle_length: 40, type: "iui", ft_startdate: 4.days.ago, period_length: 4)
    u.add_cm
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_ft_d_insights_cm_cd6
    # the actual period length = period_length + 1
    u = create_ft_user(first_pb: 5.days.ago, cycle_length: 40, type: "iui", ft_startdate: 5.days.ago, period_length: 4)
    u.add_cm
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }

    assert_equal 1, pi.size
    assert_equal "You checked your cervical mucus.", pi.first["title"]
    assert_equal "Many women undergoing fertility treatments still check their cervical mucus for additional cycle clues. Fertile cervical mucus (think eggwhites!) helps support sperm survival and assists in sperm motility. Here's a helpful hint -- remember, \"eggwhite\" cervical mucus is clear, not white.", pi.first["body"]
    export_html('ft_cm_cd6.html', pi.first["html_body"])
  end

  def test_ft_d_insights_cm_cd16
    u = create_ft_user(first_pb: 15.days.ago, cycle_length: 40, type: "iui", ft_startdate: 15.days.ago, period_length: 4)
    u.add_cm
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }

    assert_equal 1, pi.size
    assert_equal "You checked your cervical mucus.", pi.first["title"]
    assert_equal "Many women undergoing fertility treatments still check their cervical mucus for additional cycle clues. Fertile cervical mucus (think eggwhites!) helps support sperm survival and assists in sperm motility. Here's a helpful hint -- remember, \"eggwhite\" cervical mucus is clear, not white.", pi.first["body"]
    export_html('ft_cm_cd16.html', pi.first["html_body"])
  end

  def test_ft_d_insights_cm_cd17
    # CD 17 is 1 day after the fertile window (ft user may not have this fertile window)
    # for fertility treatment user, it should display
    u = create_ft_user(first_pb: 16.days.ago, cycle_length: 40, type: "prep", ft_startdate: 16.days.ago, period_length: 4)
    u.add_cm
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    
    assert_equal 1, pi.size
    assert_equal "You checked your cervical mucus.", pi.first["title"]
    assert_equal "Many women undergoing fertility treatments still check their cervical mucus for additional cycle clues. Fertile cervical mucus (think eggwhites!) helps support sperm survival and assists in sperm motility. Here's a helpful hint -- remember, \"eggwhite\" cervical mucus is clear, not white.", pi.first["body"]
    export_html('ft_cm_cd17.html', pi.first["html_body"])
  end

  def test_ft_d_insights_cm_cd19
    # show this insight for CD 19
    u = create_ft_user(first_pb: 18.days.ago, cycle_length: 40, type: "prep", ft_startdate: 18.days.ago, period_length: 4)
    u.add_cm
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    
    assert_equal 1, pi.size
    assert_equal "You checked your cervical mucus.", pi.first["title"]
    assert_equal "Many women undergoing fertility treatments still check their cervical mucus for additional cycle clues. Fertile cervical mucus (think eggwhites!) helps support sperm survival and assists in sperm motility. Here's a helpful hint -- remember, \"eggwhite\" cervical mucus is clear, not white.", pi.first["body"]
    export_html('ft_cm_cd19.html', pi.first["html_body"])
  end

  def test_ft_d_insights_cm_cd20
    # do not show this insight since CD 20
    u = create_ft_user(first_pb: 19.days.ago, cycle_length: 40, type: "prep", ft_startdate: 19.days.ago, period_length: 4)
    u.add_cm
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_ft_d_insights_cm_donot_show_during_period_no_cm_cd3
    u = create_ft_user(first_pb: 2.days.ago, cycle_length: 40, type: "ivf", ft_startdate: 2.days.ago, period_length: 4)
    u.add_cm(cm: 1)
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_ft_d_insights_no_cm_cd6
    u = create_ft_user(first_pb: 5.days.ago, cycle_length: 40, type: "ivf", ft_startdate: 5.days.ago, period_length: 4)
    u.set_premium
    u.add_cm(cm: 1) # 1 for No
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }

    assert_equal 1, pi.size
    assert_equal "You did not check your cervical mucus.", pi.first["title"]
    assert_equal "Many women undergoing fertility treatments still check their cervical mucus for additional cycle clues. Fertile cervical mucus (think eggwhites!) helps support sperm survival and assists in sperm motility. Here's a helpful hint -- remember, \"eggwhite\" cervical mucus is clear, not white.", pi.first["body"]
    export_html('ft_no_cm_cd6.html', pi.first["html_body"])
  end

  def test_non_ttc_d_insights_cm_premium_user_no_cm_cd19
    # show no CM insight for CD 19
    u = create_ft_user(first_pb: 18.days.ago, cycle_length: 40, type: "ivf", ft_startdate: 18.days.ago, period_length: 4)
    u.add_cm(cm: 1)
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You did not check your cervical mucus.", pi.first["title"]
    assert_equal "Many women undergoing fertility treatments still check their cervical mucus for additional cycle clues. Fertile cervical mucus (think eggwhites!) helps support sperm survival and assists in sperm motility. Here's a helpful hint -- remember, \"eggwhite\" cervical mucus is clear, not white.", pi.first["body"]
    export_html('non_ttc_no_cm_cd19.html', pi.first["html_body"])
  end

  # Exercise
  def test_ft_d_insights_exercise_cd1
    # no insights for CD 1
    u = create_ft_user(first_pb: Time.now, cycle_length: 40, type: "ivf", ft_startdate: Time.now, period_length: 4)
    u.add_exercise
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_ft_d_insights_exercise_cd2
    # ONLY SHOWS FROM CD 2 TO CD 35
    u = create_ft_user(first_pb: 1.day.ago, cycle_length: 40, type: "ivf", ft_startdate: 1.day.ago, period_length: 4)
    u.add_exercise
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal("You exercised!", pi.first["title"])
    assert_equal("Excellent! Exercise is important for your health, but keep in mind that when it comes the fertility treatments, the rules change a little bit. Try to avoid any strenuous activity, and as treatment progresses, it's best to stick to low-impact exercises, like walking, stretching or yoga, and light hand weights. If you have any questions, feel free to reach out to your doctor. ", pi.first["body"])
  end

  def test_ft_d_insights_exercise_cd35
    u = create_ft_user(first_pb: 34.days.ago, cycle_length: 40, type: "ivf", ft_startdate: 34.days.ago, period_length: 4)
    u.add_exercise
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal("You exercised!", pi.first["title"])
    assert_equal("Excellent! Exercise is important for your health, but keep in mind that when it comes the fertility treatments, the rules change a little bit. Try to avoid any strenuous activity, and as treatment progresses, it's best to stick to low-impact exercises, like walking, stretching or yoga, and light hand weights. If you have any questions, feel free to reach out to your doctor. ", pi.first["body"])
  end

  def test_ft_d_insights_exercise_cd36
    u = create_ft_user(first_pb: 35.days.ago, cycle_length: 40, type: "ivf", ft_startdate: 35.days.ago, period_length: 4)
    u.add_exercise
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_ft_d_insights_no_exercise_cd1
    # ONLY SHOWS FROM CD 2 TO CD 35
    u = create_non_ttc_user(first_pb: Time.now, cycle_length: 40)
    u.add_exercise(exercise: 1)
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_ft_d_insights_no_exercise_cd2
    u = create_ft_user(first_pb: 1.day.ago, cycle_length: 40, type: "ivf", ft_startdate: 1.day.ago, period_length: 4)
    u.add_exercise(exercise: 1)
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal("You didn't exercise.", pi.first["title"])
    assert_equal("It's okay to exercise while cycling. Just be sure to stay in your comfort zone. Try to avoid anything strenuous, and as treatment goes on, it's a good idea to keep to low-impact activities, like walking, stretching or yoga, and light hand weights. Ask your doctor if you have any questions about what you should or shouldn't do.", pi.first["body"])
  end

  def test_ft_d_insights_no_exercise_cd35
    u = create_ft_user(first_pb: 34.days.ago, cycle_length: 40, type: "ivf", ft_startdate: 34.days.ago, period_length: 4)
    u.add_exercise(exercise: 1)
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal("You didn't exercise.", pi.first["title"])
    assert_equal("It's okay to exercise while cycling. Just be sure to stay in your comfort zone. Try to avoid anything strenuous, and as treatment goes on, it's a good idea to keep to low-impact activities, like walking, stretching or yoga, and light hand weights. Ask your doctor if you have any questions about what you should or shouldn't do.", pi.first["body"])
  end

  def test_ft_d_insights_no_exercise_cd36
    u = create_ft_user(first_pb: 35.days.ago, cycle_length: 40, type: "ivf", ft_startdate: 35.days.ago, period_length: 4)
    u.add_exercise(exercise: 1)
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  # Physical symptoms
  def test_ft_d_insights_physical_symptoms_cd1
    # ONLY SHOWS FROM CD 2 TO CD 21
    u = create_ft_user(first_pb: Time.now, cycle_length: 40, type: "ivf", ft_startdate: Time.now, period_length: 4)
    u.add_physical_discomfort
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_ft_d_insights_physical_symptoms_cd2
    # ONLY SHOWS FROM CD 2 TO CD 21
    u = create_ft_user(first_pb: 1.day.ago, cycle_length: 40, type: "ivf", ft_startdate: 1.day.ago, period_length: 4)
    u.add_physical_discomfort
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal("You're experiencing side effects.", pi.first["title"])
    assert_equal("Many women find that fertility treatments are physically demanding. Side effects can range from symptoms such as nausea, pelvic discomfort, breast tenderness, insomnia, irritability, and/or mood swings. Whatever your symptoms might be, seek support and ask your doctor about what your options are for managing them.", pi.first["body"])
  end

  def test_ft_d_insights_physical_symptoms_cd21
    # ONLY SHOWS FROM CD 2 TO CD 21
    u = create_ft_user(first_pb: 20.days.ago, cycle_length: 40, type: "ivf", ft_startdate: 20.days.ago, period_length: 4)
    u.add_physical_discomfort
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal("You're experiencing side effects.", pi.first["title"])
    assert_equal("Many women find that fertility treatments are physically demanding. Side effects can range from symptoms such as nausea, pelvic discomfort, breast tenderness, insomnia, irritability, and/or mood swings. Whatever your symptoms might be, seek support and ask your doctor about what your options are for managing them.", pi.first["body"])
  end

  def test_ft_d_insights_physical_symptoms_cd2_yes_without_symptom
    u = create_ft_user(first_pb: 1.day.ago, cycle_length: 40, type: "ivf", ft_startdate: 1.day.ago, period_length: 4)
    u.add_physical_discomfort( :symptoms => {})
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal("You're experiencing side effects.", pi.first["title"])
    assert_equal("Many women find that fertility treatments are physically demanding. Side effects can range from symptoms such as nausea, pelvic discomfort, breast tenderness, insomnia, irritability, and/or mood swings. Whatever your symptoms might be, seek support and ask your doctor about what your options are for managing them.", pi.first["body"])
  end

  def test_ft_d_insights_physical_symptoms_cd2_no
    u = create_ft_user(first_pb: 1.day.ago, cycle_length: 40, type: "ivf", ft_startdate: 1.day.ago, period_length: 4)
    u.add_physical_discomfort( :symptoms => {}, physical_discomfort: 1)
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You didn't log any physical symptoms.", pi.first["title"]
    assert_equal "That's great news because there are a variety of symptoms that women can experience while cycling, such as nausea, cramping, bloating, pelvic discomfort, breast tenderness, insomnia, irritability, and/or mood swings. We're happy to hear that you're feeling good!", pi.first["body"]
  end

  # Mood insights

  def test_ft_d_insights_mood_cd1
    # ONLY SHOWS FROM CD 2 TO CD 21
    u = create_ft_user(first_pb: Time.now, cycle_length: 40, type: "ivf", ft_startdate: Time.now, period_length: 4)
    u.add_mood
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_ft_d_insights_mood_cd2
    u = create_ft_user(first_pb: 1.day.ago, cycle_length: 40, type: "ivf", ft_startdate: 1.day.ago, period_length: 4)
    u.add_mood
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You logged your mood.", pi.first["title"]
    assert_equal "It's normal to experience a wide range of emotions during the process of fertility treatment. Remember that this is a very exciting time, and try to work through your emotions without letting them overwhelm you. And if you need help, don't hesitate to seek support from loved ones or a professional.", pi.first["body"]
  end

  def test_ft_d_insights_mood_cd2_yes_without_mood
    u = create_ft_user(first_pb: 1.day.ago, cycle_length: 40, type: "ivf", ft_startdate: 1.day.ago, period_length: 4)
    u.add_mood( :emotional_symptoms => {})
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You did not log your mood.", pi.first["title"]
    assert_equal("It's normal to experience a wide range of emotions during the process of fertility treatment. Remember that this is a very exciting time, and try to work through your emotions without letting them overwhelm you. And if you need help, don't hesitate to seek support from loved ones or a professional.", pi.first["body"])
  end

  def test_ft_d_insights_mood_cd2_no_mood
    u = create_ft_user(first_pb: 1.day.ago, cycle_length: 40, type: "ivf", ft_startdate: 1.day.ago, period_length: 4)
    u.add_mood(moods: 1, :emotional_symptoms => {})
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You didn't log your mood.", pi.first["title"]
    assert_equal "Fertility treatment can be full of emotional ups and downs. Along with finding coping mechanisms that work for you, it can also be helpful to take an emotional break every now and then. Do something that you and your partner enjoy to take your minds off of TTC and treatment for a bit.", pi.first["body"]
  end

  # Stress insights

  def test_ft_d_insights_stress_cd1
    # SHOWS FROM CD 2 TO CD 21
    u = create_ft_user(first_pb: Time.now, cycle_length: 40, type: "ivf", ft_startdate: Time.now, period_length: 4)
    u.add_stress
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_ft_d_insights_medium_stress_cd2
    # low/med/hight -> 0-33/34-66/67-100
    # on client side, stress level range is 1 - 102, 1 means No
    # medium stress
    u = create_ft_user(first_pb: 1.day.ago, cycle_length: 40, type: "ivf", ft_startdate: 1.day.ago, period_length: 4)
    u.add_stress(stress_level: 48)
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You're feeling stressed.", pi.first["title"]
    assert_equal "Undergoing fertility treatments can be very challenging emotionally. You may go through ups and downs relating to treatment, but it's important to find ways to cope with the stress. Try meditation or relaxation techniques to help reduce your stress, tension, and anxiety so you can feel better.", pi.first["body"]
  end

  def test_ft_d_insights_stress_no_stress_cd2
    # show Your current streak and Your longest streak
    u = create_ft_user(first_pb: 1.day.ago, cycle_length: 40, type: "ivf", ft_startdate: 1.day.ago, period_length: 4)
    u.add_stress(stress_level: 1)
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You're not stressed!", pi.first["title"]
    assert_equal "You deserve a high five! Women undergoing fertility treatments typically report higher levels of stress so the fact that you've got yours in check is great. Whatever it is that you're doing is working, so keep it up!", pi.first["body"]
    export_html('ft_no_stress_cd2.html', pi.first["html_body"])
  end

  def test_ft_d_insights_stress_cd21
    # from CD 2 to CD 21, show both percentage and bar chart
    u = create_ft_user(first_pb: 20.days.ago, cycle_length: 40, type: "ivf", ft_startdate: 20.days.ago, period_length: 4)
    u.add_stress(stress_level: 48)
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You're feeling stressed.", pi.first["title"]
    assert_equal "Undergoing fertility treatments can be very challenging emotionally. You may go through ups and downs relating to treatment, but it's important to find ways to cope with the stress. Try meditation or relaxation techniques to help reduce your stress, tension, and anxiety so you can feel better.", pi.first["body"]
    export_html('ft_stress_cd21.html', pi.first["html_body"])
  end

  def test_ft_d_insights_stress_cd22
    # from CD 22 to CD 30, there should be no bar chart
    u = create_ft_user(first_pb: 21.days.ago, cycle_length: 40, type: "ivf", ft_startdate: 21.days.ago, period_length: 4)
    u.add_stress(stress_level: 48)
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    export_html('ft_stress_cd22.html', pi.first["html_body"])
  end

  def test_ft_d_insights_stress_cd30
    # from CD 22 to CD 30, there should be no bar chart
    u = create_ft_user(first_pb: 29.days.ago, cycle_length: 40, type: "ivf", ft_startdate: 29.days.ago, period_length: 4)
    u.add_stress(stress_level: 48)
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    export_html('ft_stress_cd30.html', pi.first["html_body"])
  end

  def test_ft_d_insights_stress_cd31
    # no comparative insight since CD 31
    u = create_ft_user(first_pb: 30.days.ago, cycle_length: 40, type: "ivf", ft_startdate: 30.days.ago, period_length: 4)
    u.add_stress(stress_level: 48)
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  # Sleep
  # lambda user: user.has_sleep_today and 2 <= user.cycle_day <= 28
  def test_ft_d_insights_sleep_cd1
    # ONLY SHOWS FROM CD 2 TO CD 30
    u = create_ft_user(first_pb: Time.now, cycle_length: 40, type: "ivf", ft_startdate: Time.now, period_length: 4)
    u.add_sleep
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_ft_d_insights_sleep_cd2
    u = create_ft_user(first_pb: 1.day.ago, cycle_length: 40, type: "ivf", ft_startdate: 1.day.ago, period_length: 4)
    u.add_sleep
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You slept 5.0 hours!", pi.first["title"]
    assert_equal "Good sleep habits play an important role in our health and fertility. Some studies show that not getting enough sleep increases levels of a certain hormone, prolactin, causing suppressed ovulation. So be sure to catch those Zzz's!", pi.first["body"]
    export_html('ft_sleep_cd2_5hour.html', pi.first["html_body"]) 
  end

  def test_ft_d_insights_sleep_cd30
    u = create_ft_user(first_pb: 29.days.ago, cycle_length: 40, type: "ivf", ft_startdate: 29.days.ago, period_length: 4)
    u.add_sleep
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You slept 5.0 hours!", pi.first["title"]
    assert_equal "Good sleep habits play an important role in our health and fertility. Some studies show that not getting enough sleep increases levels of a certain hormone, prolactin, causing suppressed ovulation. So be sure to catch those Zzz's!", pi.first["body"]
    export_html('ft_sleep_cd30_5hour.html', pi.first["html_body"]) 
  end

  def test_ft_d_insights_sleep_cd31
    u = create_ft_user(first_pb: 30.days.ago, cycle_length: 40, type: "ivf", ft_startdate: 30.days.ago, period_length: 4)
    u.add_sleep
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  # ovulation test
  # There should be no ovulation test insights for !TTC users
  def test_ft_d_insights_ov_test_cd10
    # THIS INSIGHT ONLY SHOWS DURING FERTILE WEEK.--> HARDCODED THE RANGE TO CD 11 TO CD 19 FOR ALL USERS
    u = create_ft_user(first_pb: 9.days.ago, cycle_length: 40, type: "ivf", ft_startdate: 9.days.ago, period_length: 4)
    u.add_ovulation_test
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_ft_d_insights_ov_test_cd11
    u = create_ft_user(first_pb: 10.days.ago, cycle_length: 40, type: "ivf", ft_startdate: 10.days.ago, period_length: 4)
    u.add_ovulation_test
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You took an ovulation test.", pi.first["title"]
    assert_equal "Ovulation kits help determine your fertile window by monitoring a surge in luteinizing hormone (LH), which triggers ovulation. Once the LH surge occurs, ovulation typically follows within 12 to 36 hours.", pi.first["body"]
  end

  def test_non_ttc_d_insights_ov_test_cd19
    u = create_ft_user(first_pb: 10.days.ago, cycle_length: 40, type: "ivf", ft_startdate: 10.days.ago, period_length: 4)
    u.add_ovulation_test
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You took an ovulation test.", pi.first["title"]
    assert_equal "Ovulation kits help determine your fertile window by monitoring a surge in luteinizing hormone (LH), which triggers ovulation. Once the LH surge occurs, ovulation typically follows within 12 to 36 hours.", pi.first["body"]
  end

  # pregnancy test 
  # should be no pregnancy test for !TTC users
  def test_ft_d_insights_pregnancy_test_cd1
    # THIS INSIGHTS ONLY SHOWS FROM CD 22 AND LATER
    u = create_ft_user(first_pb: Time.now, cycle_length: 40, type: "ivf", ft_startdate: Time.now, period_length: 4)
    u.add_pregnancy_test
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_ft_d_insights_pregnancy_test_cd21
    u = create_ft_user(first_pb: 20.days.ago, cycle_length: 40, type: "ivf", ft_startdate: 20.days.ago, period_length: 4)
    u.add_pregnancy_test
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_non_ttc_d_insights_pregnancy_test_cd22
    u = create_ft_user(first_pb: 21.days.ago, cycle_length: 40, type: "ivf", ft_startdate: 21.days.ago, period_length: 4)
    u.add_pregnancy_test
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 1, pi.size
    assert_equal "You took a pregnancy test.", pi.first["title"]
    assert_equal "We get how tough it is to wait until your clinic visit for pregnancy testing. If you absolutely can't hold back, try to use morning urine (since it's more concentrated) and wait to test until the first day of your missed period for the most accurate reading to avoid false results (negative or positive).", pi.first["body"]
  end

  # Smoke 
  # No smoke insights for FT users
  def test_ft_d_insights_no_smoke_cd2
    u = create_ft_user(first_pb: 1.day.ago, cycle_length: 40, type: "ivf", ft_startdate: 1.day.ago, period_length: 4)
    u.add_smoke
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_ft_d_insights_no_smoke_cd28
    # lambda user: user.has_smoke_today and 2 <= user.cycle_day <= 28
    u = create_ft_user(first_pb: 1.day.ago, cycle_length: 40, type: "ivf", ft_startdate: 1.day.ago, period_length: 4)
    u.add_smoke
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_ft_no_smoke
    u = create_ft_user(first_pb: 1.day.ago, cycle_length: 40, type: "ivf", ft_startdate: 1.day.ago, period_length: 4)
    u.add_smoke(smoke: 1)
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  # Drink
  # No smoke insights for FT users
  def test_ft_d_insights_no_drink_cd2
    u = create_ft_user(first_pb: 1.day.ago, cycle_length: 40, type: "ivf", ft_startdate: 1.day.ago, period_length: 4)
    u.add_drink
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_ft_d_insights_no_drink_cd28
    # lambda user: user.has_smoke_today and 2 <= user.cycle_day <= 28
    u = create_ft_user(first_pb: 1.day.ago, cycle_length: 40, type: "ivf", ft_startdate: 1.day.ago, period_length: 4)
    u.add_drink
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

  def test_ft_no_drink
    u = create_ft_user(first_pb: 1.day.ago, cycle_length: 40, type: "ivf", ft_startdate: 1.day.ago, period_length: 4)
    u.add_drink(drink: 1)
    insights = u.res["user"]["insights"]
    pi = insights.select { |i| i['is_premium'] == 1 }
    assert_equal 0, pi.size
  end

end