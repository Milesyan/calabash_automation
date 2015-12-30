require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'glow_ios_test'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class GlowTest < Minitest::Test
  include GlowIOS

  def setup
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

  # Sign up for all types of users
  def test_non_ttc_user_signup
    u = new_non_ttc_user
    assert_rc u.res
    u.login
    assert_equal 3, u.res["user"]["settings"]["current_status"]
  end

  def test_ttc_user_signup
    u = new_ttc_user
    assert_rc u.res
    u.login
    assert_equal 0, u.res["user"]["settings"]["current_status"]
  end

  def test_ft_prep_user_signup
    u = new_ft_user type: "prep"
    assert_rc u.res
    u.login
    assert_equal 4, u.res["user"]["settings"]["current_status"]
  end

  def test_ft_med_user_signup
    u = new_ft_user type: "med"
    assert_rc u.res
    u.login
    assert_equal 4, u.res["user"]["settings"]["current_status"]
  end

  def test_ft_iui_signup
    u = new_ft_user type: "iui"
    assert_rc u.res
    u.login
    assert_equal 4, u.res["user"]["settings"]["current_status"]
  end

  def test_ft_ivf_signup
    u = new_ft_user type: "ivf"
    assert_rc u.res
    u.login
    assert_equal 4, u.res["user"]["settings"]["current_status"]
  end

  def test_single_male_user_signup
    # single male's default status is TTC
    u = GlowUser.new.male_signup
    assert_rc u.res
    assert_equal 0, u.res["user"]["settings"]["current_status"]
  end

  def test_non_ttc_male_partner_signup
    # 3 for Non-TTC
    u = new_non_ttc_user
    u.invite_partner
    male_partner = GlowUser.new(email: u.partner_email, first_name: u.partner_first_name)
    male_partner.male_signup
    assert_rc male_partner.res
    assert_equal 3, male_partner.res["user"]["settings"]["current_status"]
  end

  def test_ttc_male_partner_signup
    # 0 for TTC
    u = new_ttc_user
    u.invite_partner
    male_partner = GlowUser.new(email: u.partner_email, first_name: u.partner_first_name)
    male_partner.male_signup
    assert_rc male_partner.res
    assert_equal 0, male_partner.res["user"]["settings"]["current_status"]
  end

  def test_prep_male_partner_signup
    u = new_ft_user type: "prep"
    u.invite_partner
    male_partner = GlowUser.new(email: u.partner_email, first_name: u.partner_first_name)
    male_partner.male_signup
    assert_rc male_partner.res
    assert_equal 4, male_partner.res["user"]["settings"]["current_status"]
  end

  def test_med_ttc_male_partner_signup
    u = new_ft_user type: "med"
    u.invite_partner
    male_partner = GlowUser.new(email: u.partner_email, first_name: u.partner_first_name)
    male_partner.male_signup
    assert_rc male_partner.res
    assert_equal 4, male_partner.res["user"]["settings"]["current_status"]
  end

  def test_iui_ttc_male_partner_signup
    u = new_ft_user type: "iui"
    u.invite_partner
    male_partner = GlowUser.new(email: u.partner_email, first_name: u.partner_first_name)
    male_partner.male_signup
    assert_rc male_partner.res
    assert_equal 4, male_partner.res["user"]["settings"]["current_status"]
  end

  def test_ivf_ttc_male_partner_signup
    # male partner should follow the primary user's current status
    # 4 for fertility treatment
    u = new_ft_user type: "ivf"
    u.invite_partner
    male_partner = GlowUser.new(email: u.partner_email, first_name: u.partner_first_name)
    male_partner.male_signup
    assert_rc male_partner.res
    assert_equal 4, male_partner.res["user"]["settings"]["current_status"]
  end

  def test_non_ttc_female_partner_signup
    # female partner should follow the primary female user's status
    # 3 for non ttc
    u = new_non_ttc_user.invite_partner
    female_partner = GlowUser.new(email: u.partner_email, first_name: u.partner_first_name)
    female_partner.ttc_signup
    assert_rc female_partner.res
    assert_equal 3, female_partner.res["user"]["settings"]["current_status"]
  end

  def test_ttc_female_partner_signup
    # female partner should follow the primary female user's status
    # 0 for non ttc
    u = new_ttc_user.invite_partner
    female_partner = GlowUser.new(email: u.partner_email, first_name: u.partner_first_name)
    female_partner.ttc_signup
    assert_rc female_partner.res
    assert_equal 0, female_partner.res["user"]["settings"]["current_status"]
  end

  def test_prep_female_partner_signup
    # 0 for fertility treatment
    u = new_ft_user type: "prep"
    u.invite_partner
    female_partner = GlowUser.new(email: u.partner_email, first_name: u.partner_first_name)
    female_partner.ttc_signup
    assert_rc female_partner.res
    assert_equal 4, female_partner.res["user"]["settings"]["current_status"]
  end

  def test_male_to_male_signup
    
  end

  def test_ttc_user_signup_less_than_13_years_old
    u = GlowUser.new.ttc_signup(age: 12)
    assert_equal 3008, u.res["rc"]
    assert_equal "We are sorry, you must be at least 13 years old to user Glow.", u.res["msg"]
  end

  def test_forgot_password_email
    u = new_ttc_user
    u.forgot_password("email_unregistered@abc.com")
    assert_equal "Email hasn't been registered.", eval(u.res)[:user][:msg]
    u.forgot_password(u.email)
    assert_equal u.email, eval(u.res)[:user][:email]
  end

  def test_login_correct_email_wrong_password
    u = new_ttc_user
    u.logout
    u.login(u.email, "wrongpassword")
    assert_equal 3024, u.res["user"]["rc"]
    assert_equal "Wrong email and password combination.", u.res["user"]["msg"]
  end

  def test_login_wrong_email_correct_password
    u = new_ttc_user
    u.logout
    u.login("wrong_#{u.email}", u.password)
    assert_equal 3024, u.res["user"]["rc"]
    assert_equal "Wrong email and password combination.", u.res["user"]["msg"]
  end

  def test_non_ttc_user_disconnect_male_partner
    # a partner follows the primary's status
    # even the partnership is disconnected, the status is still unchanged the for the partner
    u = new_non_ttc_user
    u.invite_partner
    male_partner = GlowUser.new(email: u.partner_email, first_name: u.partner_first_name)
    male_partner.male_signup
    assert_equal 3, male_partner.res["user"]["settings"]["current_status"]
    u.login.remove_partner
    assert_rc u.res
    male_partner.login
    assert_equal 3, male_partner.res["user"]["settings"]["current_status"]
  end

  def test_male_disconnect_primary_female_partner
    # a partner follows the primary's status
    # even the partnership is disconnected, the status is still unchanged the for the partner
    u = new_non_ttc_user
    u.invite_partner
    male_partner = GlowUser.new(email: u.partner_email, first_name: u.partner_first_name)
    male_partner.male_signup
    assert_equal 3, male_partner.res["user"]["settings"]["current_status"]
    male_partner.login.remove_partner
    assert_rc male_partner.res
    male_partner.login
    assert_equal 3, male_partner.res["user"]["settings"]["current_status"]
  end

  #--- Home ---
  def test_ttc_user_daily_log
    u = new_ttc_user.complete_daily_log
    assert_rc u.res
  end

  def test_ft_prep_user_daily_log
    u = new_ft_user(type: "prep").login.complete_tutorial.ft_complete_daily_log
    assert_rc u.res
  end

  def test_single_male_user_daily_log
    u = GlowUser.new.male_signup
    u.login.male_complete_tutorial.ttc_male_complete_daily_log
    assert_rc u.res
  end

  def test_single_male_user_notifications
    u = GlowUser.new.male_signup
    u.login.male_complete_tutorial.ttc_male_complete_daily_log
    u.pull_content
    notifications = u.res["user"]["notifications"]
    notifications.each do |n|
      puts n["text"]
    end
    # [bug]: the notifications are inappropriate for a male user
    # tracked on Asana: https://app.asana.com/0/61450049828079/71912927217766
  end

  def test_non_ttc_user_trigger_insight
    # trigger the insight "Your period does all sorts of things to your body and mind, but here's one you might not have heard before: some writers and authors say they are at their most creative when they begin their periods. So get out that journal and get brainstorming!"
    # the trigger date should be today
    u = new_non_ttc_user.login.complete_tutorial.complete_daily_log
    u.pull_content
    insights = u.res["user"]["insights"]
    insight_types = []
    insights.each do |insight|
      insight_types << insight["type"]
      assert_equal Time.now.strftime("%Y/%m/%d"), insight["date"] # the trigger date should be today
      puts insight["body"]
    end
    assert_equal [15001].sort, insight_types.sort
  end

  def test_ttc_user_trigger_insight
    u = new_ttc_user.login.complete_tutorial.complete_daily_log
    u.pull_content
    insights = u.res["user"]["insights"]
    insight_types = []
    insights.each do |insight|
      insight_types << insight["type"]
    end
    assert_equal [5304].sort, insight_types.sort
  end

  def test_ft_user_trigger_insight
    u = new_ft_user(type: "med").login.complete_tutorial.ft_complete_daily_log
    u.pull_content
    insights = u.res["user"]["insights"]
    insight_types = []
    insights.each do |insight|
      insight_types << insight["type"]
    end
    assert_equal [27622, 27610, 27632, 27637, 27624, 27631, 27626, 27634].sort, insight_types.sort
  end

  def test_ttc_user_should_see_her_male_partner_daily_log_summary
    # female TTC user should see her male partner's log summary
    u = new_ttc_user
    u.invite_partner
    male_partner = GlowUser.new(email: u.partner_email, first_name: u.partner_first_name)
    male_partner.male_signup.complete_tutorial.ttc_male_complete_daily_log
    u.login.pull_content
    partner_daily_data = u.res["user"]["partner"]["daily_data"].first
    assert_equal 28800, partner_daily_data["sleep"] # her partners slept 8 hours 
    assert_equal 34, partner_daily_data["fever"] # partner had fever
    assert_equal 18, partner_daily_data["heat_source"] # partner logged heat source
  end

  def test_male_partner_shoule_see_his_female_partner_daily_log_summary
    # male partner should see his female partner's daily log summary
    u = new_ttc_user
    u.invite_partner
    male_partner = GlowUser.new(email: u.partner_email, first_name: u.partner_first_name)
    u.login.complete_daily_log
    male_partner.male_signup.login.pull_content
    daily_data = male_partner.res["user"]["partner"]["daily_data"].first
    assert_equal 23130, daily_data["cervical_mucus"] # partner logged CM
    assert_equal 153722867280912930, daily_data["emotional_symptom_1"] # partner logged emotional symptom
    assert_equal 274, daily_data["intercourse"] # partner had intercourse
  end

  def test_important_tasks_take_ovulation_test
    # when avg_cycle_length = 28, first_pb is 14 days ago, today is the ovulation day
    u = new_ttc_user.get_daily_content
    assert_rc u.res
    assert u.res["daily_checks"].join.include? "Take an ovulation test."
  end

  def test_ttc_user_insights
    u = new_ttc_user
    u.login.pull_content
  end

  #--- Periods ---
  def test_add_periods
    u = new_ttc_user
    u.add_periods
    assert_rc u.res
    assert u.res["result"]["periods"]
  end

  #--- Me ---

  def test_turn_off_period_prediction
    u = new_ttc_user
    u.add_periods
    u.turn_off_period_prediction
    assert_rc u.res
  end

  def test_ft_fertility_tests
    u = new_ft_user type: "iui"
    u.login.add_fertility_tests
    assert_rc u.res
  end

  # Export pdf report
  def test_non_ttc_export_pdf
    u = new_non_ttc_user
    u.login.complete_daily_log
    sleep 2
    u.export_pdf
    assert_rc u.res
  end

  def test_ttc_export_pdf
    u = new_ttc_user
    u.login.complete_daily_log.female_complete_health_profile("ttc").export_pdf
    assert_rc u.res
  end

  def test_ft_prep_export_pdf
    u = new_ft_user(type: "prep")
    u.login.ft_complete_daily_log.female_complete_health_profile("ft").export_pdf
    assert_rc u.res
  end

  def test_ft_med_export_pdf
    u = new_ft_user(type: "med")
    u.login.ft_complete_daily_log.export_pdf
    assert_rc u.res
  end

  def test_ft_iui_export_pdf
    u = new_ft_user(type: "iui").ft_complete_daily_log.export_pdf
    assert_rc u.res
  end

  def test_ft_ivf_export_pdf
    u = new_ft_user(type: "ivf").ft_complete_daily_log.export_pdf
    assert_rc u.res
  end

  def test_change_password
    u = new_ttc_user
    u.login.complete_tutorial.change_password
    assert_rc u.res
    u.logout
    u.login(u.email, PASSWORD)
    assert_equal 3024, u.res["user"]["rc"]
    assert_equal "Wrong email and password combination.", u.res["user"]["msg"]
    u.login(u.email, NEW_PASSWORD)
    assert_equal u.email, u.res["user"]["email"]
  end

  # Health profile
  def test_female_non_ttc_health_profile
    u = new_non_ttc_user.female_complete_health_profile("non-ttc")
    assert_rc u.res
  end

  def test_ttc_complete_health_profile
    u = new_ttc_user.female_complete_health_profile("ttc")
    assert_rc u.res
  end

  def test_ft_complete_health_profile
    u = new_ft_user(type: "prep").female_complete_health_profile("ft")
    assert_rc u.res
  end


  #--- Community ---
  # --- Create a text/poll/photo/link topic ---
  def test_create_text_topic
    u = new_ttc_user
    u.create_topic
    # assert that the user_id in the topic should be the user's id
    assert_equal u.user_id, u.res["topic"]["user_id"]
  end

  def test_create_poll_topic
    u = new_ttc_user
    u.create_poll
    assert_equal u.user_id, u.res["result"]["user_id"]
  end

  def test_create_photo_topic
    
  end

  def test_create_link_topic

  end
  # --- Add comments to a topic
  def test_add_two_comments_to_a_topic
    u1 = new_ttc_user
    u2 = new_ttc_user
    u1.create_topic
    u2.reply_to_topic u1.topic_id
    u2.reply_to_topic u1.topic_id
    assert_equal u2.res["result"]["topic_id"], u1.topic_id
  end

  def test_add_image_comments_to_a_topic

  end

  def test_add_comment_and_subreply_to_a_topic
    u = new_ttc_user
    u.create_topic
    u.reply_to_topic u.topic_id
    u.reply_to_comment u.topic_id, u.reply_id
  end  

  def test_delete_topic
    u = new_ttc_user
    u.create_topic
    u.delete_topic u.topic_id
    assert_rc u.res
  end

#----- follow/unfollow/block/unblock users

  def test_follow_user
    u = new_ttc_user
    sleep 1
    u2 = new_non_ttc_user
    u.follow_user u2.user_id
    assert_rc u.res
  end

  def test_unfollow_user
    u = new_ttc_user
    sleep 1
    u2 = new_non_ttc_user
    u.follow_user u2.user_id
    u.unfollow_user u2.user_id
    assert_rc u.res
  end


  def test_block_user
    u = new_ttc_user
    sleep 1
    u2 = new_non_ttc_user
    u.block_user u2.user_id
    assert_rc u.res
  end


  def test_unblock_user
    u = new_ttc_user
    sleep 1
    u2 = new_non_ttc_user
    u.block_user u2.user_id
    u.unblock_user u2.user_id
    assert_rc u.res
  end

  def test_bookmark
    u = new_ttc_user
    u.create_topic
    u.bookmark_topic u.topic_id
    assert_rc u.res
  end


  def test_unbookmark
    u = new_ttc_user
    u.create_topic
    u.bookmark_topic u.topic_id
    u.unbookmark_topic u.topic_id
    assert_rc u.res
  end
#------------Up/Downvote topic/comment--------
  
  def test_upvote_topic
    u = new_ttc_user
    u.create_topic
    u.upvote_topic u.topic_id
    assert_rc u.res
  end

  def test_downvote_topic
    u = new_ttc_user
    u.create_topic
    u.downvote_topic u.topic_id
    assert_rc u.res
  end

  def test_upvote_comment
    u = new_ttc_user
    u.create_topic.reply_to_topic u.topic_id, :reply_content => "Test Upvote"
    u.upvote_comment u.topic_id, u.reply_id
    assert_rc u.res
  end

  def test_downvote_comment
    u = new_ttc_user
    u.create_topic.reply_to_topic u.topic_id, :reply_content => "Test Upvote"
    u.downvote_comment u.topic_id, u.reply_id
    assert_rc u.res
  end

  def test_report_topic
    reason_poll = ["Wrong group", "Rude", "Obscene", "Spam", "Solicitation"]
    u1 = new_ttc_user
    u1.create_topic
    2.times do
      u2 = new_ttc_user
      u2.report_topic u1.topic_id, reason_poll.sample
      assert_rc u2.res
    end
  end

  def test_report_comment
    reason_poll = ["Rude", "Obscene", "Spam", "Solicitation"]
    u1 = new_ttc_user
    u1.create_topic
    2.times do
      u2 = new_ttc_user
      u2.report_comment u1.topic_id,u1.reply_id,reason_poll.sample
      assert_rc u2.res
    end
  end
end












