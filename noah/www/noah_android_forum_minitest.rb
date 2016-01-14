require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'noah_android_forum_test'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class GlowTest < Minitest::Test
  include NoahForumAndroid

  def setup
  end

  def new_noah_user
    BabyUser.new.signup.login
  end

  def test_new_noah_user
    u = new_noah_user
    puts u.first_name
  end

  def test_user_becomes_mother
    u = new_noah_user
    baby = u.new_born_baby(relation: "Mother", gender: "M")
    u.add_born_baby(baby)
    assert_rc u.res
    actual_baby = u.res["data"]["Baby"]["update"].first
    assert_equal u.current_baby.first_name, actual_baby["first_name"]
    assert_equal u.current_baby.last_name, actual_baby["last_name"]
    assert_equal u.current_baby.gender, actual_baby["gender"]
    assert_equal u.user_id, actual_baby["owner_user_id"]
    assert_equal "Mother", u.res["data"]["UserBabyRelation"]["update"].first["relation"]
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

  def test_get_all_groups
    u = new_noah_user
    u.get_all_groups
  end

  def test_quit_all_groups
    u = new_noah_user
    u.get_all_groups
    u.all_group_ids.each do |group_id|
      u.leave_group group_id
    end
  end


  def test_quit_all_groups_method
    u = new_noah_user.leave_all_groups
  end

  def test_post_image
    u = new_noah_user
    u.create_photo
    assert_rc u.res
    puts u.res
  end

  def test_create_group 
    u = new_noah_user
    u.create_group
    assert_equal u.res["data"]["group"]["creator_name"], u.first_name
  end

  def test_get_all_group_names
    u = new_noah_user
    puts u.get_all_group_names
  end
  
  def test_get_all_group_ids
    u = new_noah_user
    puts u.get_all_group_ids
  end
end












