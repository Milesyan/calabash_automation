require 'calabash-android/abase'

class PremiumPage < Calabash::ABase
  def trait
    "*"
  end

  def input_url_in_profile_page
    if element_does_not_exist "* marked:'website Url'"
      enter_text "* id:'website'","www.google.com"
    end
  end

  def check_url
    wait_for_element_exists "* {text CONTAINS '#{URL}'}", :time_out =>3
    touch "* {text CONTAINS '#{URL}'}"
  end

  def back_from_web_page
    puts ""
  end

  def switch_chat_option
    forum_page.scroll_down_to_see "Turn off Chat"
    touch "* id:'turn_off_chat'"
  end

  def switch_signature_option
    forum_page.scroll_down_to_see "Turn off Signature"
    touch "* id:'turn_off_signature'"
  end

  def update_bio_location
    enter_text "* id:'first_name'", "Testname"
    enter_text "* id:'last_name'", "TestLast"
    enter_text "* id:'bio'", "Add Bio info"
    enter_text "* id:'location'", "New York"
    wait_touch "* marked:'Save'"
  end

  def enter_premium_profile
    wait_for_element_exists "* marked:'milesp'"
    sleep 1
    wait_touch "* marked:'milesp'"
  end

  def enter_non_premium_profile
    wait_touch "* marked:'milesn'"
  end

  def click_send_request
    wait_touch "* marked:'Send request'"
  end

  def click_upgrade_premium
    wait_touch "* marked:'Upgrade to Glow Premium'"
  end

  def enter_messages
    wait_touch "* id:'menu_community_chat'"
  end

  def click_name_of_chat_requester
    sleep 0.5
    wait_touch "* marked:'New chat request.'"
    sleep 0.5
  end

  def enter_new_user_profile
    wait_touch "* marked:'#{$new_user.first_name}' index:0"
  end

  def close_request_dialog
    wait_touch "* marked:'Cancel'"
  end

  def chat_request_fail
    wait_touch "* marked:'Chat'"
    wait_for_element_exists "* {text CONTAINS 'Can not chat'}"
  end

#---IOS 

  def click_chat_settings
    sleep 1
    touch "UINavigationButton index:0"
    # wait_for_element_exists "* marked:'Chat options'"
  end

  def send_text_in_chat(args)
    wait_touch "* marked:'Enter Message'"
    keyboard_enter_text args
    sleep 1
    touch "* marked:'Send'"
  end

  def send_image_in_chat
    wait_touch "* marked:'Message Input Toolbar Camera Button'"
    wait_touch "* marked:'Last Photo'" 
    sleep 1
    touch "* marked:'Send'"
    sleep 3
  end

  def open_contact_list
    wait_touch "* marked:'Contacts'"
  end

  def check_touch_points_in_topic(args)
    forum_page.view_all_replies
    wait_touch "* marked:'Chat'" if [0,1,2,3,4].include? args
    _touch_points_reaction args
    forum_page.click_back_button
    wait_touch "UIButton marked:'Chat' index:0" if [0,1,2,3,4].include? args
    _touch_points_reaction args
    wait_touch "UIButton marked:'Chat' index:1" if [0,1,2,3,4].include? args
    _touch_points_reaction args
  end

  def _touch_points_reaction(args)
    #"premium->non-premium", "non-premium->premium", "non-premium->non-premium
    case args
    when 0, 1, 3
      wait_for_element_exists "* marked:'Send request'"
      close_request_dialog
    when 2
      wait_for_element_exists "UIButton marked:'Get Glow Premium'"
      close_request_dialog
    when 4
      wait_for_element_exists "* marked:'Enter Message'"
      premium_page.close_chat_popup
      forum_page.click_back_button
    when 5,6
      check_element_does_not_exist "* marked:'Chat'"
    end
  end
end
