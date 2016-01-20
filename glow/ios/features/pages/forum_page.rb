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
    wait_touch "UITextFieldLabels index:0"
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
    title = args[:topic_title] || "Post " + Time.now.strftime("%m%d-%H:%M:%S")
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

  def create_photo_common
    wait_touch "label text:'Photo'"
    wait_for_none_animating
    wait_touch "PUAlbumListTableViewCell index:0"
    wait_for_none_animating
    wait_touch "PUPhotosGridCell index:1"
    wait_touch "label text:'Choose'"
    wait_for_none_animating
    wait_touch "label marked:'Write a caption...'"
    description = title = "Photo " + Time.now.strftime("%m%d-%H:%M:%S")
    keyboard_enter_text description
  end

  def create_photo
    create_photo_common
    wait_touch "* marked:'Next'"
    wait_touch "UITableViewCellContentView child label index:0"
    wait_touch "* marked:'Done!'"
    wait_for_none_animating
    wait_for_elements_exist "* marked:'Your topic is successfully posted!"
    sleep 1
  end

  def 
    create_photo_common
    wait_touch "* {text CONTAINS 'TMI'} sibling UISwitch"
    sleep 1
    wait_touch "* marked:'Next'"
    wait_touch "UITableViewCellContentView child label index:0"
    wait_touch "* marked:'Done!'"
    wait_for_none_animating
    wait_for_elements_exist "* marked:'Your topic is successfully posted!"
    sleep 1
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

  def select_target_group
    wait_touch "* marked:'#{TARGET_GROUP_NAME}'"
    wait_for_none_animating
  end
    
    
  def create_post_in_group(args={})
    wait_touch "label text:'Post'"
    wait_touch "UITextField"
    title = args[:topic_title] || "Post " + Time.now.strftime("%m%d-%H:%M:%S")
    keyboard_enter_text title
    wait_touch "* marked:'Write a description!'"
    keyboard_enter_text args[:text] ||"Test post topic"+Time.now.to_s
    if args[:anonymous] == 1
      puts "Anonymous Mode"
      wait_touch "* id:'gl-community-anonymous-uncheck.png'"
    end
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

  def click_back_button
    wait_touch "* marked:'Back'"
  end  

  def edit_topic_voted (args1)
    wait_touch "label {text CONTAINS '#{args1}'} index:0"
    wait_touch "* id:'community-dots'"
    wait_touch "UILabel marked:'Edit this post'"
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
    wait_touch "UIButtonLabel {text CONTAINS 'Topics/Comments'}"
  end

  def search_topics(args)
    wait_touch "UISegment marked:'Topics'"
    puts "Search for topic: #{args}"
    keyboard_enter_text args
    tap_keyboard_action_key
  end 

  def search_comments
    wait_touch "UISegment marked:'Comments'"
    $search_content  = "#{$random_prefix} comment"
    puts "Search for comment: #{$search_content}"
    keyboard_enter_text $search_content
    tap_keyboard_action_key
  end

  def search_deleted_comments(args)
    touch "UISegment marked:'Comments'"
    puts "Search for deleted comment: #{args}"
    keyboard_enter_text args
    tap_keyboard_action_key
  end

  def search_subreplies
    wait_touch "UISegment marked:'Comments'"
    $search_content  = "#{$random_prefix} sub-reply"
    puts "Search for subreply: #{$search_content}"
    keyboard_enter_text $search_content
    tap_keyboard_action_key
  end


  def scroll_down_to_see(args)
    puts "* marked:'#{args}'"
    until_element_exists("* marked:'#{args}'", :timeout => 10 , :action => lambda {swipe :up, :"swipe-delta" =>{:vertical => {:dx=> 0, :dy=> 200} }})
    swipe :up
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

  def check_search_result_comment
    random_number = Random.rand($comment_number.to_i).to_i+1
    search_result = $search_content+" "+random_number.to_s
    puts "Search for #{search_result}"
    forum_page.scroll_down_to_see search_result
    forum_page.touch_search_result search_result,0
    wait_for_elements_exist "* marked:'#{search_result}'"
    forum_page.show_entire_discussion
    puts "See element '#{search_result}'"
  end

  def check_search_result_subreply
    random_number = Random.rand($comment_number.to_i).to_i+1
    search_result = $search_content+" "+random_number.to_s
    puts "Search for #{search_result}"
    forum_page.scroll_down_to_see search_result
    forum_page.touch_search_result search_result,0
    forum_page.show_entire_discussion
    forum_page.view_all_replies
    puts "Finding element '#{search_result}'"
    forum_page.scroll_up_to_see search_result
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
    wait_touch "* marked:'#{args}' sibling * marked:'Join'"
    wait_for_none_animating
    sleep 2
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

  def edit_text_fields(args1,args2)
    wait_touch "UITextFieldLabel marked:'#{args1}'"
    keyboard_enter_text "#{args2}"
  end  

  def exit_edit_profile
    touch "* id:'gl-community-back.png'"
  end

  def exit_profile_page(button_index)
    wait_touch "UIButton index:#{button_index}"
  end

  def get_UIButton_number
    query("UIButton").size  
  end

  def check_groups
    wait_touch "UIButton index:0"
    check_element_exists  "* marked:'#{TARGET_GROUP_NAME }'"
    puts "I can see target group #{TARGET_GROUP_NAME }"
  end

  def check_followers
    wait_touch "UIButton index:1"
    check_element_exists "* marked:'#{$user2.first_name}'"
    check_element_exists "* marked:'Following'"
    puts "I can see follower #{$user2.first_name}"
  end

  def check_following
    wait_touch "UIButton index:2"
    check_element_exists "* marked:'#{$user2.first_name}'"
    check_element_exists "* marked:'Following'"
    puts "I can see I'm following #{$user2.first_name}"
  end

  def check_following_not_exist
    wait_touch "UIButton index:2"
    check_element_does_not_exist "* marked:'#{$user2.first_name}'"
    puts "I can NOT see I'm following #{$user2.first_name}"
  end

  def check_participated
    touch_HMScrollView_element 1
    sleep 1
    check_element_exists "* marked:'#{$user.topic_title}'"
    touch "* marked:'#{$user.topic_title}'"
    check_element_exists "* marked:'Show entire discussion'"
  end

  def check_created
    touch_HMScrollView_element 2
    sleep 2
    check_element_exists "* marked:'#{$user.topic_title}'"
    touch "* marked:'#{$user.topic_title}'"
    check_element_does_not_exist "* marked:'Show entire discussion'"
  end

  def check_bookmarked
    touch_HMScrollView_element 3
    sleep 2
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
    wait_touch "* marked: 'Back'"
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
    wait_touch "* marked:'#{$user2.first_name}' index:0"
  end

  def action_to_other_user(action)
    if element_exists "* marked:'Edit profile'"
      puts "The profile is yours"
    end
    puts "The action is #{action}"
    case action.downcase
    when "follow", "followed"
      check_element_exists "* marked:'Follow'"
      wait_touch "ForumFollowButton"
    when "unfollow", "unfollowed"
      check_element_exists "* marked:'Following'"
      wait_touch "* marked:'Following'"
      wait_touch "UILabel marked:'Unfollow'"
    when "block", "Blocked"
      wait_touch "* marked:'Follow' sibling UIButton"
      wait_touch "UILabel marked:'Block'"
      check_element_exists "* {text CONTAINS 'Block this user?'}"
      wait_touch "UILabel marked:'Block'"
    when "invite", "invited"
      wait_touch "* marked:'Follow' sibling UIButton"
      wait_touch "UILabel marked:'Invite to a group'"
    when "unblock","unblocked"
      check_element_exists "* marked:'Blocked'"
      touch "UIButton marked:'Blocked'"
      check_element_does_not_exist "* marked:'Blocked'"
    else
      puts "Action error"
    end
  end

  def click_filters_button
    wait_touch "UILabel marked:'Filters'"
  end

  def click_save_button
    wait_touch "UILabel marked:'Save'"
  end

  def go_to_community_settings
    swipe :down, force: :strong
    wait_touch "UIButton marked:'gl community filter'"
  end

  def click_blocked_users
    wait_touch "* {text CONTAINS 'user(s)'}"
  end

  def click_topnav_close
    wait_touch "* marked:'gl community topnav close' UINavigationButton"
  end

  def click_bookmark_icon
    wait_touch "* marked:'gl community topnav close' UINavigationButton sibling * index:2"
  end

  def click_hyperlink_comments
    wait_touch "* marked:'Posted by' sibling UILabel index:0"  
  end

  def hide_topic
    wait_for_elements_exist "* marked:'#{$user2.topic_title}'"
    puts "I can see topic #{$user2.topic_title}"
    wait_touch "* id:'community-dots' index:1"
    wait_touch "UILabel marked:'Hide this post'"
    wait_for(:timeout=>3){element_exists "label {text BEGINSWITH 'Would you like to hide this topic?'}"}
    wait_touch "UILabel marked:'Yes, hide it.'"  
  end

  def confirm_hide(args = 1)
    wait_for(:timeout=>3){element_exists "label {text CONTAINS 'to hide this'}"}
    if args ==1 
      wait_touch "UILabel marked:'Yes, hide it.'"
      puts "User hide it"
    else 
      wait_touch "UILabel marked:'No'"
      puts "User not hide it"
    end
  end


  def report_topic(args)
    sleep 1
    if element_does_not_exist "label {text CONTAINS 'Please select the reason why you are flagging this post.'}"
      enter_report_topic
    end
    wait_touch "UILabel marked:'#{args}'"  
  end

  def enter_report_topic
    wait_for_elements_exist "* marked:'#{$user2.topic_title}'"
    puts "I can see topic >>>#{$user2.topic_title}<<<"
    wait_touch "* id:'community-dots' index:1"
    wait_touch "UILabel marked:'Report this post'"
    wait_for(:timeout=>3){element_exists "label {text CONTAINS 'Please select the reason why you are flagging this post.'}"}
  end

  def report_comment(args)
    sleep 1
    if element_does_not_exist "label {text CONTAINS 'Please select the reason why you are flagging this post.'}"
      enter_report_comment
    end
    wait_touch "UILabel marked:'#{args}'"  
  end

  def enter_report_comment
    wait_for_elements_exist "* marked:'#{$hidereply_content}'"
    puts "I can see comment >>>#{$hidereply_content}<<<"
    wait_touch "* id:'community-dots' index:0"
    wait_touch "UILabel marked:'Report'"
    wait_for(:timeout=>3){element_exists "label {text CONTAINS 'Please select the reason why you are flagging this post.'}"}
  end

  def report_topic_check_reasons(table)
    enter_report_topic
    table.rows.each do |row|
      tmp = escape_quotes(row[0].to_s)
      check_element_exists "* marked:'#{tmp}'"
      puts "check >>'#{tmp}'<< pass"
    end
  end

  def report_comment_check_reasons(table)
    enter_report_comment
    table.rows.each do |row|
      tmp = escape_quotes(row[0].to_s)
      check_element_exists "* marked:'#{tmp}'"
      puts "check >>'#{tmp}'<< pass"
    end
  end

  def hide_comment
    wait_for_elements_exist "* marked:'#{$hidereply_content}'"
    puts "I can see comment #{$hidereply_content}"
    wait_touch "* id:'community-dots' index:0"
    wait_touch "UILabel marked:'Hide'"
    wait_for(:timeout=>3){element_exists "label {text BEGINSWITH 'Are you sure to hide this comment?'}"}
    wait_touch "UILabel marked:'Yes, hide it.'"  
  end

  def click_discover
    wait_touch "UILabel marked:'Discover'"
  end

  def click_explore
    wait_touch "UIButton marked:'Explore'"
  end

  def create_a_group
    wait_touch "* marked:'Group name'"
    keyboard_enter_text "MilesGroup"
    wait_touch "* marked:'Group description'"
    keyboard_enter_text "This is a test group."
    scroll_down_to_see "Tech Support"
    wait_touch "* marked:'Tech Support'"
    scroll_down_to_see "Add a group photo"
    touch "* marked:'Add a group photo'"
    wait_touch "* marked:'Choose from library'"
    sleep 0.5
    if element_exists "* marked:'OK'"
      touch "* marked:'OK'"
    end  
    wait_touch "PUAlbumListTableViewCell index:0"
    wait_for_none_animating
    wait_touch "PUPhotosGridCell index:1"
    wait_touch "UIButtonLabel text:'Create'"
  end
end













































