module Minitest_ios
  include TestHelper
  
  def test_new_user_with_birthday
    u = forum_new_user :birthday => (Time.now - 30*365.25*24*3600).to_i
    log_msg u.birthday
    assert u.birthday
    assert_operator u.birthday, :>, 0
  end
  
  #--- Community ---
  # --- Create a text/poll/photo/link topic ---
  def test_create_text_topic
    u = forum_new_user
    u.create_topic
    assert_equal u.user_id, u.res["topic"]["user_id"]
    assert_equal u.topic_title, u.res["topic"]["title"]
  end

  def test_create_poll_topic
    u = forum_new_user
    u.create_poll
    assert_equal u.user_id, u.res["result"]["user_id"]
    assert_equal u.topic_title, u.res["result"]["title"]
  end

  def test_create_image_topic
    u = forum_new_user
    u.create_photo
    assert_rc u.res
    assert_contains 's3.amazonaws.com', u.res["result"]["content"], 'Does not contains image url'
  end

  def test_community_create_anonymous_topic
    u = forum_new_user
    u.create_topic :anonymous => 1
    assert_equal 1, u.res['topic']['flags']
  end

  def test_photo_TMI_anonymous
    u = forum_new_user
    u.create_photo :anonymous => 1, :tmi_flag => 1
    assert_equal 25, u.res['result']['flags']
  end

  def test_community_create_topic_with_title_and_content
    u = forum_new_user
    u.create_topic :topic_title => "hahahaha",:topic_content => "Test for www"
    assert_equal u.res["topic"]["content"], "Test for www"
  end

  def test_community_vote_poll
    u = forum_new_user.create_poll :group_id => 1,:topic_title => "Test vote poll"
    u.vote_poll :topic_id => u.topic_id, :vote_index => 3 
    assert_rc u.res
  end

  def test_community_vote_poll_repeatedly
    u = forum_new_user.create_poll :topic_title => "Test vote poll"
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
    assert_equal u1.topic_id,u2.res["result"]["topic_id"]
    assert_equal u2.user_id,u2.res["result"]["user_id"]
  end

  def test_add_image_comments_to_a_topic
    u1 = forum_new_user
    u2 = forum_new_user
    u1.create_topic
    u2.reply_to_topic u1.topic_id
  end

  def test_add_comment_and_subreply_to_a_topic
    u = forum_new_user
    u1 = forum_new_user
    u.create_topic
    u.reply_to_topic u.topic_id
    u1.reply_to_comment u.topic_id, u.reply_id
    assert_equal u.topic_id, u1.res["result"]["topic_id"]
    assert_equal u.reply_id, u1.res["result"]["reply_to"]
    assert_equal u1.user_id, u1.res["result"]["user_id"]
  end  

  def test_delete_topic
    u = forum_new_user
    u.create_topic
    u.delete_topic u.topic_id
    assert_rc u.res
  end

  def test_delete_topic_fail
    u = forum_new_user
    u1 = forum_new_user
    u.create_topic
    u1.delete_topic u.topic_id
    assert_equal "Post deletion failed. Please try again later.", u1.res["msg"]
    assert_equal 1, u1.res["rc"]
  end

  #----- follow/unfollow/block/unblock users
  def test_follow_user
    u = forum_new_user
    sleep 1
    u2 = forum_new_user
    u.follow_user u2.user_id
    assert_rc u.res
    assert_equal 1, u.res["result"]
  end

  def test_unfollow_user
    u = forum_new_user
    sleep 1
    u2 = forum_new_user
    u.follow_user u2.user_id
    u.unfollow_user u2.user_id
    assert_rc u.res
    assert_equal 1, u.res["result"]
  end

  def test_block_user
    u = forum_new_user
    sleep 1
    u2 = forum_new_user
    u.block_user u2.user_id
    assert_rc u.res
  end


  def test_unblock_user
    u = forum_new_user
    sleep 1
    u2 = forum_new_user
    u.block_user u2.user_id
    assert_rc u.res
    assert_equal 1, u.res["result"]
    u.unblock_user u2.user_id
    assert_rc u.res
    assert_equal 1, u.res["result"]
  end

  def test_bookmark_self
    u = forum_new_user
    u.create_topic
    u.bookmark_topic u.topic_id
    assert_equal 1, u.res["result"]
    assert_rc u.res
  end

  def test_bookmark_other
    u = forum_new_user
    u.create_topic
    u2 = forum_new_user
    u2.bookmark_topic u.topic_id
    assert_equal 1, u2.res["result"]
    assert_rc u2.res
  end

  def test_unbookmark
    u = forum_new_user
    u.create_topic
    u.bookmark_topic u.topic_id
    u.unbookmark_topic u.topic_id
    assert_equal 1, u.res["result"]
    assert_rc u.res
  end

  #------------Up/Downvote topic/comment--------
  def test_upvote_topic
    u = forum_new_user
    u.create_topic
    u.upvote_topic u.topic_id
    assert_rc u.res
    assert_equal 1, u.res["result"]
  end

  def test_upvote_topic_deleted
    u = forum_new_user
    u.create_topic
    u.delete_topic u.topic_id
    u.upvote_topic u.topic_id
    assert_rc u.res
    assert_equal 1, u.res["result"]
  end

  def test_downvote_topic
    u = forum_new_user
    u.create_topic
    u.downvote_topic u.topic_id
    assert_rc u.res
  end

  def test_upvote_comment
    u = forum_new_user
    u.create_topic.reply_to_topic u.topic_id, :reply_content => "Test Upvote"
    u.upvote_comment u.topic_id, u.reply_id
    assert_rc u.res
  end

  def test_downvote_comment
    u = forum_new_user
    u.create_topic.reply_to_topic u.topic_id, :reply_content => "Test Upvote"
    u.downvote_comment u.topic_id, u.reply_id
    assert_rc u.res
  end

  def test_downvote_comment_deleted
    u = forum_new_user
    u.create_topic.reply_to_topic u.topic_id, :reply_content => "Test Upvote"
    u.delete_topic u.topic_id
    u.downvote_comment u.topic_id, u.reply_id
    assert_equal 6003, u.res["rc"]
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
    u = forum_new_user.create_topic
    u.downvote_topic u.topic_id
    u.cancel_downvote_topic u.topic_id
    assert_rc u.res
  end

  def test_cancel_upvote_comment
    u = forum_new_user.create_topic
    u.reply_to_topic u.topic_id
    u.downvote_comment u.topic_id, u.reply_id
    u.cancel_downvote_comment u.topic_id, u.reply_id
    assert_rc u.res
  end

  #---------LEAVE GROUPS----------
  def test_leave_group
    u = forum_new_user
    u.leave_group 1
    assert_rc u.res
  end

  def test_get_all_groups
    u = forum_new_user
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
    assert_equal nil, u.res["subscribed"]
    u.leave_all_groups
    assert_empty u.res['groups']
  end

  def test_create_group 
    u = forum_new_user
    u.create_group
    assert_contains 's3.amazonaws.com', u.res["group"]["image"]
    assert_equal u.first_name, u.res["group"]["creator_name"]
  end

  def test_get_all_group_names
    u = forum_new_user
    assert u.get_all_group_names
  end
  
  def test_get_all_group_ids
    u = forum_new_user
    assert u.get_all_group_ids
  end

  #---premium---
  def test_turn_off_chat
    u = forum_new_user
    u.turn_off_chat
    assert_rc u.res
    u.turn_on_chat
  end

  def test_turn_on_chat
    u = forum_new_user
    u.turn_off_chat
    u.turn_on_chat
    assert_rc u.res
  end
  
  def test_turn_off_signature
    u = forum_new_user
    u.turn_off_signature
    assert_rc u.res
  end
  
  def test_turn_on_signature
    u = forum_new_user
    u.turn_off_signature
    u.turn_on_signature
    assert_rc u.res
  end

  def test_send_chat_request
    u1 = forum_new_user
    u2 = forum_new_user
    u1.send_chat_request u2.user_id
    assert_equal u1.res["rc"], 8003
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
    assert_equal u.res["msg"], "Chat request is accepted."
  end

  def test_ignore_chat_request
    up = premium_login
    u = forum_new_user
    up.send_chat_request u.user_id
    u.ignore_chat
    assert_equal u.res["msg"], "Chat request is rejected."
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
    u = forum_new_user
    up.establish_chat u
    up.get_all_participants
    assert up.all_participants
  end

  def test_remove_all_participants
    up = premium_login
    up.remove_all_participants
    assert_empty up.res['participants']
    up.get_all_participants
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
    up = premium_login
    up.reset_all_flags
    assert_equal "Updated", up.res["msg"]
  end




  #-----CHAT-----
  def test_premium_login
    up = premium_login
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

  def print_notification(user=self)
    user.pull
    log_msg user.notifications
  end  

  def test_notification
    u = forum_new_user
    u.pull
    u.create_topic
    u2 = forum_new_user
    u2.reply_to_topic u.topic_id
    u.pull
    assert_equal 8, u.notifications[0]["button"]
    assert_equal 1050,u.notifications[0]["type"]
    assert_equal "You have a new comment",u.notifications[0]["text"]
  end

  def test_chat_request_notification
    up = premium_login
    u = forum_new_user
    u.get_notification
    up.send_chat_request u.user_id
    assert_rc up.res
    puts "-------------------------"
    u.get_notification
    assert_equal 1100,u.notifications[0]["type"]
  end

  def test_accept_chat_notification
    u = forum_new_user
    u.get_notification
    up = premium_login
    u.send_chat_request up.user_id
    up.accept_chat
    puts "-------------------------"
    u.get_notification
    assert_equal 1102,u.notifications[0]["type"]
  end

  def test_created
    u = forum_new_user
    u.create_topic
    u.get_created
    assert u.res
  end

  def test_blocked
    u = forum_new_user
    u1 = forum_new_user
    u.block_user u1.user_id
    u.get_blocked
    assert_rc u.res
  end

  def test_get_all_contacts
    up = premium_login 
    u = forum_new_user
    up.establish_chat u
    up.get_all_contacts
    assert_contains u.user_id,up.all_contacts
  end

  def test_old_client_no_recommended_people
    u_new = forum_new_user
    u_old = old_version_user
    u_new.discover
    assert u_new.res['people']
    u_old.discover
    assert_empty u_old.res['people']
  end

  def test_sticker_pack_updates
    u = forum_new_user
    u.get_packs_updates
    assert_includes u.res.keys, 'updates'
    puts u.res
  end

  def test_stciker_packes_owned
    u = forum_new_user
    u.get_packs_updates
    returned_signature = u.res['updates']['signature']
    u.get_packs_updates :pack_signature => returned_signature
    assert_nil u.res['updates']
  end

end



