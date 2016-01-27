require 'calabash-android/abase'

class ForumPage < Calabash::ABase
  def trait
    "*"
  end


#--------New create topic flow itmes----
  def touch_floating_menu
    wait_for_elements_exist "* id:'fab_expand_menu_button'"
    sleep 1
    touch "* id:'fab_expand_menu_button'"
    sleep 1
  end

  def touch_floating_poll
    touch "* id:'community_home_floating_actions_menu' child FloatingActionButton index:0"
    sleep 1
  end

  def touch_floating_photo
    touch "* id:'community_home_floating_actions_menu' child FloatingActionButton index:1"
    sleep 1
  end

  def touch_floating_text
    touch "* id:'community_home_floating_actions_menu' child FloatingActionButton index:2"
    sleep 1
  end

  def touch_floating_link
    touch "* id:'community_home_floating_actions_menu' child FloatingActionButton index:3"
    sleep 1
  end

  def touch_floating_create_group
    touch "* id:'community_home_floating_actions_menu' child FloatingActionButton index:0"
    sleep 1
  end

#------------create topics-----------------
  def create_poll(args={})
    if element_exists "* id:'community_home_floating_actions_menu'"
      touch_floating_menu
      touch_floating_poll
    else 
      sleep 0.5
      touch "* id:'create_poll_btn'"
    end
    create_poll_common args
  end

  def click_create_group
    if element_exists "* id:'community_home_floating_actions_menu'"
      touch_floating_menu
      touch_floating_create_group
    else 
      sleep 0.5
      touch "* marked:'Create a group'"
    end
  end 

  def create_a_group
    wait_for_element_exists "* id:'group_category'"
    wait_touch "* id:'create_cancel'"
    touch_floating_menu
  end

  def select_first_group
    sleep 0.5
    touch "* id:'text1' index:0" # select a group
  end

  def create_poll_in_group(args={})
    create_poll args
    $user.topic_title = @title
    puts $user.topic_title
  end

  def create_post_in_group(args={})
    create_post args
    puts "In group post title $user.topic_title"
  end


  def create_post(args={})
    if element_exists "* id:'community_home_floating_actions_menu'"
      touch_floating_menu
      sleep 1
      touch_floating_text
    else 
      sleep 0.5
      touch "* id:'create_topic_btn'"
    end
    create_post_common args
  end

  def create_photo(args={})
    if element_exists "* id:'community_home_floating_actions_menu'"
      touch_floating_menu
      touch_floating_photo
    else 
      touch "* id:'create_photo_btn'"
      touch "* marked:'Take a photo'"    
    end
    create_photo_common args
  end

  def create_link(args={})
    if element_exists "* id:'community_home_floating_actions_menu'"
      touch_floating_menu
      touch_floating_link
    else 
      touch "* id:'create_url_btn'"
    end
    create_link_common
  end

  def create_link_common
    @title = "Test create topic UI " + random_str
    link = "www.baidu.com "
    enter_text "* id:'title_editor'", @title
    enter_text "* id:'content_editor'", link
    sleep 1
    wait_for_elements_do_not_exist "* id:'progress_bar'"
    sleep 2
    touch "* id:'create_yes'" # done button
    sleep 0.5
  end

  def create_poll_common(args={}) 
    @title = args[:topic_title] || "Post Poll " + Time.now.strftime("%m%d-%H:%M:%S")
    content = args[:text] ||"Test post topic"+Time.now.to_s
    answer1 = random_str
    answer2 = random_str
    answer3 = random_str
    enter_text "* id:'title_editor'", @title
    enter_text "* id:'text' index:0", answer1
    enter_text "* id:'text' index:1", answer2
    enter_text "* id:'text' index:2", answer3
    enter_text "* id:'content_editor'", content
    sleep 0.5
    touch "* id:'create_yes'"
    sleep 1
  end

  def create_post_common(args={})
    @title = args[:topic_title] || "Post Text " + Time.now.strftime("%m%d-%H:%M:%S")
    description = "topic #{Time.now.to_i}"
    enter_text "* id:'title_editor'", @title
    enter_text "* id:'content_editor'", description
    sleep 0.5
    touch "* id:'create_yes'" # done button
    sleep 2
  end
#-----------------
  def login
    login_page.tap_login
    login_page.login
  end

  def select_target_group
    sleep 1
    touch "* marked:'#{TARGET_GROUP_NAME}'"
  end
    
  def discard_topic
    wait_touch "* id:'create_cancel'"
    sleep 1
  end  

  def click_back_button
    sleep 0.5
    touch "* contentDescription:'Navigate up'"
  end  
  
  def edit_topic_voted (args1)
    sleep 2
    wait_touch "* {text CONTAINS '#{args1}'} index:0"
    wait_for_elements_exist "* {text CONTAINS 'Posted by'}"
    sleep 1
    wait_touch "* id:'topic_menu'"
    wait_touch "* marked:'Edit this post'"
  end

  def edit_topic(args1)
    sleep 0.5
    touch "* {text CONTAINS '#{args1}'} index:0"
    sleep 1
    wait_for_elements_exist "* {text CONTAINS 'Posted by'}"
    sleep 1
    wait_touch "* id:'topic_menu'"
    sleep 1
    touch "* marked:'Edit this post'"
    sleep 1
    puts $user.topic_title
    scroll_down
    enter_text "* id:'title_editor'", "Modified title"
    enter_text "* id:'content_editor'", "Modified content"
    sleep 0.5
    touch "* id:'create_yes'"
  end

  def add_comment
    wait_touch "* marked:'Add a comment'"
    sleep 1
    wait_touch "* id:'reply_text'"
    comment = "comment " + Time.now.to_s
    keyboard_enter_text comment
    touch "* id:'add_reply_yes'"
    sleep 1
  end

  def add_image_comment
    wait_touch "* marked:'Add a comment'"
    wait_touch "* id:'reply_text'"
    comment = "Test image comment" 
    keyboard_enter_text comment
    wait_touch "* id:'insert_image_button'"
    sleep 0.5
    touch "* marked:'Gallery'"
    puts "Cannot add image in android\n"
    sleep 3
    touch "* id:'add_reply_yes'"
    sleep 2
  end

  def add_comments(n)
    n.times do
      wait_touch "* marked:'Add a comment'"
      comment = "comment " + Time.now.to_s
      keyboard_enter_text comment
      sleep 0.5
      touch "* id:'add_reply_yes'"
      sleep 4
    end
  end

  def add_reply
    scroll_down
    wait_touch "* marked:'Reply'"
    enter_text "* id:'new_reply_text'", "Test Reply" + Time.now.to_s
    sleep 0.5
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
    wait_for_elements_exist "* {text CONTAINS 'Posted by'}"
    wait_touch "* id:'topic_menu'"
    wait_touch "* marked:'Delete this post'"
    wait_for(:timeout=>3){element_exists "* {text CONTAINS 'delete this'}"}
    sleep 0.5
    touch "* marked:'OK'"
  end

  def delete_comment(args)
    sleep 2
    scroll_down
    wait_touch "* id:'reply_menu' index:#{args}"
    wait_touch "* marked:'Delete this reply'"
    wait_for(:timeout=>3){element_exists "* {text BEGINSWITH 'Are you sure you want to delete this comment?'}"}
    wait_touch "* marked:'OK'"
  end


  def enter_topic(args1)
    sleep 2
    wait_for_elements_exist "* {text CONTAINS '#{args1}'} index:0"
    sleep 0.5
    touch "* {text CONTAINS '#{args1}'} index:0"
    sleep 1
  end

  def scroll_to_see(gesture,content)
    if gesture == "up"
      until_element_exists("* marked:'#{content}'", :action => lambda{ scroll_up },:time_out => 20)
    elsif  gesture == "down"
      until_element_exists("* marked:'#{content}'", :action => lambda{ scroll_down },:time_out => 30)  
    else 
      puts "Gesture  Error"
    end
  end 

  def evoke_search_bar
    sleep 1
    wait_touch "* id:'menu_community_search'"
    sleep 1
    wait_touch "* id:'menu_search'"
  end

  def tap_keyboard_search
    press_user_action_button('search')
  end

  def search_topics(args)
    wait_touch "* id:'tab_title' marked:'TOPICS'"
    puts "Search for topic: #{args}"
    enter_text "* id:'menu_search'", args
    tap_keyboard_search
  end 

  def search_comments
    wait_touch "* id:'tab_title' marked:'COMMENTS'"
    $search_content  = "#{$random_prefix} comment"
    puts "Search for comment: >>>>#{$search_content}<<<<"
    enter_text "* id:'menu_search'", $search_content
    tap_keyboard_search
  end

  def search_deleted_comments(args)
    wait_touch "* id:'tab_title' marked:'COMMENTS'"
    puts "Search for deleted comment: #{args}"
    enter_text "* id:'menu_search'", args
    tap_keyboard_search
  end

  def search_subreplies
    wait_touch "* id:'tab_title' marked:'COMMENTS'"
    $search_content  = "#{$random_prefix} sub-reply"
    puts "Search for subreply: >>>>#{$search_content}<<<<"
    enter_text "* id:'menu_search'", $search_content
    tap_keyboard_search
  end

  def search_groups(args)
    wait_touch "* id:'tab_title' marked:'GROUPS'"
    puts "Search for group : #{args}"
    enter_text "* id:'menu_search'", args
    tap_keyboard_search
  end

  def scroll_down_to_see(args)
    puts "Scroll down to see >>>* marked:'#{args}'<<<<"
    sleep 1
    until_element_exists("* marked:'#{args}'", :action => lambda{ scroll_down },:time_out => 10,:interval => 1.5)
    sleep 1
  end

  def scroll_up_to_see(args)
    until_element_exists("* marked:'#{args}'", :action => lambda{ scroll_up },:time_out => 10,:interval => 1.5)    
  end

  def click_cancel
    sleep 0.5
    touch "* marked:'Cancel'"
  end

  def show_entire_discussion
    sleep 1
    wait_touch "* marked:'Show entire discussion'"
    sleep 1
  end

  def view_all_replies
    sleep 1
    wait_touch "* id:'view_sub_replies'"
    sleep 1.5
  end

  def touch_search_result(args1, args2 = 1)
    sleep 2
    touch "* marked:'#{args1}' index:#{args2}"
    sleep 2
  end 

  def check_search_result_comment
    random_number = Random.rand($comment_number.to_i).to_i+1
    search_result = $search_content+" "+random_number.to_s
    puts "Search for #{search_result}"
    scroll_down_to_see search_result
    touch_search_result search_result,0
    wait_for_elements_exist "* marked:'#{search_result}'"
    forum_page.show_entire_discussion
    puts "See element '#{search_result}'"
  end

  def check_search_result_subreply
    random_number = Random.rand($subreply_number.to_i).to_i+1
    search_result = $search_content+" "+random_number.to_s
    puts "Search for #{search_result}"
    forum_page.scroll_down_to_see search_result
    forum_page.touch_search_result search_result,0
    forum_page.show_entire_discussion
    forum_page.view_all_replies
    puts "Finding element '#{search_result}'"
    forum_page.scroll_down_to_see search_result
  end

  def check_search_result_deleted(string)
    sleep 0.5
    touch "* marked:'#{string}' index:1"
    wait_for_elements_exist("* {text CONTAINS 'Topic does not exist!'}", :timeout => 3)
    sleep 1
  end

  def long_press(args)
    puts "NO long press in android"
  end

  def join_group(args)
    wait_touch "* marked:'#{args}' parent * index:2 child * id:'community_recommended_group_action'"
    wait_touch "* marked:'#{args}' parent * index:2 child * index:1 child * marked:'Joined'"
  end  
  
  def leave_group
    pan("* id:'title' index:0", :right)
    $group_name = query("* id:'title' index:0")[0]["text"]
    puts $group_name.to_s + "<<<<<<Group name lefted."
    wait_touch "* marked:'Leave'"
    puts "Left group"
  end

  def enter_community_settings
    wait_touch "* contentDescription:'More options'"
    wait_touch "* id:'title' marked:'Community Settings'"
  end

  def enter_profile_page
    wait_for_elements_exist "* contentDescription:'More options'"  
    sleep 1.5
    touch "* contentDescription:'More options'"    
    wait_touch "* id:'title' marked:'Profile'"
    wait_for_elements_do_not_exist "* id:'title' marked:'Profile'"
  end

  def get_element_x_y(args)
    wait_for_elements_exist "* id:'#{args}'"
    x = query("* id:'#{args}'")[0]["rect"]["x"]
    y = query("* id:'#{args}'")[0]["rect"]["center_y"]
    width = query("* id:'#{args}'")[0]["rect"]["width"]
    return x,y,width
  end

  def go_to_group_page_under_profile
    x,y,width = get_element_x_y "user_social_stats"
    if element_exists "* {text CONTAINS 'group'}"
      perform_action('touch_coordinate',(x+width*0.1), y)
      sleep 1
      puts "Group #{(x+width/6)} , #{y}"
    elsif element_exists "* {text CONTAINS 'groups'}"
      perform_action('touch_coordinate',(x+width*0.1), y)
      sleep 1
      puts "Groups #{(x+width/6)} , #{y}"
    else
      puts "Group text does not exist on screen."
    end
  end

  def go_to_group_page_under_settings
    enter_community_settings
    if element_exists "* marked:'Subscribed Groups'"
      touch "* marked:'Subscribed Groups'"
    else 
      touch "* marked:'My Groups'"
    end
  end

  def check_groups
    go_to_group_page_under_profile
    wait_for_elements_exist "* marked:'#{ TARGET_GROUP_NAME }'"
    puts "I can see target group"
  end


  def check_followers
    x,y,width = get_element_x_y "user_social_stats"
    if element_exists "* {text CONTAINS 'follower'}"
      perform_action('touch_coordinate',(x+width*0.5), y)
      sleep 1
    elsif element_exists "* {text CONTAINS 'followers'}"
      perform_action('touch_coordinate',(x+width*0.5), y)
      sleep 1
    else
      puts "Follower text does not exist on screen."
    end
    wait_for_elements_exist "* marked:'#{$user2.first_name}'"
    puts "I can see follower #{$user2.first_name}"
  end

  def check_following
    x,y,width = get_element_x_y "user_social_stats"
    if element_exists "* {text CONTAINS 'following'}"
      perform_action('touch_coordinate',(x+width*0.2), y)
      sleep 1
    else
      puts "Following text does not exist on screen."
    end
    wait_for_elements_exist "* marked:'#{$user2.first_name}'"
    wait_for_elements_exist "* marked:'Following'"
    puts "I can see I'm following #{$user2.first_name}"
  end

  def check_following_not_exist
    x,y,width = get_element_x_y "user_social_stats"
    if element_exists "* {text CONTAINS 'following'}"
      perform_action('touch_coordinate',(x+width*0.2), y)
      sleep 1
    else
      puts "Following text does not exist on screen."
    end
    sleep 0.5
    wait_for_elements_do_not_exist "* marked:'#{$user2.first_name}'"
    puts "I can NOT see I'm following #{$user2.first_name}"
  end

  def check_participated
    wait_touch "* marked:'Participated'"
    wait_for_elements_exist "* marked:'#{$user.topic_title}'"
    sleep 1
    touch "* marked:'#{$user.topic_title}'"
    wait_for_element_exists "* id:'topic_menu'"
    sleep 1
    wait_for_element_exists "* marked:'Show entire discussion'"
  end

  def check_created
    wait_touch "* marked:'Created'"
    sleep 1
    wait_for_elements_exist "* marked:'#{$user.topic_title}'"
    sleep 1
    touch "* marked:'#{$user.topic_title}'"
    wait_for_element_exists "* id:'topic_menu'"
    sleep 1
    check_element_does_not_exist "* marked:'Show entire discussion'"
  end

  def check_bookmarked
    wait_touch "* marked:'Bookmarked'"
    sleep 1
    wait_for_elements_exist "* marked:'#{$user.topic_title}'"
    sleep 1
    touch "* marked:'#{$user.topic_title}'"
    wait_for_element_exists "* id:'topic_menu'"
    sleep 1
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

  def touch_creator_name(args)
    sleep 1
    x,y,width = get_element_x_y "topic_author_date"
    if element_exists "* {text CONTAINS 'Posted by'}"
      perform_action('touch_coordinate',(x+width*0.5), y)
      sleep 1
      if element_exists "* {text CONTAINS 'Posted by'}"
        perform_action('touch_coordinate',(x+width*0.3), y)
        sleep 1
      end
    else
      puts "Posted by text does not exist on screen."
    end
  end

  def action_to_other_user(action)
    if element_exists "* marked:'Edit profile'"
      puts "The profile is yours"
    else
      sleep 0.5
      puts "The action is #{action}"
      case action.downcase
      when "follow", "followed"
        wait_for_element_exists "* marked:'Follow'"
        sleep 0.5
        touch "* id:'follow_button'"
      when "unfollow", "unfollowed"
        wait_for_element_exists "* marked:'Following'"
        sleep 0.5
        touch "* marked:'Following'"
        wait_for_element_exists "* {text BEGINSWITH 'Stop following'}"
        sleep 0.5
        touch "* marked:'OK'"
        sleep 1
        wait_for_element_exists "* marked:'Follow'"
      when "block", "Blocked"
        wait_touch "* id:'other_action_menu'"
        wait_touch "* marked:'Block user'"
        sleep 1
        wait_for_element_exists "* {text CONTAINS 'will make all posts by this user invisible'}"
        sleep 0.5
        touch "* marked:'OK'"
      when "invite", "invited"
        "Invite user feature is not included in Android"
      when "unblock","unblocked"
        sleep 0.5
        wait_for_element_exists "* marked:'Blocked'"
        if element_exists "* id:'other_action_menu'"
          wait_touch "* id:'other_action_menu'"
          wait_touch "* marked:'Unblock user'"
        else 
          wait_touch "* marked:'Blocked'"
          wait_touch "* marked:'OK'"
        end
        sleep 0.5
        wait_for_element_does_not_exist "* marked:'Blocked'"
      else
        puts "Action error"
      end
    end
  end

  def click_filters_button
    wait_touch "* marked:'Age Filter'"
  end

  def go_to_community_settings
    wait_touch "* contentDescription:'More options'"
    wait_touch "* marked:'Community Settings'"
  end

  def click_blocked_users
    wait_touch "* marked:'Blocking'"
  end

  def click_bookmark_icon
    wait_touch "* id:'menu_item_add_bookmark'"
  end

  def click_hyperlink_comments
    wait_touch "* id:'topic_statistics'"  
  end

  def hide_topic
    wait_for_elements_exist "* {text CONTAINS 'Posted by'}"
    wait_for_elements_exist "* marked:'#{$user2.topic_title}'"
    puts "I can see topic #{$user2.topic_title}"
    until_element_exists("* id:'topic_menu'", :action => lambda{ scroll_down },:time_out => 10,:interval => 1.5)
    sleep 0.5
    touch "* id:'topic_menu'"
    wait_touch "* marked:'Hide this post'"
    wait_for(:timeout=>3){element_exists "* {text CONTAINS 'hide this'}"}
    sleep 0.5
    touch "* marked:'OK'"  
  end

  def confirm_hide(args = 1)
    wait_for(:timeout=>3){element_exists "* {text CONTAINS 'hide this'}"}
    if args ==1 
      wait_touch "* marked:'OK'"
      puts "User hide it"
    else 
      wait_touch "* marked:'Cancel'"
      puts "User not hide it"
    end
    wait_for_elements_do_not_exist "* {text CONTAINS 'hide this'}"
  end


  def report_topic(args)
    sleep 1
    if element_does_not_exist "* {text CONTAINS 'why you are flagging this topic'}"
      enter_report_topic
    end
    sleep 1
    touch "* marked:'#{args}'"  
  end


  def enter_report_topic
    wait_for_elements_exist "* {text CONTAINS 'Posted by'}"
    wait_for_elements_exist "* marked:'#{$user2.topic_title}'"
    puts "I can see topic >>>#{$user2.topic_title}<<<"
    until_element_exists("* id:'topic_menu'", :action => lambda{ scroll_down },:time_out => 10,:interval => 1.5)
    sleep 1.5
    touch "* id:'topic_menu'"
    wait_touch "* marked:'Report this post'"
    wait_for(:timeout=>3){element_exists "* {text CONTAINS 'why you are flagging this topic'}"}
  end


  def hide_comment
    wait_for_elements_exist "* marked:'#{$hidereply_content}'"
    puts "I can see comment #{$hidereply_content}"
    until_element_exists("* id:'reply_menu'", :action => lambda{ scroll_down },:time_out => 10,:interval => 1.5)
    sleep 0.5
    touch "* id:'reply_menu'"
    wait_touch "* marked:'Hide this reply'"
    wait_for(:timeout=>3){element_exists "* {text CONTAINS 'hide this'}"}
    sleep 0.5
    touch "* marked:'OK'"  
  end

  def report_comment(args)
    sleep 1
    if element_does_not_exist "* {text CONTAINS 'why you are flagging this reply'}"
      enter_report_comment
    end
    touch "* marked:'#{args}'"  
  end

  def enter_report_comment
    wait_for_elements_exist "* marked:'#{$hidereply_content}'"
    puts "I can see comment #{$hidereply_content}"
    until_element_exists("* id:'reply_menu'", :action => lambda{ scroll_down },:time_out => 10,:interval => 1.5)
    sleep 0.5
    touch "* id:'reply_menu'"
    wait_touch "* marked:'Report this reply'"
    wait_for(:timeout=>3){element_exists "* {text CONTAINS 'why you are flagging this reply'}"}
  end

  def report_topic_check_reasons(table)
    enter_report_topic
    table.rows.each do |row|
      tmp = escape_quotes(row[0].to_s)
      wait_for_element_exists "* marked:'#{tmp}'"
      puts "check >>'#{tmp}'<< pass"
    end
  end

  def report_comment_check_reasons(table)
    enter_report_comment
    table.rows.each do |row|
      tmp = escape_quotes(row[0].to_s)
      wait_for_element_exists "* marked:'#{tmp}'"
      puts "check >>'#{tmp}'<< pass"
    end
  end

  def touch_hidden_topic_element(args)
    sleep 1
    x,y,width = get_element_x_y "low_ratting_mask_content"
    case args.downcase
    when "view rules"
      perform_action('touch_coordinate',(x+width*0.4), y)
    when "show content"
      perform_action('touch_coordinate',(x+width*0.1), y)
    else 
      puts "Only 'view rules' and 'show content' is accepted"
    end
    sleep 1
  end

  def click_explore
    wait_touch "* marked:'Explore'"
    sleep 1
  end

  def click_discover
    sleep 1
    wait_touch "* marked:'Discover'"
    sleep 0.2
  end

    #community v1.1 logging
  def click_search_under_explore
    wait_touch "* marked:'Search'"
  end

  def search_groups(args)
    wait_touch "* id:'tab_title' marked:'GROUPS'"
    puts "Search for group: #{args}"
    enter_text "* id:'menu_search'", args
    tap_keyboard_search
  end 

  def touch_new_tab
    wait_touch "* marked:'New' index:0"
  end
end