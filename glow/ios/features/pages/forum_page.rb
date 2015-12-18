require 'calabash-cucumber/ibase'

class ForumPage < Calabash::IBase
  def trait
    "*"
  end

  def create_poll(anonymous=false)
    wait_touch "label text:'Poll'"
    title = "Your favorite drink? " + Time.now.strftime("%m%d-%H:%M:%S")
    answer1 = "Coke"
    answer2 = "Pepsi"
    answer3 = "Diet pepsi"
    description = "Your favorite?"
    wait_touch "UITextFieldLabel index:0"
    keyboard_enter_text title
    wait_for_none_animating
    wait_touch "UITextFieldLabel index:0"
    keyboard_enter_text answer1
    wait_for_none_animating
    wait_touch "UITextFieldLabel index:1"
    keyboard_enter_text answer2
    wait_for_none_animating
    wait_touch "UITextFieldLabel index:2"
    keyboard_enter_text answer3
    wait_for_none_animating
    wait_touch "* marked:'Description (optional)'"
    keyboard_enter_text description

    wait_touch "label text:'Next'"
    sleep 1
    # select the first group
    wait_touch "UITableViewCellContentView child label index:0"
    wait_touch "* marked:'Done!'"
    sleep 1
    check_element_exists "* marked:'#{title}'"

    $user.topic_title = title
  end

  def create_post(args={})
    wait_touch "label text:'Post'"
    wait_touch "UITextField"
    title = args[:title] || "Post " + Time.now.strftime("%m%d-%H:%M:%S")
    keyboard_enter_text title
    wait_touch "* marked:'Write a description!'"
    keyboard_enter_text args[:text] ||Time.now.to_s
    wait_touch "label text:'Next'"
    sleep 1
    # select the first group
    wait_touch "UITableViewCellContentView child label index:0"
    wait_touch "* marked:'Done!'"
    sleep 1
    #check_element_exists "* marked:'#{title}'"

    $user.topic_title = title
    puts $user.topic_title
  end

  def create_photo
    wait_touch "label text:'Photo'"
    wait_for_none_animating
    wait_touch "* marked:'Moments'"
    wait_for_none_animating
    wait_touch "PUPhotosGridCell index:0"
    wait_touch "label text:'Choose'"
    wait_for_none_animating
    wait_touch "label marked:'Write a caption...'"
    description = title = "Photo " + Time.now.strftime("%m%d-%H:%M:%S")
    keyboard_enter_text description
    wait_touch "* marked:'Next'"
    wait_touch "UITableViewCellContentView child label index:0"
    wait_touch "* marked:'Done!'"
    wait_for_none_animating
    wait_for_elements_exist "* marked:'Your topic is successfully posted!"
    sleep 3
  end

  def create_link
    wait_touch "UIButtonLabel text:' Link '"
    wait_for_none_animating
    keyboard_enter_text "http://www.baidu.com"
    wait_touch "all label text:'Say something about this link'"
    sleep 2
    keyboard_enter_text "Baidu"
    wait_touch "* marked:'Next'"
    wait_touch "UITableViewCellContentView child label index:0"
    wait_touch "* marked:'Done!'"
    sleep 1
    check_element_exists "label text:'百度一下，你就知道'"
  end

  def select_a_group
    wait_touch "UILabel index:2"
    wait_for_none_animating
  end
    
  def create_post_in_group(args={})
    wait_touch "label text:'Post'"
    wait_touch "UITextField"
    title = args[:title] || "Post " + Time.now.strftime("%m%d-%H:%M:%S")
    keyboard_enter_text title
    wait_touch "* marked:'Write a description!'"
    keyboard_enter_text args[:text] ||"Test post topic"+Time.now.to_s
    wait_touch "label text:'Post'"
    sleep 1
    # select the first group
    # wait_touch "UITableViewCellContentView child label index:0"
    # wait_touch "* marked:'Done!'"
    sleep 1
    #check_element_exists "* marked:'#{title}'"
    $user.topic_title = title
    @topic_title = title
    puts $user.topic_title
  end

  def discard_topic
    wait_touch "label text:'Close'"
    wait_touch "UILabel marked:'Discard'"
  end  

  def back_to_group
    wait_touch "label text:'Back'"
  end  
  

  def edit_topic(args1)
    wait_touch "label {text CONTAINS '#{args1}'} index:0"
    wait_touch "* id:'community-dots'"
    wait_touch "UILabel marked:'Edit this post'"
    wait_for_none_animating
    sleep 1
    puts $user.topic_title
    
    wait_touch "UIWebView"
    scroll "scrollView", :up
    wait_for_none_animating
    wait_touch "UITextFieldLabel"
    #keyboard_enter_text('Delete')
    keyboard_enter_text("Modified title")
    wait_touch "UIWebView index:0"
    keyboard_enter_text("Modified content")
    wait_touch "label text:'Update'"
  end

  def add_comment
    wait_touch "* marked:'Add a comment'"
    wait_for_none_animating
    comment = "comment " + Time.now.to_s
    keyboard_enter_text comment
    wait_touch "label text:'Post'"
    sleep 2
    # wait_for(:timeout => 10, :retry_frequency => 1) do
    #   element_exists "* all marked:'#{comment}'"
    # end
  end

  def add_comments(n)
    n.times do
      wait_touch "* marked:'Add a comment'"
      wait_for_none_animating
      comment = "comment " + Time.now.to_s
      keyboard_enter_text comment
      wait_touch "label text:'Post'"
      sleep 4
    end
  end
  def add_reply
    wait_touch "* marked:'Reply'"
    wait_for_none_animating
    reply = Time.now.to_s
    keyboard_enter_text reply
    wait_touch "* marked:'Send'"
  end

  def upvote_topic
    upvote_button = query("ForumUpvoteButton").last
    wait_touch upvote_button
    wait_for_none_animating
  end

  def upvote_reply
    wait_touch "ForumUpvoteButton"
  end

  def upvote_comment
    upvote_button = query("ForumUpvoteButton").first
    wait_touch upvote_button
    wait_for_none_animating
  end

  def downvote_topic
    
  end

  def downvote_comment
    
  end

  def downvote_reply
    
  end
end

