module Minitest_android
  include TestHelper
  
    #--- Community ---
  # --- Create a text/poll/photo/link topic ---
  def test_create_text_topic
    u = forum_new_user
    u.create_topic
    # assert that the user_id in the topic should be the user's id
    assert_equal u.user_id, u.res["result"]["user_id"]
  end

  def test_create_poll_topic
    u = forum_new_user
    u.create_poll
    assert_equal u.user_id, u.res["result"]["user_id"]

  end

  def test_community_create_anonymous_topic
    u = forum_new_user
    u.create_topic :group_id => GROUP_ID, :anonymous => 1
    assert_rc u.res
  end

  def test_community_create_topic_with_title_and_content
    u = forum_new_user
    u.create_topic :topic_title => "hahahaha",:topic_content => "Test for www"
    assert_equal u.res["result"]["content"], "Test for www"
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
    u2.reply_to_topic u1.topic_id
    assert_equal u2.res["result"]["topic_id"], u1.topic_id
  end

  def test_add_comment_and_subreply_to_a_topic
    u = forum_new_user
    u.create_topic
    u.reply_to_topic u.topic_id
    u.reply_to_comment u.topic_id, u.reply_id
  end  

  def test_delete_topic
    u = forum_new_user
    u.create_topic
    u.delete_topic u.topic_id
    assert_rc u.res
  end

  #----- follow/unfollow/block/unblock users

  def test_follow_user
    u = forum_new_user
    sleep 1
    u2 = forum_new_user
    u.follow_user u2.user_id
    assert_rc u.res
  end

  def test_unfollow_user
    u = forum_new_user
    sleep 1
    u2 = forum_new_user
    u.follow_user u2.user_id
    u.unfollow_user u2.user_id
    assert_rc u.res
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
    u.unblock_user u2.user_id
    assert_rc u.res
  end

  def test_bookmark
    u = forum_new_user
    u.create_topic
    u.bookmark_topic u.topic_id
    assert_rc u.res
  end


  def test_unbookmark
    u = forum_new_user
    u.create_topic
    u.bookmark_topic u.topic_id
    u.unbookmark_topic u.topic_id
    assert_rc u.res
  end
  #------------Up/Downvote topic/comment--------
  
  def test_upvote_topic
    u = forum_new_user
    u.create_topic
    u.upvote_topic u.topic_id
    assert_rc u.res
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

  def test_leave_group
    u = forum_new_user
    u.leave_group 72057594037927941
  end

  def test_get_all_groups
    u = forum_new_user
    u.get_all_groups
  end

  def test_quit_all_groups
    u = forum_new_user
    u.get_all_groups
    u.all_group_ids.each do |group_id|
      u.leave_group group_id
    end
  end


  def test_quit_all_groups_method
    u = forum_new_user.leave_all_groups
  end

  def test_post_image
    u = forum_new_user
    u.create_photo
    assert_rc u.res
  end

  def test_create_group 
    u = forum_new_user
    u.create_group
    assert_equal u.res["group"]["creator_name"], u.first_name
  end

  def test_get_all_group_names
    u = forum_new_user
    assert u.get_all_group_names
  end
  
  def test_get_all_group_ids
    u = forum_new_user
    assert u.get_all_group_ids
  end

  def test_reply_to_topic
    u = forum_new_user.complete_tutorial.create_topic
    u.reply_to_topic u.topic_id
    assert_equal u.res["result"]["topic_id"], u.topic_id
  end

  def test_reply_to_comment
    u = forum_new_user.complete_tutorial.create_topic
    u.reply_to_topic u.topic_id
    u.reply_to_comment u.topic_id, u.reply_id
    assert_equal u.res["result"]["reply_to"], u.reply_id
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

  def test_premium_chat_on
    up = premium_login
    up.turn_on_chat
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
    u = forum_new_user
    up.follow_user u.user_id
    up.get_all_participants
    assert_rc up.all_participants
  end

  def test_remove_all_participants
    up = premium_login
    up.remove_all_participants
    assert_rc up.res
    up.get_all_participants
  end

  def test_remove_all_contacts
    up = premium_login
    up.remove_all_contacts
    assert_rc up.res
  end
  
  def test_establish_chat
    up = premium_login
    u = forum_new_user
    up.establish_chat u
    assert_rc up.res
    assert_rc u.res
  end
  
  def test_remove_all_blocked
    up = premium_login
    u = forum_new_user
    up.block_user u.user_id
    up.remove_all_blocked
    assert_rc up.res
  end

  def test_reset_all
    u = forum_new_user
    u.reset_all_flags_close_all
    u.get_user_info
    res = u.res["data"]
    all_flags = [res["chat_off"], res["discoverable"],res["hide_posts"],res["signature_on"]]
    assert_equal [1,0,1,0], all_flags
  end

  def test_notification
    u = forum_new_user
    u.create_topic
    u2 = forum_new_user
    u2.reply_to_topic u.topic_id
    sleep 1
    u.get_notification
    assert_equal 8, u.notifications[0]["button"]
    assert_equal 1050,u.notifications[0]["type"]
    assert_equal "You have a new comment",u.notifications[0]["text"]
  end

  def print_notification(user=self)
    user.pull
    assert user.notifications
  end  

  def test_chat_request_notification
    up = premium_login
    u = forum_new_user
    u.get_notification
    up.send_chat_request u.user_id
    puts "-------"
    u.get_notification
    print_notification u
    assert_equal 1100,u.notifications[0]["type"]
  end
  def test_accept_chat_notification
    u = forum_new_user
    u.get_notification
    up = premium_login
    u.send_chat_request up.user_id
    up.accept_chat
    u.get_notification
    print_notification u
    assert_equal 1102,u.notifications[0]["type"]
  end

  def test_created
    u = forum_new_user
    u.create_topic
    u.get_created
    assert_rc u.res
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
  end

  def test_old_client_no_recommended_people
    u_new = forum_new_user
    u_old = old_version_user
    u_new.discover
    assert u_new.res['recommended_people']
    u_old.discover
    assert_empty u_old.res['recommended_people']
  end

end








