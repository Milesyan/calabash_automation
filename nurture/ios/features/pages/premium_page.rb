require 'calabash-cucumber/ibase'

class PremiumPage < Calabash::IBase
  def trait
    "*"
  end

  def input_url_in_profile_page
    if element_does_not_exist "* marked:'#{URL}'"
      wait_touch "* marked:'Link' sibling * index:0"
      keyboard_enter_text URL
    end
  end

  def check_url
    wait_for_element_exists "* {text CONTAINS '#{URL}'}", :time_out =>3
    touch "* {text CONTAINS '#{URL}'}"
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
    wait_touch "* marked:'miles2'"
  end

  def enter_non_premium_profile
    wait_touch "* marked:'milesn'"
  end

  def click_send_request
    wait_touch "UIButton marked:'Send request'"
  end

  def click_upgrade_premium
    wait_touch "UIButton marked:'Upgrade to Glow Premium'"
  end

  def enter_messages
    wait_touch "* id:'gl-community-navbar-chat.png'"
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
    wait_touch "* id:'gl-foundation-popup-close'"
  end

  def chat_request_fail
    wait_touch "* marked:'Chat'"
    wait_touch "UIButton marked:'Send request'"
    wait_for_element_exists "* marked:'Failed to send chat request.'"
  end



end