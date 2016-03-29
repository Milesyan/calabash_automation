module Minitest_ios
  include TestHelper
  
  #--- Community ---
  # --- Create a text/poll/photo/link topic ---
  def test_create_text_topic
    u = forum_new_user
    u.create_topic
    # assert that the user_id in the topic should be the user's id
    u.code_name == 'emma'? (assert_equal u.user_id, u.res["topic"]["user_id"]):
      (assert_equal u.user_id, u.res["data"]["topic"]["user_id"])
  end

  def test_create_poll_topic
    u = forum_new_user
    u.create_poll
    u.code_name == 'emma'? (assert_equal u.user_id, u.res["result"]["user_id"]):
      (assert_equal u.user_id, u.res["data"]["result"]["user_id"])
  end


  # --- Add comments to a topic
  def test_add_two_comments_to_a_topic
    u1 = forum_new_user
    u2 = forum_new_user
    u1.create_topic
    u2.reply_to_topic u1.topic_id
    u2.reply_to_topic u1.topic_id
    u1.code_name == 'emma'? (assert_equal u1.topic_id,u2.res["result"]["topic_id"]):
      (assert_equal u1.topic_id,u2.res["data"]["result"]["topic_id"])
  end

  def test_add_image_comments_to_a_topic

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
    puts u.res
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
    u.code_name == 'emma'? (assert_equal u.user_id, u.res["group"]["creator_name"]):
      (assert_equal u.first_name, u.res["data"]["group"]["creator_name"])
  end

  def test_get_all_group_names
    u = forum_new_user
    puts u.get_all_group_names
  end
  
  def test_get_all_group_ids
    u = forum_new_user
    puts u.get_all_group_ids
  end

  def test_notification
    u = forum_new_user
    u.create_topic
    u2 = forum_new_user
    u2.reply_to_topic u.topic_id
  end

  def test_add_followings
    u1= forum_new_user
    puts u1.res
    2.times do
      u = forum_new_user
      u1.follow_user u.user_id
    end
  end

  def test_turn_off_chat
    u = forum_new_user
    u.turn_off_chat
    assert_rc u.res
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
    puts u1.res
    u1.code_name == 'emma'? (assert_equal u1.res["rc"], 8003):    
      (assert_equal u1.res["data"]["rc"], 8003)
  end

  def test_premium_request
    up = premium_login
    u = forum_new_user
    up.send_chat_request u.user_id
    assert_rc up.res
    u.get_request_id
    u.code_name == 'emma'? (puts u.res["requests"][0]["id"]):
      (puts u.res["data"]["requests"][0]["id"])
  end

  def test_accept_chat_request
    up = premium_login
    u = forum_new_user
    up.send_chat_request u.user_id
    u.accept_chat
    u.code_name == 'emma'? (assert_equal u.res["msg"], "Chat request is accepted."):
      (assert_equal u.res["data"]["msg"], "Chat request is accepted.")
  end

  def test_ignore_chat_request
    up = premium_login
    u = forum_new_user
    up.send_chat_request u.user_id
    u.ignore_chat
    u.code_name == 'emma'? (assert_equal u.res["msg"], "Chat request is rejected."):
      (assert_equal u.res["data"]["msg"], "Chat request is rejected.")
  end

  def test_remove_chat_false
    up = premium_login
    u = forum_new_user
    up.remove_chat u.user_id
    puts up.res
  end

  def test_remove_chat_true
    up = premium_login
    u = forum_new_user
    up.send_chat_request u.user_id
    u.accept_chat
    up.remove_chat u.user_id
    puts up.res
  end

  def test_get_participants
    up = premium_login
    up.get_all_participants
    puts up.all_participants
  end

  def test_remove_all_participants
    up = premium_login
    up.remove_all_participants
    up.get_all_participants
  end

  def test_remove_all_contacts
    up = premium_login
    up.remove_all_contacts
    puts up.res
  end

  def test_remove_all_blocked
    up = premium_login
    up.remove_all_blocked
    puts up.res
  end


  def test_establish_chat
    up = premium_login
    u = forum_new_user
    up.establish_chat u
    puts up.res
    puts u.res
  end

end





