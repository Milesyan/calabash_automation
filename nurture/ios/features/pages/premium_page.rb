require 'calabash-cucumber/ibase'

class PremiumPage < Calabash::IBase

  def trait
    "*"
  end

  def random_url
    ran = ('a'..'z').to_a.shuffle[0,8].join
    $random_url = "www.#{ran}.com"
  end

  def input_url_in_profile_page
    random_url
    clear_text "* marked:'Link' sibling * index:0"
    wait_touch "* marked:'Link' sibling * index:0"
    keyboard_enter_text $random_url
  end

  def check_url
    wait_for_element_exists "* {text CONTAINS '#{$random_url}'}", :time_out =>3
    touch "* {text CONTAINS '#{$random_url}'}"
  end

  def back_from_web_page
    wait_touch "* id:'gl-foundation-back'"
  end

  def switch_chat_option
    forum_page.scroll_down_to_see "Turn off Chat"
    wait_touch "UISwitch marked:'Turn off Chat'"
  end

  def switch_signature_option
    forum_page.scroll_down_to_see "Turn off Signature"
    wait_touch "UISwitch marked:'Turn off Signature'"
  end

  def update_bio_location
    forum_page.edit_text_fields "Shanghai", "Edit Shanghai"
    wait_touch "UILabel marked:'Bio'"
    keyboard_enter_text "testbio"
  end

  def enter_premium_profile
    wait_touch "* marked:'miles3'"
  end

  def enter_non_premium_profile
    wait_touch "* marked:'milesn'"
  end

  def click_send_request
    wait_touch "UIButton marked:'Send request'"
  end

  def click_upgrade_premium
    wait_touch "UIButton marked:'Get Glow Premium'"
  end

  def enter_messages
    app_page.close_chat_popup
    wait_touch "* marked:'gl community navtab search' sibling UIView index:3"
  end

  def click_name_of_chat_requester
    sleep 0.5
    wait_touch "* marked:'New chat request.'"
    sleep 1
    touch "* marked:'New chat request.'" if element_exists "* marked:'New chat request.'"
  end

  def enter_new_user_profile
    wait_touch "* marked:'#{$new_user.first_name}' index:0"
  end

  def close_request_dialog
    wait_touch "* id:'gl-foundation-popup-close'"
  end

  def chat_request_fail
    wait_touch "* marked:'Chat'"
    wait_for_element_exists "* marked:'Can not chat because you turned off chat.'"
  end

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
    sleep 2
    if element_exists "* marked:'OK'"
      touch "* marked:'OK'"
    end
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
      app_page.close_chat_popup
      forum_page.click_back_button
    when 5,6
      check_element_does_not_exist "* marked:'Chat'"
    end
  end

  def touch_accept_request
    begin 
      wait_for_element_exists "* marked:'Accept Request'", :time_out => 1
      touch "* marked:'Accept Request'"
    rescue RuntimeError
      wait_touch "* {text CONTAINS 'Accept Request'}"
    end
  end
end