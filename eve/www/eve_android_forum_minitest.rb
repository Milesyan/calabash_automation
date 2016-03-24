require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'eve_android_forum_test'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class EveTest < Minitest::Test
  include EveForumAndroid

  def setup
  end

    
  def assert_rc(res)
    assert_equal 0, res["rc"]
  end


  def forum_new_user(args = {})
    u = ForumUser.new(args).signup_guest.sync_guest_info.sync_guest_info_2.get_daily_gems.signup_with_email
  end

  def test_forum_user
    u = forum_new_user
    puts u.res
  end

  def test_community_create_topic
    u = forum_new_user
    u.create_topic
    assert_rc u.res
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

  def test_community_create_poll
    u = forum_new_user
    u.create_poll
    assert_rc u.res
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

  def test_reply_to_topic
    u = forum_new_user.create_topic
    u.reply_to_topic u.topic_id
    assert_equal u.res["result"]["topic_id"], u.topic_id
  end

  def test_reply_to_comment
    u = forum_new_user.create_topic
    u.reply_to_topic u.topic_id
    u.reply_to_comment u.topic_id, u.reply_id
    assert_equal u.res["result"]["reply_to"], u.reply_id
  end

  def test_join_group
    u = forum_new_user
    u.join_group 25
    assert_rc u.res
  end

  def test_leave_group
    u = forum_new_user
    u.join_group 25
    u.leave_group 25
    assert_rc u.res
  end

  def test_delete_topic
    u = forum_new_user
    u.create_topic
    u.delete_topic u.topic_id
    assert_rc u.res
  end

  def test_follow_user
    u = forum_new_user
    u2 = forum_new_user
    u.follow_user u2.user_id
    assert_rc u.res
  end

  def test_unfollow_user
    u = forum_new_user
    u2 = forum_new_user
    u.follow_user u2.user_id
    u.unfollow_user u2.user_id
    assert_rc u.res
  end

  def test_block_user
    u = forum_new_user
    u2 = forum_new_user.block_user u.user_id
    assert_rc u2.res
  end

  def test_unblock_user
    u = forum_new_user
    u2 = forum_new_user.block_user u.user_id
    u2.unblock_user u.user_id
    assert_rc u2.res
  end

  def test_bookmark_user
    u = forum_new_user.create_topic
    u.bookmark_topic u.topic_id
    assert_rc u.res
  end

  def test_unbookmark_user
    u = forum_new_user.create_topic
    u.bookmark_topic u.topic_id
    u.unbookmark_topic u.topic_id
    assert_rc u.res
  end

  def test_upvote_topic
    u = forum_new_user.create_topic
    u.upvote_topic u.topic_id
    assert_rc u.res
  end

  def test_cancel_upvote_topic
    u = forum_new_user.create_topic
    u.upvote_topic u.topic_id
    u.cancel_upvote_topic u.topic_id
    assert_rc u.res
  end

  def test_downvote_topic
    u = forum_new_user.create_topic
    u.downvote_topic u.topic_id
    assert_rc u.res
  end

  def test_cancel_downvote_topic
    u = forum_new_user.create_topic
    u.downvote_topic u.topic_id
    u.cancel_downvote_topic u.topic_id
    assert_rc u.res
  end

  def test_upvote_comment
    u = forum_new_user.create_topic
    u.reply_to_topic u.topic_id
    u.upvote_comment u.topic_id, u.reply_id
    assert_rc u.res
  end

  def test_cancel_upvote_comment
    u = forum_new_user.create_topic
    u.reply_to_topic u.topic_id
    u.upvote_comment u.topic_id, u.reply_id
    u.cancel_upvote_comment u.topic_id, u.reply_id
    assert_rc u.res
  end

  def test_downvote_comment
    u = forum_new_user.create_topic
    u.reply_to_topic u.topic_id
    u.downvote_comment u.topic_id, u.reply_id
    assert_rc u.res
  end

  def test_cancel_upvote_comment
    u = forum_new_user.create_topic
    u.reply_to_topic u.topic_id
    u.downvote_comment u.topic_id, u.reply_id
    u.cancel_downvote_comment u.topic_id, u.reply_id
    assert_rc u.res
  end

  def test_report_topic
    u = forum_new_user.create_topic
    u2 = forum_new_user.report_topic u.topic_id, "Other"
    assert_rc u2.res  
  end

  def test_report_comment
    u = forum_new_user.create_topic
    u.reply_to_topic u.topic_id
    u2 = forum_new_user.report_comment u.topic_id, u.reply_id, "Obscene"
    assert_rc u2.res
  end

  def test_five_like_trigger_notification
    u = forum_new_user.create_topic
    u2 = forum_new_user.upvote_topic u.topic_id
    u3 = forum_new_user.upvote_topic u.topic_id    
    u4 = forum_new_user.upvote_topic u.topic_id
    u5 = forum_new_user.upvote_topic u.topic_id
    u6 = forum_new_user.upvote_topic u.topic_id
    puts u.topic_id, u.user_id
  end

  def test_add_15_more_comments
    u = forum_new_user
    3.times do
      u.create_topic
      u.reply_to_topic u.topic_id
    end
    puts "#{u.user_id} comment 3 times"
  end

  def test_prepare_notification
    u = forum_new_user.join_group 1
    u.create_topic
    u2 = forum_new_user
    u2.reply_to_topic u.topic_id
    u.reply_to_topic u.topic_id
    u2.reply_to_comment u.topic_id, u.reply_id
  end

  def test_get_all_groups
    u = forum_new_user
    u.get_all_groups
    puts u.all_group_ids
  end

  def test_leave_all_groups
    u = forum_new_user.leave_all_groups
    u.get_all_groups
    puts u.all_group_ids
    assert_equal u.all_group_ids, []
  end


  def test_post_image
    u = forum_new_user.join_group
    u.create_photo
    assert_rc u.res
  end

  def test_create_group
    u = forum_new_user
    u.create_group
  end

  def test_multiple_groups
    u = forum_new_user
    30.times do |n|
      u.create_group :group_name => "Test Load More #{n}"
    end
  end

  def test_temp
    u = forum_new_user.leave_all_groups
    3.times do
      u2 = forum_new_user.create_topic
      u.reply_to_topic u2.topic_id
    end 
  end

  def test_get_all_group_names
    u = forum_new_user
    puts u.get_all_group_names
  end

  def test_invite_friends
    u = forum_new_user
    10.times do |n|
      u2 = forum_new_user :first_name => "Follower#{n}<<<"
      u2.follow_user u.user_id
    end

    10.times do |n|
      u2 = forum_new_user :first_name => "Following#{n}<<<"
      u.follow_user u2.user_id
    end

    10.times do |n|
      u2 = forum_new_user :first_name => "Both#{n}<<<"
      u2.follow_user u.user_id
      u.follow_user u2.user_id
    end
  end

  def test_prepare
    15.times do
      u = forum_new_user
      u.reply_to_topic 3297
    end
  end


  def test_follow_user_2
    u = forum_new_user
    u.follow_user 6866
    assert_rc u.res
  end

end