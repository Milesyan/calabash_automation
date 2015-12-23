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
    wait_touch "PUAlbumListTableViewCell index:0"
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
    wait_touch "* marked:'Back'"
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

  def add_image_comment
    wait_touch "* marked:'Add a comment'"
    wait_for_none_animating
    comment = "Test image comment" 
    keyboard_enter_text comment
    wait_touch "UIButton marked:'gl community share story cam'"
    wait_touch "UILabel marked:'Choose from library'"
    wait_touch "PUAlbumListTableViewCell index:0"
    wait_for_none_animating
    wait_touch "PUPhotosGridCell index:1"
    wait_for_none_animating
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
    until_element_exists("* marked:'Reply'", :timeout => 3 , :action => lambda {swipe :up, :"swipe-delta" =>{:vertical => {:dx=> 0, :dy=> 200} }})
    wait_touch "* marked:'Reply'"
    wait_for_none_animating
    keyboard_enter_text Time.now.to_s
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
 
  def delete_topic(args)
    wait_touch "* id:'community-dots' index:#{args}"
    wait_touch "UILabel marked:'Delete this post'"
    wait_for(:timeout=>3){element_exists "label {text BEGINSWITH 'Are you sure you want to delete this topic?'}"}
    wait_touch "UILabel marked:'OK'"
  end

  def delete_comment(args)
    wait_touch "* id:'community-dots' index:#{args}"
    wait_touch "UILabel marked:'Delete'"
    wait_for(:timeout=>3){element_exists "label {text BEGINSWITH 'Are you sure you want to delete this post?'}"}
    wait_touch "UILabel marked:'OK'"
  end


  def enter_topic(args1)
    wait_touch "label {text CONTAINS '#{args1}'} index:0"
  end

  def scroll_to_see(gesture,content)
    if gesture == "up"
      until_element_exists("* marked:'#{content}'", :timeout => 30 , :action => lambda {swipe :down, :"swipe-delta" =>{:vertical => {:dx=> 0, :dy=> 368} }})
    elsif  gesture == "down"
      until_element_exists("* marked:'#{content}'", :timeout => 30 , :action => lambda {swipe :up, :"swipe-delta" =>{:vertical => {:dx=> 0, :dy=> 368} }})
    else 
      puts "Gesture  Error"
    end
  end 

  def evoke_search_bar
    swipe :down, force: :strong
    wait_touch "UIButton marked:'Topics/Comments'"
  end

  def search_topics(args)
    wait_touch "UISegment marked:'Topics'"
    puts "Search for topic: #{args}"
    keyboard_enter_text args
    tap_keyboard_action_key
  end 

  def search_comments(args)
    wait_touch "UISegment marked:'Comments'"
    puts "Search for comment: #{args}"
    keyboard_enter_text args
    tap_keyboard_action_key
  end

  def scroll_down_to_see(args)
    puts "* marked:'#{args}'"
    until_element_exists("* marked:'#{args}'", :timeout => 10 , :action => lambda {swipe :up, :"swipe-delta" =>{:vertical => {:dx=> 0, :dy=> 300} }})
  end

  def scroll_up_to_see(args)
    until_element_exists("* marked:'#{args}'", :timeout => 10 , :action => lambda {swipe :down, :"swipe-delta" =>{:vertical => {:dx=> 0, :dy=> 300} }})
  end

  def click_cancel
    wait_touch "* marked:'Cancel'"
  end

  def show_entire_discussion
    wait_touch "UIButtonLabel marked:'Show entire discussion'"
  end

  def view_all_replies
    wait_touch "UILabel marked:'View all replies'"
  end

  def touch_search_result(args1, args2 = 1)
    wait_touch "UILabel marked:'#{args1}' index:#{args2}"
  end 

  def check_search_result_comment(search_result)
    random_number = Random.rand($comment_number.to_i).to_i+1
    search_content  = "#{search_result} #{random_number}"
    puts "Search for #{search_content}"
    forum_page.scroll_down_to_see search_content
    forum_page.touch_search_result search_content,0
    wait_for_elements_exist("* marked:'#{search_content}'")
    forum_page.show_entire_discussion
    puts "See element '#{search_result} #{random_number}'"
  end

  def check_search_result_subreply(search_result)
    random_number = Random.rand($subreply_number.to_i).to_i+1
    search_content  = "#{search_result} #{random_number}"
    puts "Search for #{search_content}"
    forum_page.scroll_down_to_see search_content
    forum_page.touch_search_result search_content,0
    forum_page.show_entire_discussion
    forum_page.view_all_replies
    puts "Finding element '#{search_content}'"
    forum_page.scroll_up_to_see search_content
  end

  def check_search_result_deleted(string)
    wait_touch "UILabel marked:'#{string}' index:1"
    wait_for_elements_exist("* {text CONTAINS 'This post has been removed'}", :timeout => 3)
    wait_touch "* marked:'OK'"
  end

  def long_press(args)
    x = query("* marked:'#{args}'")[0]["rect"]["x"]
    y = query("* marked:'#{args}'")[0]["rect"]["y"]
    puts "coordinate of item is x => #{x}, y => #{y}"
    send_uia_command({:command => %Q[target.tapWithOptions({x: #{x}, y: #{y}}, {tapCount: 1, touchCount: 1, duration: 2.0})]})
  end

  def join_group(args)
    wait_touch "* marked:'Join' index:0"
    wait_for_none_animating
    wait_touch "* marked:'#{args}'"
  end  
  
  def leave_group
    wait_touch "UIImageView index:0"
    wait_touch "UIButtonLabel marked:'Leave'"
    puts "Left group"
    wait_touch "* marked:'Save'"
  end

  def enter_profile_page
    swipe :down, force: :strong
    wait_touch "UIImageView id:'gl-community-profile-empty'"
  end

end

