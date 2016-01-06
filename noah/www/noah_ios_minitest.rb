require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'noah_ios_test'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class NoahTest < Minitest::Test
  include NoahIOS

  def setup
  end

  def new_noah_user
    NoahUser.new.parent_signup.login.leave_group 72057594037927941
  end

  def test_new_noah_user
    u = new_noah_user
  end

  def assert_rc(res)
    assert_equal 0, res["rc"]
  end

  def test_noah_signup
    u = new_noah_user
    assert_rc u.res
  end

  def test_noah_login
    u = new_noah_user
    u.login
    assert_rc u.res
  end

  
  #--- Community ---
  # --- Create a text/poll/photo/link topic ---
  def test_create_text_topic
    u = new_noah_user
    u.create_topic
    # assert that the user_id in the topic should be the user's id
    assert_equal u.user_id, u.res["data"]["topic"]["user_id"]
  end

  def test_create_poll_topic
    u = new_noah_user
    u.create_poll
    assert_equal u.user_id, u.res["data"]["result"]["user_id"]
  end

  def test_create_photo_topic
    u = new_noah_user.join_group 1
    u.create_image
    assert_rc u.res
  end

  def test_create_link_topic

  end
  # --- Add comments to a topic
  def test_add_two_comments_to_a_topic
    u1 = new_noah_user
    u2 = new_noah_user
    u1.create_topic
    u2.reply_to_topic u1.topic_id
    u2.reply_to_topic u1.topic_id
    assert_equal u2.res["data"]["result"]["topic_id"], u1.topic_id
  end

  def test_add_image_comments_to_a_topic

  end

  def test_add_comment_and_subreply_to_a_topic
    u = new_noah_user
    u.create_topic
    u.reply_to_topic u.topic_id
    u.reply_to_comment u.topic_id, u.reply_id
  end  

  def test_delete_topic
    u = new_noah_user
    u.create_topic
    u.delete_topic u.topic_id
    assert_rc u.res
  end

#----- follow/unfollow/block/unblock users

  def test_follow_user
    u = new_noah_user
    sleep 1
    u2 = new_noah_user
    u.follow_user u2.user_id
    assert_rc u.res
  end

  def test_unfollow_user
    u = new_noah_user
    sleep 1
    u2 = new_noah_user
    u.follow_user u2.user_id
    u.unfollow_user u2.user_id
    assert_rc u.res
  end


  def test_block_user
    u = new_noah_user
    sleep 1
    u2 = new_noah_user
    u.block_user u2.user_id
    assert_rc u.res
  end


  def test_unblock_user
    u = new_noah_user
    sleep 1
    u2 = new_noah_user
    u.block_user u2.user_id
    u.unblock_user u2.user_id
    assert_rc u.res
  end

  def test_bookmark
    u = new_noah_user
    u.create_topic
    u.bookmark_topic u.topic_id
    assert_rc u.res
  end


  def test_unbookmark
    u = new_noah_user
    u.create_topic
    u.bookmark_topic u.topic_id
    u.unbookmark_topic u.topic_id
    assert_rc u.res
  end
#------------Up/Downvote topic/comment--------
  
  def test_upvote_topic
    u = new_noah_user
    u.create_topic
    u.upvote_topic u.topic_id
    assert_rc u.res
  end

  def test_downvote_topic
    u = new_noah_user
    u.create_topic
    u.downvote_topic u.topic_id
    assert_rc u.res
  end

  def test_upvote_comment
    u = new_noah_user
    u.create_topic.reply_to_topic u.topic_id, :reply_content => "Test Upvote"
    u.upvote_comment u.topic_id, u.reply_id
    assert_rc u.res
  end

  def test_downvote_comment
    u = new_noah_user
    u.create_topic.reply_to_topic u.topic_id, :reply_content => "Test Upvote"
    u.downvote_comment u.topic_id, u.reply_id
    assert_rc u.res
  end

  def test_report_topic
    reason_poll = ["Wrong group", "Rude", "Obscene", "Spam", "Solicitation"]
    u1 = new_noah_user
    u1.create_topic
    2.times do
      u2 = new_noah_user
      u2.report_topic u1.topic_id, reason_poll.sample
      assert_rc u2.res
    end
  end

  def test_report_comment
    reason_poll = ["Rude", "Obscene", "Spam", "Solicitation"]
    u1 = new_noah_user
    u1.create_topic
    2.times do
      u2 = new_noah_user
      u2.report_comment u1.topic_id,u1.reply_id,reason_poll.sample
      assert_rc u2.res
    end
  end

  def test_leave_group
    u = new_noah_user
    u.leave_group 72057594037927941
  end
  # def test_get_all_groups
  #   u = new_noah_user
  #   u.get_all_groups
  # end

  # def test_quit_all_groups
  #   u = new_noah_user
  #   u.get_all_groups
  #   u.all_groups_id.each do |group_id|
  #     u.leave_group group_id
  #   end
  # end


  # def test_quit_all_groups_method
  #   u = new_noah_user.leave_all_groups
  # end

end












