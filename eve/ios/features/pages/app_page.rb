require 'calabash-cucumber/ibase'

class AppPage < Calabash::IBase


  def embed(x,y=nil,z=nil)
    puts "Screenshot at #{x}"
  end
  
  def trait
    "*"
  end

  def tap_login_link
    pass_sso
    wait_for_element_exists "* marked:'LOG\u2028IN'"
    touch "* marked:'LOG\u2028IN'"
    if element_does_not_exist "* marked:'Email'"
      wait_touch "* marked:'LOG\u2028IN'"
    end
    sleep 1
  end

  def pass_sso
    if element_exists "* {text CONTAINS 'Continue as'}"
      touch "* {text contains 'Click here to switch user'}"
    end
  end

  def get_started
    wait_touch "* marked:'Get it, Girl'"
  end

  def login(email, password)
    $login_acc = email
    tap_login_link
    wait_for_none_animating
    wait_touch "* marked:'Email'"
    keyboard_enter_text email
    wait_touch "* marked:'Password'"
    keyboard_enter_text password
    touch "UINavigationButton marked:'Next'"
    sleep 1
    # if element_exists "* marked:'Get it, Girl'"
    #   bypass_temp
    # end
    finish_tutorial
  end

  
  def bypass_temp
    wait_touch "* marked:'Get it, Girl'"
    wait_touch "* {text CONTAINS 'days'}"
    wait_touch "* {text CONTAINS '28'}"
    wait_touch "* {text CONTAINS 'Done'}"
    sleep 1
    wait_touch "* {text CONTAINS 'Next'}"
    wait_touch "* {text CONTAINS 'm/d/y'}"
    wait_touch "* {text CONTAINS 'Today'}"
    sleep 1
    wait_touch "UIButtonLabel {text CONTAINS 'Done'}"
    sleep 1
    wait_touch "* {text CONTAINS 'Next'}"
    wait_touch "* {text CONTAINS 'Choose'}"
    wait_touch "* {text CONTAINS 'None'}"
    wait_touch "* {text CONTAINS 'Done'} index:1"
    wait_touch "* {text CONTAINS 'Done'} index:0"
  end


  def ntf_join_group
    wait_for_element_exists "* {text CONTAINS 'Check it out!'}"
    wait_touch "* {text CONTAINS 'Check it out!'}"
    wait_touch "* marked:'Join'"
    sleep 2
  end


  def logout
    close_chat_popup
    scroll_to_row_with_mark 'Account settings'
    wait_touch "* marked:'Account settings'"
    close_chat_popup
    scroll_to_row_with_mark "Logout"
    wait_for_none_animating
    close_chat_popup
    wait_touch "* marked:'Logout'"
    $login_acc = nil
    sleep 0.5
    wait_for(:timeout => 5) do
      element_exists("* marked:'Get it, Girl'") || element_exists("* {text contains 'Continue as'}")
    end
  end

  def close_community_popup
    if element_exists  "* id:'gl-foundation-popup-close'"
      touch "* id:'gl-foundation-popup-close'"
    end
  end

  def close_chat_popup
    until element_does_not_exist("* id:'gl-foundation-popup-close'") && element_does_not_exist("* marked:'Messages'")
      touch "* id:'gl-foundation-popup-close'" if element_exists "* id:'gl-foundation-popup-close'"
      touch  "* marked:'Done'" if element_exists "* marked:'Messages'"
      sleep 0.3
    end
  end


  def open(tab_name)
    wait_touch "* text:'Me'"
    case tab_name.downcase
    when "home"
      wait_touch "UITabBarButton marked:'Home'"
    when "community"
      wait_touch "UITabBarButtonLabel marked:'Community'"
      close_chat_popup
      if element_does_not_exist "* marked:'New'"
        close_chat_popup
        touch_if_element_exists "UITabBarButtonLabel marked:'Community'"
      end
      sleep 1
      close_chat_popup
    when "alert"
      wait_touch "UITabBarButtonLabel marked:'Alert'"
      if element_does_not_exist "* marked:'Notifications'"
        wait_touch "UITabBarButtonLabel marked:'Alert'"
      end
    when "me"
      wait_touch "UITabBarButton marked:'Me'"
    end
    close_chat_popup
  end

  def finish_tutorial
    premium_page.pass_premium_promt
    sleep 0.5
    tutorial_steps
  end

  def tutorial_steps
    if element_exists("* marked:'Got it'") || element_exists("* id:'close-btn'")
      puts "Eve period cycle tutorial."
      temp = 1
    end
    until element_does_not_exist("* marked:'Got it'") && element_does_not_exist("* id:'close-btn'")
      touch "* marked:'Got it'" if element_exists "* marked:'Got it'"
      touch "* id:'close-btn'" if element_exists "* id:'close-btn'"
      sleep 0.3
    end
    wait_for_element_exists "* marked:'Community'" if temp == 1
    temp = 0 
    sleep 1
    if element_exists "* text:'Did you start your new period? '"
      wait_touch "* marked:'No'"
      wait_touch "* marked:'10 days'"
    end
  end

  def signup_flow
    pass_sso
  end

  def touch_terms
    x,y,w,h = forum_page.get_coordinate 'you agree to our Terms and Privacy Policy'
    _x = x + w * 0.6
    _y = y + h * 0.85
    forum_page.touch_coordinate _x,_y
  end

  def touch_privacy_policy
    x,y,w,h = forum_page.get_coordinate 'you agree to our Terms and Privacy Policy'
    _x = x + w * 0.8
    _y = y + h * 0.85
    forum_page.touch_coordinate _x,_y
  end

  def hint_section 
    wait_for_element_exists "* {text CONTAINS 'you agree to our Terms and Privacy Policy'}"
  end

  def check_TOS_website
    wait_for_elements_exist ["* id:'gl-foundation-browser-send'", "* id:'gl-foundation-browser-reload'"], :timeout  => 30
  end
end