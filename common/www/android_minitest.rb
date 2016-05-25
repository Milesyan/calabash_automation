module Minitest_android
  ENV_JENKINS = 1
  include TestHelper
  @@counter = 0
  @@counter2 = 0
  def forum_minitest_user
    if @@counter == 0 
      log_msg "CREATING FORUM USER"
      @@user = forum_new_user
      @@counter += 1
    end
    @@user
  end

  def premium_login
    if @@counter2 == 0
      log_msg "LOGIN PREMIUM USER"
      @@premium = premium_user
      @@counter2 +=1
    end
    return @@premium
  end

  def teardown()
    env_jenkins = ENV_JENKINS
    if ENV_JENKINS != 0
      sleep 1
      puts "ENV JENKINS"
    else 
      log_error "LOCAL TEST"
    end
  end

  def test_new_user_with_birthday
    u = forum_new_user :birthday => (Time.now - 30*365.25*24*3600).to_i
    log_msg u.birthday
    assert u.birthday
    assert_operator u.birthday, :>, 0
  end

  #--- Community ---
  # --- Create a text/poll/photo/link topic ---
  def test_create_text_topic
    u = forum_minitest_user
    u.create_topic
    assert_equal u.user_id, u.res["result"]["user_id"]
    assert_equal u.topic_title, u.res["result"]["title"]
  end

  def test_create_poll_topic
    u = forum_minitest_user
    u.create_poll
    assert_equal u.user_id, u.res["result"]["user_id"]
    assert_equal u.topic_title, u.res["result"]["title"]
  end

  def test_create_image_topic
    u = forum_minitest_user
    u.create_photo
    assert_rc u.res
    assert_contains 's3.amazonaws.com', u.res["result"]["content"], 'Does not contains image url'
  end

  def test_community_create_anonymous_topic
    u = forum_minitest_user
    u.create_topic  :anonymous => 1
    assert_equal 1, u.res['result']['flags']
  end

  def test_photo_TMI_anonymous
    u = forum_minitest_user
    u.create_photo :anonymous => 1, :tmi_flag => 1
    assert_equal 25, u.res['result']['flags']
  end

  def test_community_create_topic_with_title_and_content
    u = forum_minitest_user
    u.create_topic :topic_title => "hahahaha",:topic_content => "Test for www"
    assert_equal u.res["result"]["content"], "Test for www"
  end

  def test_community_vote_poll
    u = forum_minitest_user.create_poll :group_id => 1,:topic_title => "Test vote poll"
    u.vote_poll :topic_id => u.topic_id, :vote_index => 3 
    assert_rc u.res
  end

  def test_community_vote_poll_repeatedly
    u = forum_minitest_user.create_poll :topic_title => "Test vote poll"
    u.vote_poll :topic_id => u.topic_id, :vote_index => 3
    assert_rc u.res
    u2 = forum_new_user.vote_poll :topic_id => u.topic_id, :vote_index => 2
    assert_rc u2.res
    u2.vote_poll :topic_id => u.topic_id, :vote_index => 3
    assert_equal u2.res["msg"], "Already voted the poll"
  end

  # --- Add comments to a topic
  def test_add_two_comments_to_a_topic
    u1 = forum_new_user
    u2 = forum_new_user
    u1.create_topic
    u2.reply_to_topic u1.topic_id
    u2.reply_to_topic u1.topic_id
    assert_equal u2.res["result"]["topic_id"], u1.topic_id
  end

  def test_add_comment_and_subreply_to_a_topic
    u = forum_minitest_user
    u.create_topic
    u.reply_to_topic u.topic_id
    u.reply_to_comment u.topic_id, u.reply_id
  end  

  def test_add_comment_and_subreply_to_a_topic
    u = forum_minitest_user
    u1 = forum_new_user
    u.create_topic
    u.reply_to_topic u.topic_id
    u1.reply_to_comment u.topic_id, u.reply_id
    assert_equal u.topic_id, u1.res["result"]["topic_id"]
    assert_equal u.reply_id, u1.res["result"]["reply_to"]
    assert_equal u1.user_id, u1.res["result"]["user_id"]
  end 

  def test_delete_topic
    u = forum_minitest_user
    u.create_topic
    u.delete_topic u.topic_id
    assert_rc u.res
  end

  def test_delete_topic_fail
    u = forum_minitest_user
    u1 = forum_new_user
    u.create_topic
    u1.delete_topic u.topic_id
    assert_equal "You are not allowed to delete others' topic", u1.res["msg"]
    assert_equal 11, u1.res["rc"]
  end

  #----- follow/unfollow/block/unblock users
  def test_follow_user
    u = forum_minitest_user
    sleep 1
    u2 = forum_new_user
    u.follow_user u2.user_id
    assert_rc u.res
  end


  def test_unfollow_user
    u = forum_minitest_user
    sleep 1
    u2 = forum_new_user
    u.follow_user u2.user_id
    u.unfollow_user u2.user_id
    assert_rc u.res
  end


  def test_block_user
    u = forum_minitest_user
    sleep 1
    u2 = forum_new_user
    u.block_user u2.user_id
    assert_rc u.res
  end


  def test_unblock_user
    u = forum_minitest_user
    sleep 1
    u2 = forum_new_user
    u.block_user u2.user_id
    u.unblock_user u2.user_id
    assert_rc u.res
  end




  def test_bookmark_self
    u = forum_minitest_user
    u.create_topic
    u.bookmark_topic u.topic_id
    assert_rc u.res
  end


  def test_bookmark_other
    u = forum_minitest_user
    u.create_topic
    u2 = forum_new_user
    u2.bookmark_topic u.topic_id
    assert_rc u2.res
  end


  def test_unbookmark
    u = forum_minitest_user
    u.create_topic
    u.bookmark_topic u.topic_id
    u.unbookmark_topic u.topic_id
    assert_rc u.res
  end


  #------------Up/Downvote topic/comment-------
  def test_upvote_topic
    u = forum_minitest_user
    u.create_topic
    u.upvote_topic u.topic_id
    assert_rc u.res
  end


  def test_upvote_topic_deleted
    u = forum_minitest_user
    u.create_topic
    u.delete_topic u.topic_id
    u.upvote_topic u.topic_id
    assert_rc u.res

  end

  def test_downvote_topic
    u = forum_minitest_user
    u.create_topic
    u.downvote_topic u.topic_id
    assert_rc u.res
  end

  def test_upvote_comment
    u = forum_minitest_user
    u.create_topic.reply_to_topic u.topic_id, :reply_content => "Test Upvote"
    u.upvote_comment u.topic_id, u.reply_id
    assert_rc u.res
  end

  def test_downvote_comment
    u = forum_minitest_user
    u.create_topic.reply_to_topic u.topic_id, :reply_content => "Test Upvote"
    u.downvote_comment u.topic_id, u.reply_id
    assert_rc u.res
  end

  def test_downvote_comment_deleted
    u = forum_minitest_user
    u.create_topic.reply_to_topic u.topic_id, :reply_content => "Test Upvote"
    u.delete_topic u.topic_id
    u.downvote_comment u.topic_id, u.reply_id
    assert_equal 0, u.res["rc"]
  end

  def test_report_topic
    reason_poll = ["Wrong group", "Rude", "Obscene", "Spam", "Solicitation"]
    u1 = forum_new_user
    u1.create_topic
    2.times do
      u2 = forum_new_user
      u2.report_topic u1.topic_id, reason_poll.sample
      assert_rc u2.res
    end
  end

  def test_report_comment
    reason_poll = ["Rude", "Obscene", "Spam", "Solicitation"]
    u1 = forum_new_user
    u1.create_topic
    2.times do
      u2 = forum_new_user
      u2.report_comment u1.topic_id,u1.reply_id,reason_poll.sample
      assert_rc u2.res
    end
  end

  def test_cancel_downvote_topic
    u = forum_minitest_user.create_topic
    u.downvote_topic u.topic_id
    u.cancel_downvote_topic u.topic_id
    assert_rc u.res
  end

  def test_cancel_upvote_comment
    u = forum_minitest_user.create_topic
    u.reply_to_topic u.topic_id
    u.downvote_comment u.topic_id, u.reply_id
    u.cancel_downvote_comment u.topic_id, u.reply_id
    assert_rc u.res
  end

  #---------LEAVE GROUPS----------
  def test_leave_group
    u = forum_minitest_user
    u.leave_group 72057594037927941
    assert_rc u.res
  end

  def test_get_all_groups
    u = forum_minitest_user
    u.get_all_groups
    assert u.all_group_ids
    assert u.all_group_names
  end

  def test_quit_all_groups
    u = forum_new_user
    u.get_all_groups
    u.all_group_ids.each do |group_id|
      u.leave_group group_id
      assert_rc u.res
    end
  end

  def test_quit_all_groups_method
    u = forum_new_user.leave_all_groups
    assert_empty u.res["subscribed"]
  end



  def test_create_group 
    u = forum_minitest_user
    u.create_group
    assert_contains 's3.amazonaws.com', u.res["group"]["image"]
    assert_equal u.res["group"]["creator_name"], u.first_name
  end

  def test_get_all_group_names
    u = forum_minitest_user
    assert u.get_all_group_names
  end
  
  def test_get_all_group_ids
    u = forum_minitest_user
    assert u.get_all_group_ids
  end

  #---premium---
  def test_turn_off_chat
    u = forum_minitest_user
    u.turn_off_chat
    assert_rc u.res
    u.turn_on_chat
  end

  def test_turn_on_chat
    u = forum_minitest_user
    u.turn_off_chat
    u.turn_on_chat
    assert_rc u.res
  end

  def test_turn_off_signature
    u = forum_minitest_user
    u.turn_off_signature
    assert_rc u.res
  end
  
  def test_turn_on_signature
    u = forum_minitest_user
    u.turn_off_signature
    u.turn_on_signature
    assert_rc u.res
  end

  def test_send_chat_request
    u1 = forum_new_user
    u2 = forum_new_user
    u1.send_chat_request u2.user_id
    if u1.code_name == 'kaylee'
      assert_rc u1.res
    else 
      assert_equal u1.res['msg'], "Chat feature requires at least one premium user."
      assert_equal u1.res["rc"], 8003
    end
  end

  def test_premium_request
    up = premium_login
    u = forum_new_user
    up.send_chat_request u.user_id
    assert_rc up.res
    u.get_request_id
    assert u.res["requests"][0]["id"]
  end

  def test_accept_chat_request
    up = premium_login
    u = forum_new_user
    up.send_chat_request u.user_id
    u.accept_chat
    assert_equal "Chat request accepted!",u.res["msg"]
  end

  def test_ignore_chat_request
    up = premium_login
    u = forum_new_user
    up.send_chat_request u.user_id
    u.ignore_chat
    assert_equal "Chat request rejected!",u.res["msg"]
  end

  def test_remove_chat_false
    up = premium_login
    u = forum_new_user
    up.remove_chat u.user_id
    assert_rc up.res
  end

  def test_remove_chat_true
    up = premium_login
    u = forum_new_user
    up.send_chat_request u.user_id
    u.accept_chat
    up.remove_chat u.user_id
    assert_rc up.res
  end

  def test_get_participants
    up = premium_login
    u = forum_minitest_user
    up.establish_chat u
    up.get_all_participants
    assert up.all_participants
  end

  def test_remove_all_participants
    up = premium_login
    _temp = forum_new_user
    up.establish_chat _temp
    up.remove_all_participants
    assert_rc up.res
    up.get_all_participants
    assert_empty up.res['participants']
  end

  def test_remove_all_contacts
    up = premium_login
    u = forum_new_user
    up.establish_chat u
    up.remove_all_contacts
    assert_rc up.res
  end
  
  def test_remove_all_blocked
    up = premium_login
    u = forum_new_user
    up.block_user u.user_id
    up.remove_all_blocked
    assert_rc up.res
  end

  def test_establish_chat
    up = premium_login
    u = forum_new_user
    up.establish_chat u
    assert_rc up.res
    assert_rc u.res
  end
  
  def test_reset_all
    u = forum_new_user
    u.reset_all_flags_close_all
    u.get_user_info
    res = u.res["data"]
    all_flags = [res["chat_off"], res["discoverable"],res["hide_posts"],res["signature_on"]]
    assert_equal [1,0,1,0], all_flags
  end

  #-----CHAT-----
  def test_premium_login
    up = premium_user
    assert_rc up.res
  end

  def test_availability
    up = premium_login
    u = forum_new_user
    up.availability u.user_id
    assert_equal "Please send chat request first.", up.res["msg"]
    up.send_chat_request u.user_id
    up.availability u.user_id
    assert_equal "Your chat request is pending response.", up.res["msg"]
  end 

  def test_notification
    u = forum_minitest_user
    u.create_topic
    u2 = forum_new_user
    u2.reply_to_topic u.topic_id
    sleep 1
    u.get_notification
    assert_equal 8, u.notifications[0]["button"]
    assert_includes u.notifications.map {|n| n["type"]}, 1050
    assert_equal "You have a new comment",u.notifications[0]["text"]
  end

  def test_chat_request_notification
    up = premium_login
    u = forum_new_user
    u.get_notification
    up.send_chat_request u.user_id
    sleep 2
    puts "-------"
    u.get_notification

    assert_includes u.notifications.map {|n| n["type"]}, 1100
  end

  def test_accept_chat_notification
    u = forum_new_user
    u.get_notification
    up = premium_login
    u.send_chat_request up.user_id
    up.accept_chat
    u.get_notification

    assert_includes u.notifications.map {|n| n["type"]}, 1102
  end

  def test_created
    u = forum_minitest_user
    u.create_topic
    u.get_created
    assert_rc u.res
  end

  def test_blocked
    u = forum_minitest_user
    u1 = forum_new_user
    u.block_user u1.user_id
    u.get_blocked
    assert_rc u.res
  end

  def test_get_all_contacts
    up = premium_login 
    u = forum_minitest_user
    up.establish_chat u
    up.get_all_contacts
    assert_contains u.user_id,up.all_contacts
  end

  def test_old_client_no_recommended_people
    u_new = forum_new_user
    u_old = old_version_user
    u_new.discover
    assert u_new.res['recommended_people']
    u_old.discover
    assert_empty u_old.res['recommended_people']
  end

  def _test_sticker_pack_updates
    u = forum_minitest_user
    u.get_packs_updates
    assert_includes u.res.keys, 'updates'
  end

  def _test_stciker_packes_owned
    u = forum_minitest_user
    u.get_packs_updates
    returned_signature = u.res['updates']['signature']
    u.get_packs_updates :pack_signature => returned_signature
    assert_nil u.res['updates']
  end
  
  def _test_get_sticker_by_id
    u = forum_minitest_user
    u.get_packs_updates
    u.get_pack_by_id u.pack_list.sample
    assert_includes u.res['pack'].keys, 'pack_name'
  end

  def _test_get_sticker_by_wrong_id 
    u = forum_minitest_user
    u.get_pack_by_id 1
    assert_includes u.res, '500'
  end

  def _prepare_notification_data(user, ntf_type)
    case ntf_type
    when "1050","1085","1086","1087"
      n = {"1050"=>1, "1085"=>6, "1086"=>16,"1087"=>50}
      user.create_topic :topic_title => "notification_#{ntf_type}"
      other_user = forum_new_user
      n[ntf_type].times do
        other_user.reply_to_topic user.topic_id
      end
    when "1051"
      other_user = forum_new_user
      other_user.create_topic :topic_title => "notification_1051"
      user.reply_to_topic other_user.topic_id
      forum_new_user.reply_to_topic other_user.topic_id
    when "1053"
      user.create_topic :topic_title => "notification_1053"
      user.reply_to_topic user.topic_id
      other_user = forum_new_user :first_name => "Replier"
      other_user.reply_to_comment user.topic_id, user.reply_id, :reply_content => "Reply_1053"
    when "1055"
      user.create_topic :topic_title => "notification_1055"
      5.times do 
        forum_new_user.upvote_topic user.topic_id
      end
    when "1059"
      user.create_topic :topic_title => "notification_1059"
      user.reply_to_topic user.topic_id, :reply_content => "Reply_1059"
      4.times do
        forum_new_user.upvote_comment user.topic_id,user.reply_id
      end
    when "1060"
      user.create_poll :topic_title => "notification_1060"
      3.times do
        forum_new_user.vote_poll :topic_id => user.topic_id, :vote_index => [1,2,3].sample
      end
    when "1088", "1089"
      n = {"1088"=>1, "1089"=>6}
      user.create_photo :topic_title => "notification_#{$ntf_type}"
      other_user = forum_new_user
      n[ntf_type].times do
        other_user.reply_to_topic user.topic_id
      end
    when "1091"#,"1092"
      n = {"1091"=>1} #"1092"=>10
      n[ntf_type].times do
        u1 = forum_new_user
        u1.follow_user user.user_id
      end
    when "1056"
      temp_user1 = forum_new_user
      temp_user1.create_topic :topic_title=>"notification_1056"
      temp_user1.reply_to_topic temp_user1.topic_id, :reply_content=>"commentAAA"
      user.reply_to_comment temp_user1.topic_id,temp_user1.reply_id
      temp_user2 = forum_new_user
      temp_user2.reply_to_comment temp_user1.topic_id,temp_user1.reply_id, :reply_content=>"subreplyAAA"
    end
  end

  # def test_all_legacy_notifications
  #   ntf_list = ["1050","1085","1086","1087","1051", "1053", "1055",
  #     "1059", "1060", "1088", "1089", "1091","1056"]
  #   u = forum_minitest_user.pull
  #   ntf_list.each do |ntf_type|
  #     _prepare_notification_data u, ntf_type
  #     u.pull
  #     assert_includes u.notifications.map {|n| n["type"]}, ntf_type.to_i
  #   end
  # end  

  def test_all_legacy_notifications_1055
    u = forum_new_user.pull
    _prepare_notification_data u, '1050'
    u.pull
    assert_includes u.notifications.map {|n| n["type"]}, 1050
  end

  def test_all_legacy_notifications_1085
    u = forum_new_user.pull
    _prepare_notification_data u, '1085'
    u.pull
    assert_includes u.notifications.map {|n| n["type"]}, 1085
  end

  def test_all_legacy_notifications_1086
    u = forum_new_user.pull
    _prepare_notification_data u, '1086'
    u.pull
    assert_includes u.notifications.map {|n| n["type"]}, 1086
  end

  def test_all_legacy_notifications_1087
    u = forum_new_user.pull
    _prepare_notification_data u, '1087'
    u.pull
    assert_includes u.notifications.map {|n| n["type"]}, 1087
  end

  def test_all_legacy_notifications_1051
    u = forum_minitest_user.pull
    _prepare_notification_data u, '1051'
    u.pull
    assert_includes u.notifications.map {|n| n["type"]}, 1051
  end

  def test_all_legacy_notifications_1053
    u = forum_minitest_user.pull
    _prepare_notification_data u, '1053'
    u.pull
    assert_includes u.notifications.map {|n| n["type"]}, 1053
  end

  def test_all_legacy_notifications_1055
    u = forum_minitest_user.pull
    _prepare_notification_data u, '1055'
    u.pull
    assert_includes u.notifications.map {|n| n["type"]}, 1055
  end

  def test_all_legacy_notifications_1059
    u = forum_minitest_user.pull
    _prepare_notification_data u, '1059'
    u.pull
    assert_includes u.notifications.map {|n| n["type"]}, 1059
  end

  def test_all_legacy_notifications_1060
    u = forum_minitest_user.pull
    _prepare_notification_data u, '1060'
    u.pull
    assert_includes u.notifications.map {|n| n["type"]}, 1060
  end

  def test_all_legacy_notifications_1088
    u = forum_minitest_user.pull
    _prepare_notification_data u, '1088'
    u.pull
    assert_includes u.notifications.map {|n| n["type"]}, 1088
  end

  def test_all_legacy_notifications_1089
    u = forum_minitest_user.pull
    _prepare_notification_data u, '1089'
    u.pull
    assert_includes u.notifications.map {|n| n["type"]}, 1089
  end

  def test_all_legacy_notifications_1091
    u = forum_minitest_user.pull
    _prepare_notification_data u, '1091'
    u.pull
    assert_includes u.notifications.map {|n| n["type"]}, 1091
  end

  def test_all_legacy_notifications_1056
    u = forum_new_user.pull
    _prepare_notification_data u, '1056'
    u.pull
    assert_includes u.notifications.map {|n| n["type"]}, 1056
  end
end








