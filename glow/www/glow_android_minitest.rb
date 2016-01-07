require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'glow_android_test'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class GlowTest < Minitest::Test
  include GlowAndroid

  def setup
  end

  def new_ttc_user
    GlowUser.new.ttc_signup.login.complete_tutorial.join_group
  end
    
  def new_non_ttc_user
    GlowUser.new.non_ttc_signup.login.complete_tutorial.join_group
  end

  def new_ft_user(args = {})
    GlowUser.new.ft_signup(args).login.complete_tutorial
  end

  def assert_rc(res)
    assert_equal 0, res["rc"]
  end

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
    u = new_non_ttc_user
    u.invite_partner
    male_partner = GlowUser.new email: u.partner_email, first_name: u.partner_first_name
    male_partner.male_signup
    assert_rc male_partner.res
    assert_equal "M", male_partner.res["user"]["gender"]
    assert_equal false, male_partner.res["user"]["is_primary"]
    assert_equal 3, male_partner.res["user"]["settings"]["current_status"]
  end

  def test_ttc_male_partner_signup
    u = new_ttc_user
    u.invite_partner
    male_partner = GlowUser.new email: u.partner_email, first_name: u.partner_first_name
    male_partner.male_signup
    assert_rc male_partner.res
    assert_equal "M", male_partner.res["user"]["gender"]
    assert_equal(false, male_partner.res["user"]["is_primary"])
    assert_equal 0, male_partner.res["user"]["settings"]["current_status"]
  end

  def test_ft_prep_male_partner_signup
    u = new_ft_user type: "prep"
    u.invite_partner
    male_partner = GlowUser.new email: u.partner_email, first_name: u.partner_first_name
    male_partner.male_signup
    assert_rc male_partner.res
    assert_equal "M", male_partner.res["user"]["gender"]
    assert_equal(false, male_partner.res["user"]["is_primary"])
    assert_equal 4, male_partner.res["user"]["settings"]["current_status"]
    assert_equal 4, male_partner.res["user"]["settings"]["fertility_treatment"]
  end

  def test_ft_med_male_partner_signup
    u = new_ft_user type: "med"
    u.invite_partner
    male_partner = GlowUser.new email: u.partner_email, first_name: u.partner_first_name
    male_partner.male_signup
    assert_rc male_partner.res
    assert_equal "M", male_partner.res["user"]["gender"]
    assert_equal 2, male_partner.res["user"]["primary"]
    assert_equal(false, male_partner.res["user"]["is_primary"])
    assert_equal 4, male_partner.res["user"]["settings"]["current_status"]
    assert_equal 1, male_partner.res["user"]["settings"]["fertility_treatment"]
  end

  def test_ft_iui_male_partner_signup
    u = new_ft_user type: "iui"
    u.invite_partner
    male_partner = GlowUser.new email: u.partner_email, first_name: u.partner_first_name
    male_partner.male_signup
    assert_rc male_partner.res
    assert_equal "M", male_partner.res["user"]["gender"]
    assert_equal 2, male_partner.res["user"]["primary"]
    assert_equal(false, male_partner.res["user"]["is_primary"])
    assert_equal 4, male_partner.res["user"]["settings"]["current_status"]
    assert_equal 2, male_partner.res["user"]["settings"]["fertility_treatment"]
  end

  def test_ft_ivf_male_partner_signup
    u = new_ft_user type: "ivf"
    u.invite_partner
    male_partner = GlowUser.new email: u.partner_email, first_name: u.partner_first_name
    male_partner.male_signup
    assert_rc male_partner.res
    assert_equal "M", male_partner.res["user"]["gender"]
    assert_equal 2, male_partner.res["user"]["primary"]
    assert_equal false, male_partner.res["user"]["is_primary"]
    assert_equal 4, male_partner.res["user"]["settings"]["current_status"]
    assert_equal 3, male_partner.res["user"]["settings"]["fertility_treatment"]
  end

  def test_non_ttc_female_partner_signup
    u = new_non_ttc_user
    u.invite_partner
    female_partner = GlowUser.new email: u.partner_email, first_name: u.partner_first_name
    female_partner.ttc_signup
    assert_rc female_partner.res
    assert_equal "F", female_partner.res["user"]["gender"]
    assert_equal false, female_partner.res["user"]["is_primary"]
    assert_equal 3, female_partner.res["user"]["settings"]["current_status"]
  end

  def test_ttc_female_partner_signup
    u = new_ttc_user
    u.invite_partner
    female_partner = GlowUser.new email: u.partner_email, first_name: u.partner_first_name
    female_partner.non_ttc_signup
    assert_rc female_partner.res
    assert_equal "F", female_partner.res["user"]["gender"]
    assert_equal false, female_partner.res["user"]["is_primary"]
    assert_equal 0, female_partner.res["user"]["settings"]["current_status"]
  end

  def test_ft_iui_female_partner_signup
    u = new_ft_user type: "iui"
    u.invite_partner
    female_partner = GlowUser.new email: u.partner_email, first_name: u.partner_first_name
    female_partner.non_ttc_signup
    assert_rc female_partner.res
    assert_equal "F", female_partner.res["user"]["gender"]
    assert_equal false, female_partner.res["user"]["is_primary"]
    assert_equal 4, female_partner.res["user"]["settings"]["current_status"]
  end

  def test_male_invite_non_ttc_female_partner
    u = GlowUser.new.male_signup
    u.invite_partner
    female_partner = GlowUser.new email: u.partner_email, first_name: u.partner_first_name
    female_partner.non_ttc_signup
    assert_rc female_partner.res
    u.logout.login
    assert_equal "M", u.res["user"]["gender"]
    assert_equal 2, u.res["user"]["primary"]
    assert_equal 3, u.res["user"]["settings"]["current_status"]
  end

  def test_male_invite_ttc_female_partner
    u = GlowUser.new.male_signup
    u.invite_partner
    female_partner = GlowUser.new email: u.partner_email, first_name: u.partner_first_name
    female_partner.ttc_signup
    assert_rc female_partner.res
    u.logout.login
    assert_equal "M", u.res["user"]["gender"]
    assert_equal 2, u.res["user"]["primary"]
    assert_equal 0, u.res["user"]["settings"]["current_status"]
  end

  def test_male_invite_ft_iui_female_partner
    u = GlowUser.new.male_signup
    u.invite_partner
    female_partner = GlowUser.new email: u.partner_email, first_name: u.partner_first_name
    female_partner.ft_signup type: "iui"
    assert_rc female_partner.res
    u.logout.login
    assert_equal "M", u.res["user"]["gender"]
    assert_equal 2, u.res["user"]["primary"]
    assert_equal 4, u.res["user"]["settings"]["current_status"]
  end

  def test_male_to_male_signup
    u = GlowUser.new.male_signup
    u.invite_partner
    male_partner = GlowUser.new email: u.partner_email, first_name: u.partner_first_name
    male_partner.male_signup
    assert_equal "M", male_partner.res["user"]["gender"]
    assert_rc male_partner.res
    assert_equal 0, male_partner.res["user"]["settings"]["current_status"]
    assert male_partner.res["disconnected"]
  end

  # disconnect partner

  def test_primary_ttc_user_disconnect_male_partner
    u = new_ttc_user
    u.invite_partner
    male_partner = GlowUser.new email: u.partner_email, password: u.password
    male_partner.male_signup

    u.pull_content
    assert_equal male_partner.email, u.res["partner"]["email"]
    
    u.remove_partner # primary user disconnect male partner
    assert_rc u.res
    u.logout.login
    u.pull_content
    assert_empty u.res["partner"]
  end

  def test_male_partner_disconnect_primary_non_ttc_user
    u = new_non_ttc_user
    u.invite_partner
    male_partner = GlowUser.new email: u.partner_email, password: u.password
    male_partner.male_signup

    u.pull_content
    assert_equal male_partner.email, u.res["partner"]["email"]

    male_partner.remove_partner
    assert_rc male_partner.res
    u.logout.login
    u.pull_content
    assert_empty u.res["partner"]
  end

  def test_forgot_password_email
    u = new_ttc_user
    u.forgot_password("email_unregistered@abc.com")
    assert_equal 3021, u.res["rc"]
    assert_equal "Email hasn't been registered.", u.res["msg"]
    u.forgot_password(u.email)
    assert_equal u.email, u.res["email"]
  end

  def test_login_correct_email_wrong_password
    u = new_ttc_user
    u.login(u.email, "wrongpassword")
    assert_equal 3024, u.res["rc"]
    assert_equal "Wrong email and password combination.", u.res["msg"]
  end

  def test_login_wrong_email_correct_password
    u = new_ttc_user
    u.login("wrong_#{u.email}", u.password)
    assert_equal 3024, u.res["rc"]
    assert_equal "Wrong email and password combination.", u.res["msg"]
  end

  ####### Home #######

  def test_ttc_female_complete_daily_log
    u = new_ttc_user
    u.ttc_female_complete_daily_log
    assert_rc u.res
  end

  def test_non_ttc_user_add_10_days_daily_log
    u = new_non_ttc_user
    u.add_non_ttc_daily_log(10)
    assert_rc u.res
  end

  def test_ttc_user_add_10_days_daily_log
    u = new_ttc_user
    u.add_ttc_daily_log(10)
    assert_rc u.res
  end

  def test_ft_prep_user_add_10_days_daily_log
    u = new_ft_user type: "prep"
    u.add_ft_daily_log(10)
    assert_rc u.res
  end

  def test_ft_med_daily_log
    u = new_ft_user type: "med"
    u.add_ft_daily_log
    assert_rc u.res
  end

  def test_ft_iui_daily_log
    u = new_ft_user type: "iui"
    u.add_ft_daily_log
    assert_rc u.res
  end

  def test_ivf_daily_log
    u = new_ft_user type: "ivf"
    u.add_ft_daily_log
    assert_rc u.res
  end

  def test_single_male_user_daily_log
    u = GlowUser.new.male_signup
    u.male_complete_daily_log
    assert_rc u.res
  end

  def test_female_ttc_user_should_see_male_partner_daily_log_summary
    u = new_ttc_user.complete_tutorial.ttc_female_complete_daily_log
    u.invite_partner
    male_partner = GlowUser.new email: u.partner_email, password: u.password
    male_partner.male_signup.male_complete_daily_log
    u.pull_content
    partner_daily_data = u.res["partner"]["daily_data"].first
    #puts partner_daily_data
    assert_equal 5, partner_daily_data["alcohol"]
    assert_equal 2, partner_daily_data["erection"]
    assert_equal 34, partner_daily_data["heat_source"]
  end

  def test_male_user_should_see_female_partner_daily_log_summary
    u = new_ttc_user.complete_tutorial.ttc_female_complete_daily_log
    u.invite_partner
    male_partner = GlowUser.new email: u.partner_email, password: u.password
    male_partner.male_signup.male_complete_daily_log
    male_partner.pull_content
    partner_daily_data = male_partner.res["partner"]["daily_data"].first
    #puts partner_daily_data
    assert_equal 2570, partner_daily_data["cervical_mucus"]
    assert_equal 274, partner_daily_data["intercourse"]
    assert_equal 13, partner_daily_data["ovulation_test"]
  end

  def test_ttc_user_insights
    u = new_ttc_user
    u.pull_content
    insights = []
    u.res["insights"].each do |insight|
      insights << insight["id"]
    end
    # "vast majority of couples who diligently engage in ovulation tracking are able to achieve pregnancy within one year."
    assert_equal [5304].sort, insights.sort
  end

  def test_non_ttc_user_insights
    u = new_non_ttc_user
    u.pull_content
    insights = []
    u.res["insights"].each do |insight|
      insights << insight["id"]
    end
    assert_equal [15001].sort, insights.sort
  end

  def test_ft_iui_user_insights
    u = new_ft_user type: "iui"
    u.ft_complete_daily_log
    u.pull_content
    insights = []
    u.res["insights"].each do |insight|
      insights << insight["id"]
    end
    assert_equal [27310,27322,27324,27326,27331,27332,27334,27338,27342].sort, insights.sort
  end

  # Important tasks
  def test_ttc_user_take_ovulation_test
    u = new_ttc_user
    u.get_daily_tasks
    assert_rc u.res
    assert_equal "Take an ovulation test.", u.res["result"].first["title"]
  end

  def test_ft_iui_user_important_task
    u = new_ft_user type: "iui"
    u.get_daily_tasks
    assert_rc u.res
    assert_equal "Keep taking your prenatal vitamins.", u.res["result"].first["title"]
  end

  # Periods

  def test_add_periods
    u = new_ttc_user.add_periods
    assert_rc u.res
  end

  # Me

  def test_turn_off_period_prediction
    u = new_ttc_user.complete_tutorial
    u.turn_off_period_prediction
    assert_rc u.res
  end

  def test_ttc_fertility_tests
    u = new_ttc_user.complete_tutorial
    u.add_fertility_tests
    assert_rc u.res
  end

  def test_ft_fertility_tests
    u = new_ft_user type: "prep"
    u.add_fertility_tests
    assert_rc u.res
  end

  # PDF reports

  def test_non_ttc_export_report
    u = new_non_ttc_user.add_non_ttc_daily_log(2)
    u.add_periods
    u.export_pdf
    assert_rc u.res
  end

  def test_ttc_export_report
    u = new_ttc_user.add_ttc_daily_log(2)
    u.add_periods
    u.export_pdf
    assert_rc u.res
  end

  def test_ft_prep_export_report
    u = new_ft_user(type: "prep").add_ft_daily_log(2)
    u.export_pdf
    assert_rc u.res
  end

  def test_ft_iui_export_report
    u = new_ft_user(type: "iui").add_ft_daily_log(2)
    u.export_pdf
    assert_rc u.res
  end

  def test_non_ttc_health_profile
    u = new_non_ttc_user.complete_tutorial
    u.add_health_profile
    assert_rc u.res
  end

  def test_ttc_health_profile
    u = new_ttc_user.complete_tutorial
    u.add_health_profile
    assert_rc u.res
  end

  def test_ft_iui_health_profile
    u = new_ft_user(type: "iui").complete_tutorial
    u.add_health_profile("ft")
    assert_rc u.res
  end

  def test_community_create_topic
    u = new_ttc_user.complete_tutorial
    u.create_topic
    assert_rc u.res
  end

  def test_community_create_anonymous_topic
    u = new_ttc_user.complete_tutorial
    u.create_topic :group_id => GROUP_ID, :anonymous => 1
    assert_rc u.res
  end

  def test_community_create_topic_with_title_and_content
    u = new_ttc_user.complete_tutorial
    u.create_topic :topic_title => "hahahaha",:topic_content => "Test for www"
    assert_equal u.res["result"]["content"], "Test for www"
  end

  def test_community_create_poll
    u = new_ttc_user.complete_tutorial
    u.create_poll
    assert_rc u.res
  end

  def test_community_vote_poll
    u = new_ttc_user.complete_tutorial.create_poll 1,:topic_title => "Test vote poll"
    u.vote_poll u.topic_id,3 
    assert_rc u.res
  end

  def test_community_vote_poll_repeatedly
    u = new_ttc_user.complete_tutorial.create_poll 1,:topic_title => "Test vote poll"
    u.vote_poll u.topic_id,3
    assert_rc u.res
    u2 = new_non_ttc_user.complete_tutorial.vote_poll u.topic_id,2
    assert_rc u2.res
    u2.vote_poll u.topic_id,3
    assert_equal u2.res["msg"], "Already voted the poll"
  end

  def test_reply_to_topic
    u = new_ttc_user.complete_tutorial.create_topic 1
    u.reply_to_topic u.topic_id
    assert_equal u.res["result"]["topic_id"], u.topic_id
  end

  def test_reply_to_comment
    u = new_non_ttc_user.complete_tutorial.create_topic 1
    u.reply_to_topic u.topic_id
    u.reply_to_comment u.topic_id, u.reply_id
    assert_equal u.res["result"]["reply_to"], u.reply_id
  end

  def test_join_group
    u = new_non_ttc_user.complete_tutorial
    u.join_group 25
    assert_rc u.res
  end

  def test_leave_group
    u = new_ttc_user.complete_tutorial
    u.join_group 25
    u.leave_group 25
    assert_rc u.res
  end

  def test_delete_topic
    u = new_ttc_user.complete_tutorial
    u.create_topic
    u.delete_topic u.topic_id
    assert_rc u.res
  end

  def test_follow_user
    u = new_non_ttc_user.complete_tutorial
    u2 = new_ttc_user.complete_tutorial
    u.follow_user u2.user_id
    assert_rc u.res
  end

  def test_unfollow_user
    u = new_non_ttc_user.complete_tutorial
    u2 = new_ttc_user.complete_tutorial
    u.follow_user u2.user_id
    u.unfollow_user u2.user_id
    assert_rc u.res
  end

  def test_block_user
    u = new_ttc_user.complete_tutorial
    u2 = new_non_ttc_user.block_user u.user_id
    assert_rc u2.res
  end

  def test_unblock_user
    u = new_ttc_user.complete_tutorial
    u2 = new_non_ttc_user.block_user u.user_id
    u2.unblock_user u.user_id
    assert_rc u2.res
  end

  def test_bookmark_user
    u = new_ttc_user.create_topic
    u.bookmark_topic u.topic_id
    assert_rc u.res
  end

  def test_unbookmark_user
    u = new_ttc_user.create_topic
    u.bookmark_topic u.topic_id
    u.unbookmark_topic u.topic_id
    assert_rc u.res
  end

  def test_upvote_topic
    u = new_ttc_user.create_topic
    u.upvote_topic u.topic_id
    assert_rc u.res
  end

  def test_cancel_upvote_topic
    u = new_ttc_user.create_topic
    u.upvote_topic u.topic_id
    u.cancel_upvote_topic u.topic_id
    assert_rc u.res
  end

  def test_downvote_topic
    u = new_ttc_user.create_topic
    u.downvote_topic u.topic_id
    assert_rc u.res
  end

  def test_cancel_downvote_topic
    u = new_ttc_user.create_topic
    u.downvote_topic u.topic_id
    u.cancel_downvote_topic u.topic_id
    assert_rc u.res
  end

  def test_upvote_comment
    u = new_ttc_user.create_topic
    u.reply_to_topic u.topic_id
    u.upvote_comment u.topic_id, u.reply_id
    assert_rc u.res
  end

  def test_cancel_upvote_comment
    u = new_ttc_user.create_topic
    u.reply_to_topic u.topic_id
    u.upvote_comment u.topic_id, u.reply_id
    u.cancel_upvote_comment u.topic_id, u.reply_id
    assert_rc u.res
  end

  def test_downvote_comment
    u = new_ttc_user.create_topic
    u.reply_to_topic u.topic_id
    u.downvote_comment u.topic_id, u.reply_id
    assert_rc u.res
  end

  def test_cancel_upvote_comment
    u = new_ttc_user.create_topic
    u.reply_to_topic u.topic_id
    u.downvote_comment u.topic_id, u.reply_id
    u.cancel_downvote_comment u.topic_id, u.reply_id
    assert_rc u.res
  end

  def test_report_topic
    u = new_ttc_user.create_topic
    u2 = new_ttc_user.report_topic u.topic_id, "Other"
    assert_rc u2.res  
  end

  def test_report_comment
    u = new_ttc_user.create_topic
    u.reply_to_topic u.topic_id
    u2 = new_ttc_user.report_comment u.topic_id, u.reply_id, "Obscene"
    assert_rc u2.res
  end

  def test_five_like_trigger_notification
    u = new_ttc_user.create_topic
    u2 = new_ttc_user.upvote_topic u.topic_id
    u3 = new_ttc_user.upvote_topic u.topic_id    
    u4 = new_ttc_user.upvote_topic u.topic_id
    u5 = new_ttc_user.upvote_topic u.topic_id
    u6 = new_ttc_user.upvote_topic u.topic_id
    puts u.topic_id, u.user_id
  end

  def test_add_15_more_comments
    u = new_ttc_user.complete_tutorial
    3.times do
      u.create_topic
      u.reply_to_topic u.topic_id
    end
    puts "#{u.user_id} comment 3 times"
  end

  def test_prepare_notification
    u = new_ttc_user.join_group 1
    u.create_topic 1
    u2 = new_ttc_user
    u2.reply_to_topic u.topic_id
    u.reply_to_topic u.topic_id
    u2.reply_to_comment u.topic_id, u.reply_id
  end

  def test_get_all_groups
    u = new_ttc_user
    u.get_all_groups
    puts u.all_groups_id
  end

  def test_leave_all_groups
    u = new_ttc_user.leave_all_groups
    u.get_all_groups
    puts u.all_groups_id
    assert_equal u.all_groups_id, []
  end















end