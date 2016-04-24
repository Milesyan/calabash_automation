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
    swipe :up
    wait_touch "UILabel {text CONTAINS 'Signature'}"
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
    sleep 1
    touch "UIButton marked:'Get Glow Premium'" if element_exists "UIButton marked:'Get Glow Premium'"
    touch "* marked:'Try for FREE'" if element_exists "* marked:'Try for FREE'"
  end

  def enter_messages
    app_page.close_chat_popup
    sleep 0.5
    wait_touch "* marked:'gl community navtab search' sibling UIView index:3"
  end

  def click_name_of_chat_requester
    wait_for_element_exists "* marked:'New chat request.'"
    wait_poll(timeout: 10,
          timeout_message: 'Unable to click chat requester',
          until: element_does_not_exist("* marked:'New chat request.'")) do
      touch "* marked:'New chat request.'"
    end
    sleep 1
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
      wait_for(:time_out=>3) do
        element_exists("UIButton marked:'Get Glow Premium'") || element_exists("UIButton marked:'Try for FREE'")
      end
      close_request_dialog
    when 4
      app_page.close_chat_popup
      wait_for_element_exists "* marked:'Enter Message'", :time_out => 10
      app_page.close_chat_popup
      forum_page.click_back_button
    when 5,6
      check_element_does_not_exist "* marked:'Chat'"
    end
  end

  def touch_accept_request
    begin 
      wait_for(:time_out => 2) do
        element_exists("* marked:'Accept Request'") || element_exists("* {text CONTAINS 'Accept Request'}")
      end
      touch "* marked:'Accept Request'" if element_exists "* marked:'Accept Request'"
      touch "* {text CONTAINS 'Accept Request'}" if element_exists "* {text CONTAINS 'Accept Request'}"
    rescue RuntimeError
      wait_touch "* {text CONTAINS 'Accept Request'}"
    end
  end
end