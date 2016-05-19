require 'calabash-android/abase'

class PremiumPage < Calabash::ABase
  
  def trait
    '*'
  end

  def pass_premium_promt
    if $login_acc.nil?
      log_important "User not login yet"
    elsif $login_acc != premium_email
      begin
        wait_for(:timeout => 3.5) do
          element_exists("* marked:'top_part'") || element_exists("* marked:'Community'")
        end
      rescue RuntimeError
      end
      if (element_exists("* marked:'Try for FREE'") || element_exists("* marked:'Go Premium'")) && element_exists("* marked:'top_part'")
        touch "* marked:'dismiss_button'"
        sleep 0.5
      end
    elsif $login_acc = premium_email
      check_element_does_not_exist "* marked:'Try for FREE'"
      check_element_does_not_exist "* marked:'Go Premium'"
    end
  end

  def random_url
    ran = ('a'..'z').to_a.shuffle[0,8].join
    $random_url = "www.#{ran}.com"
  end

  def input_url_in_profile_page
    random_url
    clear_text_in "* id:'website'"
    enter_text "* id:'website'", $random_url
  end

  def check_url
    sleep 1
    wait_for_element_exists "* {text CONTAINS '#{$random_url}'}", :timeout  =>3
    sleep 0.5
    touch "* {text CONTAINS '#{$random_url}'}"
  end


  def switch_chat_option
    forum_page.scroll_down_to_see 'Turn off Chat'
    touch "* id:'turn_off_chat'"
  end

  def switch_signature_option
    forum_page.scroll_down_to_see 'Turn off Signature'
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
    wait_for_element_exists "* marked:'#{premium_name}'"
    sleep 1
    wait_touch "* marked:'#{premium_name}'"
  end

  def enter_non_premium_profile
    sleep 1
    wait_touch "* marked:'#{non_premium_name}'"
  end

  def click_send_request
    sleep 1
    wait_touch "* marked:'Send request'"
  end

  def click_upgrade_premium
    sleep 1
    wait_for(:timeout =>5) do
      element_exists("* marked:'Learn more'") ||
      element_exists("* marked:'Try for FREE'") ||
      element_exists("* marked:'Go Premium'") 
    end
    touch_if_element_exists "* marked:'Learn more'"
    touch_if_element_exists "* marked:'Try for FREE'"
    touch_if_element_exists "* marked:'Go Premium'"
  end

  def enter_messages
    wait_touch "* id:'menu_community_chat'"
  end

  def click_name_of_chat_requester
    sleep 0.5
    wait_touch "* marked:'New chat request'"
    sleep 0.5
  end

  def enter_new_user_profile
    wait_touch "* marked:'#{$new_user.first_name}' index:0"
  end

  def close_request_dialog
    wait_touch "* marked:'Cancel'"
  end

  def chat_request_fail
    sleep 1.5
    wait_touch "* marked:'Chat'"
    wait_for_element_exists "* {text CONTAINS 'Can not chat'}", :retry_frequency => 0.1
  end

#---IOS 

  def click_chat_settings
    sleep 1
    wait_touch "* marked:'More options'"
  end

  def send_text_in_chat(args)
    wait_for_element_exists "* marked:'Type something'", :post_timeout => 0.5
    enter_text "* marked:'Type something'", args
    sleep 1
    touch "* id:'send'"
  end

  def send_image_in_chat
    wait_touch "* id:'attachment'"
    # wait_touch "* marked:'Select from Gallery'"
    press_back_button
    enter_text "* marked:'Type something'", "Cannot send image in Android"
    sleep 1
    touch "* id:'send'"
    sleep 3
  end

  def open_contact_list
    wait_touch "* marked:'Contacts'"
  end

  def check_touch_points_in_topic(args)
    forum_page.view_all_replies
    wait_touch "* marked:'Chat'" if [0,1,2,3,4].include? args
    _touch_points_reaction args
    sleep 0.5
    forum_page.click_back_button
    sleep 0.5
    wait_touch "* marked:'Chat' index:0" if [0,1,2,3,4].include? args
    _touch_points_reaction args
    sleep 0.5
    scroll_up if element_does_not_exist "* marked:'Chat' index:1"
    wait_touch "* marked:'Chat' index:1" if [0,1,2,3,4].include? args
    _touch_points_reaction args
  end

  def _touch_points_reaction(args)
    #"premium->non-premium", "non-premium->premium", "non-premium->non-premium
    case args
    when 0, 1, 3
      wait_for_element_exists "* marked:'Send request'"
      close_request_dialog
    when 2
      # wait_for_element_exists "* marked:'Try for FREE'"
      wait_for(:timeout => 3) do
        element_exists("* marked:'Try for FREE'") ||
        element_exists("* marked:'Go Premium'")
      end
      close_request_dialog
    when 4
      wait_for_element_exists "* marked:'Type something'"
      forum_page.click_back_button
    when 5,6
      check_element_does_not_exist "* marked:'Chat'"
      else
        log_error 'Wrong index number.'
    end
  end
end
