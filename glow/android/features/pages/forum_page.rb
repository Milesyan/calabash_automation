require 'calabash-android/abase'

class ForumPage < Calabash::ABase
  def trait
    "*"
  end

  def wait_touch(query_str)
    sleep 1
    wait_for_elements_exist([query_str])
    touch(query_str)
  end

#--------New create topic flow itmes----
  def touch_floating_menu
    wait_for_elements_exist "* id:'fab_expand_menu_button'"
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

#------------create topics-----------------
  def create_poll(args={})
    if element_exists "* id:'community_home_floating_actions_menu'"
      touch_floating_menu
      touch_floating_poll
    else 
      touch "* id:'create_poll_btn'"
    end
    create_poll_common args
  end

  def select_first_group
    touch "* id:'text1' index:0" # select a group
  end

  def create_poll_in_group(args={})
    create_poll args
    $user.topic_title = @title
    puts $user.topic_title
  end

  def create_post_in_group(args={})
    create_post args
    $user.topic_title = @title
    puts $user.topic_title
  end


  def create_post(args={})
    if element_exists "* id:'community_home_floating_actions_menu'"
      touch_floating_menu
      sleep 1
      touch_floating_text
    else 
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
    touch "* id:'create_yes'" # done button
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
    touch "* id:'create_yes'"
    sleep 1
  end

  def create_post_common(args={})
    @title = args[:topic_title] || "Post Text " + Time.now.strftime("%m%d-%H:%M:%S")
    description = "topic #{Time.now.to_i}"
    enter_text "* id:'title_editor'", @title
    enter_text "* id:'content_editor'", description
    touch "* id:'create_yes'" # done button
    sleep 2
  end
#-----------------
  def login
    onboard_page.tap_login
    login_page.login
  end

  def select_target_group
    sleep 1
    touch "* marked:'#{TARGET_GROUP_NAME}'"
  end
    
  def discard_topic
    touch "* id:'create_cancel'"
    sleep 1
    # touch "UILabel marked:'Discard'"
    if element_exists "* id:'fab_expand_menu_button'"
      touch_floating_menu 
      sleep 1
    end
  end  

  def click_back_button
    touch "* contentDescription:'Navigate up'"
  end  
  

  def edit_topic(args1)
    touch "* {text CONTAINS '#{args1}'} index:0"
    wait_touch "* id:'topic_menu'"
    touch "* marked:'Edit this post'"
    sleep 1
    puts $user.topic_title
    scroll "scrollView", :up
    enter_text "* id:'title_editor'", "Modified title"
    enter_text "* id:'content_editor'", "Modified content"
    touch "* id:'create_yes'"
  end

  def add_comment
    wait_touch "* marked:'Add a comment'"
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
    touch "* marked:'Gallery'"
    puts "Cannot add image in android\n"
    sleep 3
    touch "* id:'add_reply_yes'"
    sleep 2

  end

  def add_comments(n)
    n.times do
      touch "* marked:'Add a comment'"
      comment = "comment " + Time.now.to_s
      keyboard_enter_text comment
      touch "* id:'add_reply_yes'"
      sleep 4
    end
  end

  def add_reply
    scroll_down
    wait_touch "* marked:'Reply'"
    enter_text "* id:'new_reply_text'", "Test Reply" + Time.now.to_s
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
    wait_touch "* id:'topic_menu'"
    wait_touch "* marked:'Delete this post'"
    wait_for(:timeout=>3){element_exists "* {text BEGINSWITH 'Are you sure you want to delete this post?'}"}
    touch "* marked:'OK'"
  end

  def delete_comment(args)
    touch "* id:'reply_menu' index:#{args}"
    touch "* marked:'Delete this reply'"
    wait_for(:timeout=>3){element_exists "* {text BEGINSWITH 'Are you sure you want to delete this comment?'}"}
    touch "* marked:'OK'"
  end


  def enter_topic(args1)
    touch "* {text CONTAINS '#{args1}'} index:0"
  end

  def scroll_to_see(gesture,content)
    if gesture == "up"
      if element_does_not_exist "* marked:'#{content}'"
        scroll_up
      end
    elsif  gesture == "down"
      if element_does_not_exist "* marked:'#{content}'"
        scroll_down
      end    
    else 
      puts "Gesture  Error"
    end
  end 

  def evoke_search_bar
    swipe_down
    wait_touch "* id:'menu_community_search'"
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

  def search_comments(args)
    touch "UISegment marked:'Comments'"
    puts "Search for comment: #{args}"
    enter_text "* id:'menu_search'", args
    tap_keyboard_search
  end

  def scroll_down_to_see(args)
    puts "* marked:'#{args}'"
    if element_does_not_exist "* marked:'#{args}'"
      scroll_down
    end  
  end

  def scroll_up_to_see(args)
    if element_does_not_exist "* marked:'#{args}'"
      scroll_up
    end   
  end

  def click_cancel
    touch "* marked:'Cancel'"
  end

  def show_entire_discussion
    forum_page.show_entire_discussion
  end

  def view_all_replies
    forum_page.view_all_replies
  end

  def touch_search_result(args1, args2 = 1)
    touch "* marked:'#{args1}' index:#{args2}"
  end 

  def check_search_result_comment(search_result)
    random_number = Random.rand($comment_number.to_i).to_i+1
    search_content  = "#{search_result}#{random_number}"
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
    touch "* marked:'#{string}' index:1"
    wait_for_elements_exist("* {text CONTAINS 'Topic does not exist!'}", :timeout => 3)
  end

  def long_press(args)
    puts "NO long press in android"
  end

  def join_group(args)
    touch "* marked:'Join' index:0"
    touch "* marked:'#{args}'"
  end  
  
  def leave_group
    pan("* id:'title' index:0", :right)
    wait_touch "* marked:'Leave'"
    puts "Left group"
  end

  def enter_group_page
    wait_touch "* contentDescription:'More options'"
    wait_touch "* id:'title' marked:'Groups'"
  end

  def enter_profile_page
    wait_touch "* contentDescription:'More options'"    
    wait_touch "* id:'title' marked:'Profile'"
  end

  def edit_text_fields(args1,args2)
    enter "* marked:'#{args1}'", "#{args2}"
  end  

  def exit_edit_profile
    touch "* contentDescription:'Navigate up'"
  end

  def exit_profile_page(button_index)
    touch "* contentDescription:'Navigate up'"
  end

  def get_UIButton_number
    puts "NOt useful in android"
  end


#---to be done---
  def get_element_x_y(args)
    x = query("* id:'#{args}'")[0]["rect"]["x"]
    y = query("* id:'#{args}'")[0]["rect"]["center_y"]
    width = query("* id:'#{args}'")[0]["rect"]["width"]
    x,y,width
  end
  def check_groups
    x,y,width = get_element_x_y user_social_stats
    if element_exists "* {text CONTAINS 'groups'}" || element_exists "* {text CONTAINS 'group'}"
      performAction('touch_coordinate',(x+width/6, y)
      sleep 1
    else
      puts "Group text does not exist on screen."
    end
    check_element_exists "* marked:'#{ TARGET_GROUP_NAME }'"
    puts "I can see target group"
  end

  def check_followers
    x,y,width = get_element_x_y user_social_stats
    if element_exists "* {text CONTAINS 'follower'}" || element_exists "* {text CONTAINS 'followers'}"
      performAction('touch_coordinate',(x+width*5/6, y)
      sleep 1
    else
      puts "Follower text does not exist on screen."
    end
    check_element_exists "* marked:'#{$user2.first_name}'"
    puts "I can see follower #{$user2.first_name}"
  end

  def check_following
    x,y,width = get_element_x_y user_social_stats
    if element_exists "* {text CONTAINS 'following'}"
      performAction('touch_coordinate',(x+width/2, y)
      sleep 1
    else
      puts "Following text does not exist on screen."
    end
    check_element_exists "* marked:'#{$user2.first_name}'"
    check_element_exists "* marked:'Following'"
    puts "I can see I'm following #{$user2.first_name}"
  end

  def check_following_not_exist
    x,y,width = get_element_x_y user_social_stats
    if element_exists "* {text CONTAINS 'following'}"
      performAction('touch_coordinate',(x+width/2, y)
      sleep 1
    else
      puts "Following text does not exist on screen."
    end
    check_element_does_not_exist "* marked:'#{$user2.first_name}'"
    puts "I can NOT see I'm following #{$user2.first_name}"
  end

  def check_participated
    wait_touch "* marked:'Participated'"
    sleep 0.5
    check_element_exists "* marked:'#{$user.topic_title}'"
    touch "* marked:'#{$user.topic_title}'"
    wait_for_element_exists "* id:'topic_menu'"
    check_element_exists "* marked:'Show entire discussion'"
  end

  def check_created
    wait_touch "* marked:'Created'"
    sleep 0.5
    check_element_exists "* marked:'#{$user.topic_title}'"
    touch "* marked:'#{$user.topic_title}'"
    wait_for_element_exists "* id:'topic_menu'"
    check_element_does_not_exist "* marked:'Show entire discussion'"
  end

  def check_bookmarked
    wait_touch "* marked:'bookmarked'"
    sleep 0.5
    check_element_exists "* marked:'#{$user.topic_title}'"
    touch "* marked:'#{$user.topic_title}'"
    wait_for_element_exists "* id:'topic_menu'"
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
    x,y,width = get_element_x_y topic_author_date
    if element_exists "* {text CONTAINS 'Posted by'}"
      performAction('touch_coordinate',(x+width*0.5, y)
      sleep 1
      if element_exists "* {text CONTAINS 'Posted by'}"
        performAction('touch_coordinate',(x+width*0.3, y)
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
      puts "The action is #{action}"
      case action.downcase
      when "follow", "followed"
        check_element_exists "* marked:'Follow'"
        touch "* id:'follow_button'"
      when "unfollow", "unfollowed"
        check_element_exists "* marked:'Following'"
        touch "* marked:'Following'"
        wait_for_element_exists "* {text BEGINSWITH 'Stop following'}"
        touch "* marked:'OK'"
        sleep 1
        wait_for_element_exists "* marked:'Follow'"
      when "block", "Blocked"
        wait_touch "* id:'other_action_menu'"
        wait_touch "* marked:'Block user'"
        check_element_exists "* {text CONTAINS 'will make all posts by this user invisible'}"
        touch "* marked:'OK'"
      when "invite", "invited"
        "Invite user feature is not included in Android"
      when "unblock","unblocked"
        check_element_exists "* marked:'Blocked'"
        wait_touch "* id:'other_action_menu'"
        wait_touch "* marked:'Unblock user'"
        sleep 0.5
        check_element_does_not_exist "* marked:'Blocked'"
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
    wait_touch "* marked:'Groups'"
  end

  def click_blocked_users
    wait_touch "* {text CONTAINS 'Users'}"
  end

  def click_bookmark_icon
    wait_touch "* id:'menu_item_add_bookmark'"
  end

  def click_hyperlink_comments
    wait_touch "* id:'topic_statistics'"  
  end

  def hide_topic
    wait_for_elements_exist "* marked:'#{$user2.topic_title}'"
    puts "I can see topic #{$user2.topic_title}"
    touch "* id:'topic_menu'"
    wait_touch "* marked:'Hide this post'"
    wait_for(:timeout=>3){element_exists "* {text BEGINSWITH 'Are you sure you want to hide this post?'}"}
    touch "* marked:'OK'"  
  end

  def report_topic(args)
    wait_for_elements_exist "* marked:'#{$user2.topic_title}'"
    puts "I can see topic #{$user2.topic_title}"
    touch "* id:'topic_menu'"
    touch "* marked:'Report this post'"
    wait_for(:timeout=>3){element_exists "* {text CONTAINS 'Please select the reason why you are flagging this post.'}"}
    touch "* marked:'#{args}'"  
  end

  def hide_comment
    wait_for_elements_exist "* marked:'#{$hidereply_content}'"
    puts "I can see comment #{$hidereply_content}"
    touch "* id:'reply_menu'"
    wait_touch "* marked:'Hide this reply'"
    wait_for(:timeout=>3){element_exists "* {text BEGINSWITH 'Are you sure you want to hide this reply?'}"}
    touch "* marked:'OK'"  
  end

  def report_comment(args)
    wait_for_elements_exist "* marked:'#{$hidereply_content}'"
    puts "I can see comment #{$hidereply_content}"
    touch "* id:'reply_menu'"
    wait_touch "* marked:'Report this reply'"
    wait_for(:timeout=>3){element_exists "* {text CONTAINS 'Please select the reason why you are flagging this reply.'}"}
    touch "* marked:'#{args}'"  
  end
end