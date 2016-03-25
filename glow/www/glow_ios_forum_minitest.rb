require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'glow_ios_forum_test'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class GlowTest < Minitest::Test
  include GlowForumIOS

  def forum_new_user(args={})
    ForumUser.new(args).ttc_signup.login.complete_tutorial
  end
    
  def forum_new_user(args={})
    ForumUser.new(args).non_ttc_signup.login.complete_tutorial
  end

  def new_ft_user(args = {})
    ForumUser.new.ft_signup(args).login.complete_tutorial
  end

  def assert_rc(res)
    assert_equal 0, res["rc"]
  end

  #--- Community ---
  # --- Create a text/poll/photo/link topic ---
  def test_create_text_topic
    u = forum_new_user
    u.create_topic
    # assert that the user_id in the topic should be the user's id
    assert_equal u.user_id, u.res["topic"]["user_id"]
  end

  def test_create_poll_topic
    u = forum_new_user
    u.create_poll
    puts u.res
    assert_equal u.user_id, u.res["result"]["user_id"]
  end

  def test_create_photo_topic
    u = forum_new_user.complete_tutorial.leave_all_groups.join_group
    u.create_photo
    assert_rc u.res
  end

  def test_create_link_topic

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

  def test_prepare_notification
    u = forum_new_user.leave_all_groups.join_group 1
    u.create_topic :group_id => 1
    u2 = forum_new_user
    u2.reply_to_topic u.topic_id
    u.reply_to_topic u.topic_id
    u2.reply_to_comment u.topic_id, u.reply_id
  end

  def test_create_group 
    u = forum_new_user
    u.create_group
  end

  def test_create_multiple_groups
    u2 = forum_new_user
    20.times do |arg1|
      u = forum_new_user
      u.create_group :group_name => "Test group JOIN  #{arg1}"
      u2.join_group u.group_id
    end
  end

  def test_invite_friends
    u = forum_new_user
    2.times do
      u2 = forum_new_user :first_name=>"BothFollowandFollowing"
      u.follow_user u2.user_id
      u2.follow_user u.user_id
    end

    3.times do
      u2 = forum_new_user :first_name=>"My Follower"
      u2.follow_user u.user_id
    end      

    3.times do
      u2 = forum_new_user :first_name=>"My following"
      u.follow_user u2.user_id
    end

    puts "MY user id is >>>>>>> #{u.user_id} <<<<<<< Email #{u.email}"
  end



  def test_leo_group
    u = forum_new_user :first_name => "Glow"
    u.create_group :group_name => "Baby articles"
  end


  def test_miles
    u = forum_new_user
  end
  
  def test_get_all_group_names
    u = forum_new_user
    puts u.get_all_group_names
  end
  
  def test_mute_blockeds_notification
    u1 = forum_new_user
    u2 = forum_new_user
    u1.create_topic
    u1.reply_to_topic u1.topic_id
    u1.block_user u2.user_id
    5.times do
      u2.reply_to_comment u1.topic_id, u1.reply_id
    end
    u3 = forum_new_user
    u3.reply_to_comment u1.topic_id, u1.reply_id
    puts u1.email
  end

end












