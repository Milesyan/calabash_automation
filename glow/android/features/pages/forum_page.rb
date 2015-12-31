require 'calabash-android/abase'

class ForumPage < Calabash::ABase
  def trait
    "*"
  end

  def create_poll
    touch "* id:'create_poll_btn'"
    title = "Poll " + random_str
    answer1 = random_str
    answer2 = random_str
    answer3 = random_str
    description = "poll #{Time.now.to_i}"
    enter_text "* id:'title_editor'", title
    enter_text "* id:'text' index:0", answer1
    enter_text "* id:'text' index:1", answer2
    enter_text "* id:'text' index:2", answer3
    enter_text "* id:'content_editor'", description
    touch "* id:'create_yes'"
    touch "* id:'text1'" # select a group
    sleep 2
  end

  def create_post
    touch "* id:'create_topic_btn'"
    title = "Test create topic UI " + Time.now.to_s
    description = "topic #{Time.now.to_i}"
    enter_text "* id:'title_editor'", title
    enter_text "* id:'content_editor'", description
    touch "* id:'create_yes'" # done button
    touch "* id:'text1'" # select a group
    sleep 2
  end

  def create_photo
    touch "* id:'create_photo_btn'"
    touch "* marked:'Take a photo'"
  end

  def create_link
    touch "* id:'create_url_btn'"
    title = "Test create topic UI " + random_str
    link = "www.baidu.com "
    enter_text "* id:'title_editor'", title
    enter_text "* id:'content_editor'", link
    sleep 1
    wait_for_elements_do_not_exist "* id:'progress_bar'"
    touch "* id:'create_yes'" # done button
    touch "* id:'text1'" # select a group
    sleep 2
  end

  def login
    onboard_page.tap_login
    login_page.login
  end

  def select_a_group
    sleep 1
    touch "* marked:'New' sibling * index:1"
  end
    
  def create_post_in_group(args={})
    touch "* text:'Post'"
    touch "*"
    title = args[:title] || "Post " + Time.now.strftime("%m%d-%H:%M:%S")
    keyboard_enter_text title
    touch "* marked:'Write a description!'"
    keyboard_enter_text args[:text] ||"Test post topic"+Time.now.to_s
    touch "* text:'Post'"
    sleep 1
    # select the first group
    # touch "UITableViewCellContentView child * index:0"
    # touch "* marked:'Done!'"
    sleep 1
    #check_element_exists "* marked:'#{title}'"
    $user.topic_title = title
    @topic_title = title
    puts $user.topic_title
  end

  def discard_topic
    touch "* text:'Close'"
    touch "UILabel marked:'Discard'"
  end  

  def click_back_button
    touch "* marked:'Back'"
  end  
  

  def edit_topic(args1)
    touch "* {text CONTAINS '#{args1}'} index:0"
    touch "* id:'community-dots'"
    touch "UILabel marked:'Edit this post'"
      sleep 1
    puts $user.topic_title
    
    touch "UIWebView"
    scroll "scrollView", :up
      touch "*Label"
    #keyboard_enter_text('Delete')
    keyboard_enter_text("Modified title")
    touch "UIWebView index:0"
    keyboard_enter_text("Modified content")
    touch "* text:'Update'"
  end

  def add_comment
    touch "* marked:'Add a comment'"
      comment = "comment " + Time.now.to_s
    keyboard_enter_text comment
    touch "* text:'Post'"
    sleep 2
    # wait_for(:timeout => 10, :retry_frequency => 1) do
    #   element_exists "* all marked:'#{comment}'"
    # end
  end

  def add_image_comment
    touch "* marked:'Add a comment'"
      comment = "Test image comment" 
    keyboard_enter_text comment
    touch "UIButton marked:'gl community share story cam'"
    touch "UILabel marked:'Choose from library'"
    touch "PUAlbumListTableViewCell index:0"
      touch "PUPhotosGridCell index:1"
      touch "* text:'Post'"
    sleep 2
    # wait_for(:timeout => 10, :retry_frequency => 1) do
    #   element_exists "* all marked:'#{comment}'"
    # end
  end

  def add_comments(n)
    n.times do
      touch "* marked:'Add a comment'"
          comment = "comment " + Time.now.to_s
      keyboard_enter_text comment
      touch "* text:'Post'"
      sleep 4
    end
  end

  def add_reply
    until_element_exists("* marked:'Reply'", :timeout => 3 , :action => lambda {swipe :up, :"swipe-delta" =>{:vertical => {:dx=> 0, :dy=> 200} }})
    touch "* marked:'Reply'"
      keyboard_enter_text Time.now.to_s
    touch "* marked:'Send'"
  end

  def upvote_topic
    upvote_button = query("ForumUpvoteButton").last
    touch upvote_button
  end

  def upvote_reply
    touch "ForumUpvoteButton"
  end

  def upvote_comment
    upvote_button = query("ForumUpvoteButton").first
    touch upvote_button
  end

  def downvote_topic
    
  end

  def downvote_comment
    
  end

  def downvote_reply
    
  end
 
  def delete_topic(args)
    touch "* id:'community-dots' index:#{args}"
    touch "UILabel marked:'Delete this post'"
    wait_for(:timeout=>3){element_exists "* {text BEGINSWITH 'Are you sure you want to delete this topic?'}"}
    touch "UILabel marked:'OK'"
  end

  def delete_comment(args)
    touch "* id:'community-dots' index:#{args}"
    touch "UILabel marked:'Delete'"
    wait_for(:timeout=>3){element_exists "* {text BEGINSWITH 'Are you sure you want to delete this post?'}"}
    touch "UILabel marked:'OK'"
  end


  def enter_topic(args1)
    touch "* {text CONTAINS '#{args1}'} index:0"
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
    touch "UIButton marked:'Topics/Comments'"
  end

  def search_topics(args)
    touch "UISegment marked:'Topics'"
    puts "Search for topic: #{args}"
    keyboard_enter_text args
    tap_keyboard_action_key
  end 

  def search_comments(args)
    touch "UISegment marked:'Comments'"
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
    touch "* marked:'Cancel'"
  end

  def show_entire_discussion
    touch "UIButtonLabel marked:'Show entire discussion'"
  end

  def view_all_replies
    touch "UILabel marked:'View all replies'"
  end

  def touch_search_result(args1, args2 = 1)
    touch "UILabel marked:'#{args1}' index:#{args2}"
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
    touch "UILabel marked:'#{string}' index:1"
    wait_for_elements_exist("* {text CONTAINS 'This post has been removed'}", :timeout => 3)
    touch "* marked:'OK'"
  end

  def long_press(args)
    x = query("* marked:'#{args}'")[0]["rect"]["x"]
    y = query("* marked:'#{args}'")[0]["rect"]["y"]
    puts "coordinate of item is x => #{x}, y => #{y}"
    send_uia_command({:command => %Q[target.tapWithOptions({x: #{x}, y: #{y}}, {tapCount: 1, touchCount: 1, duration: 2.0})]})
  end

  def join_group(args)
    touch "* marked:'Join' index:0"
      touch "* marked:'#{args}'"
  end  
  
  def leave_group
    touch "UIImageView index:0"
    touch "UIButtonLabel marked:'Leave'"
    puts "Left group"
    touch "* marked:'Save'"
  end

  def enter_profile_page
    swipe :down, force: :strong
    touch "UIImageView id:'gl-community-profile-empty'"
  end

  def edit_text_fields(args1,args2)
    touch "*Label marked:'#{args1}'"
    keyboard_enter_text "#{args2}"
  end  

  def exit_edit_profile
    touch "* id:'gl-community-back.png'"
  end

  def exit_profile_page(button_index)
    touch "UIButton index:#{button_index}"
  end

  def get_UIButton_number
    query("UIButton").size  
  end

  def check_groups
    touch "UIButton index:0"
    check_element_exists "* marked:'target group'"
    puts "I can see target group"
  end

  def check_followers
    touch "UIButton index:1"
    check_element_exists "* marked:'#{$user2.first_name}'"
    check_element_exists "* marked:'Following'"
    puts "I can see follower #{$user2.first_name}"
  end

  def check_following
    touch "UIButton index:2"
    check_element_exists "* marked:'#{$user2.first_name}'"
    check_element_exists "* marked:'Following'"
    puts "I can see I'm following #{$user2.first_name}"
  end

  def check_following_not_exist
    touch "UIButton index:2"
    check_element_does_not_exist "* marked:'#{$user2.first_name}'"
    puts "I can NOT see I'm following #{$user2.first_name}"
  end

  def check_participated
    touch_HMScrollView_element 1
    check_element_exists "* marked:'#{$user.topic_title}'"
    touch "* marked:'#{$user.topic_title}'"
    check_element_exists "* marked:'Show entire discussion'"
  end

  def check_created
    touch_HMScrollView_element 2
    check_element_exists "* marked:'#{$user.topic_title}'"
    touch "* marked:'#{$user.topic_title}'"
    check_element_does_not_exist "* marked:'Show entire discussion'"
  end

  def check_bookmarked
    touch_HMScrollView_element 3
    check_element_exists "* marked:'#{$user.topic_title}'"
    touch "* marked:'#{$user.topic_title}'"
    check_element_does_not_exist "* marked:'Show entire discussion'"
  end

  def check_profile_element(args)
    case args
    when "groups", "group"
      check_groups
    when "followers", "follower"
      check_followers
    when "following", "followings"
      check_following
    when "participated"
      check_participated
    when "created"
      check_created
    when "bookmarked"
      check_bookmarked
    else 
      puts "Input argument is wrong."
    end
    puts "#{args} is checked"
  end

  def back_to_profile_page
    touch "* marked: 'Back'"
  end

  def touch_HMScrollView_element(args)
    scroll_view_width = query("HMScrollView")[1]["rect"]["width"]
    case args
    when 1
      touch("HMScrollView", :offset => {:x => scroll_view_width/4, :y => 0})
    when 2
      touch("HMScrollView", :offset => {:x => scroll_view_width/2, :y => 0})
    when 3
      touch("HMScrollView", :offset => {:x => scroll_view_width/3*2, :y => 0})
    end
  end

  def touch_creator_name(args)
    check_element_exists "* {text CONTAINS '#{args}'}"
    touch "* marked:'#{$user2.first_name}' index:0"
  end

  def action_to_other_user(action)
    if element_exists "* marked:'Edit profile'"
      puts "The profile is yours"
    end
    puts "The action is #{action}"
    case action.downcase
    when "follow", "followed"
      check_element_exists "* marked:'Follow'"
      touch "ForumFollowButton"
    when "unfollow", "unfollowed"
      check_element_exists "* marked:'Following'"
      touch "* marked:'Following'"
      touch "UILabel marked:'Unfollow'"
    when "block", "Blocked"
      touch "* marked:'Follow' sibling UIButton"
      touch "UILabel marked:'Block'"
      check_element_exists "* {text CONTAINS 'Block this user?'}"
      touch "UILabel marked:'Block'"
    when "invite", "invited"
      touch "* marked:'Follow' sibling UIButton"
      touch "UILabel marked:'Invite to a group'"
    when "unblock","unblocked"
      check_element_exists "* marked:'Blocked'"
      touch "UIButton marked:'Blocked'"
      check_element_does_not_exist "* marked:'Blocked'"
    else
      puts "Action error"
    end
  end

  def click_filters_button
    touch "UILabel marked:'Filters'"
  end

  def click_save_button
    touch "UILabel marked:'Save'"
  end

  def go_to_community_settings
    swipe :down, force: :strong
    touch "UIButton marked:'gl community filter'"
  end

  def click_blocked_users
    touch "* {text CONTAINS 'user(s)'}"
  end

  def click_topnav_close
    touch "* marked:'gl community topnav close' UINavigationButton"
  end

  def click_bookmark_icon
    touch "* marked:'gl community topnav close' UINavigationButton sibling * index:2"
  end

  def click_hyperlink_comments
    touch "* marked:'Posted by' sibling UILabel index:0"  
  end

  def hide_topic
    wait_for_elements_exist "* marked:'#{$user2.topic_title}'"
    puts "I can see topic #{$user2.topic_title}"
    touch "* id:'community-dots' index:1"
    touch "UILabel marked:'Hide this post'"
    wait_for(:timeout=>3){element_exists "* {text BEGINSWITH 'Would you like to hide this topic?'}"}
    touch "UILabel marked:'Yes, hide it.'"  
  end

  def report_topic(args)
    wait_for_elements_exist "* marked:'#{$user2.topic_title}'"
    puts "I can see topic #{$user2.topic_title}"
    touch "* id:'community-dots' index:1"
    touch "UILabel marked:'Report this post'"
    wait_for(:timeout=>3){element_exists "* {text CONTAINS 'Please select the reason why you are flagging this post.'}"}
    touch "UILabel marked:'#{args}'"  
  end

  def hide_comment
    wait_for_elements_exist "* marked:'#{$hidereply_content}'"
    puts "I can see comment #{$hidereply_content}"
    touch "* id:'community-dots' index:0"
    touch "UILabel marked:'Hide'"
    wait_for(:timeout=>3){element_exists "* {text BEGINSWITH 'Are you sure to hide this comment?'}"}
    touch "UILabel marked:'Yes, hide it.'"  
  end

  def report_comment(args)
    wait_for_elements_exist "* marked:'#{$hidereply_content}'"
    puts "I can see comment #{$hidereply_content}"
    touch "* id:'community-dots' index:0"
    touch "UILabel marked:'Report'"
    wait_for(:timeout=>3){element_exists "* {text CONTAINS 'Please select the reason why you are flagging this post.'}"}
    touch "UILabel marked:'#{args}'"  
  end
end