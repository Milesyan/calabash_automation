require 'calabash-cucumber/ibase'

class PremiumPage < Calabash::IBase
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
    wait_touch "* marked:'miles2'"
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
    wait_touch "* marked:'Send request'"
    wait_for_element_exists "* marked:'Failed to send chat request.'"
  end



end