require 'calabash-cucumber/ibase'

class AppPage < Calabash::IBase
  def trait
    "*"
  end

  def finish_tutorial
    wait_for_element_does_not_exist "* marked:'Log in with Glow account'"
    sleep 3
    if element_exists "all * marked:'Swipe left or right to navigate through days'"
      tutorial_steps
    else 
      puts "Do not need tutorial steps >_<###"
    end
    sleep 1
    close_chat_popup
  end

  def close_chat_popup
    if element_exists  "* id:'gl-foundation-popup-close'"
      touch "* id:'gl-foundation-popup-close'"
    end
    if element_exists "* marked:'Messages'"
      wait_touch "* marked:'Done'"
    end
  end

  def tutorial_steps
    sleep 1
    flick "UIScrollView index:0", {x:200, y:0}
    sleep 1
    flick "UIScrollView index:0", {x:200, y:0}
    sleep 0.5
    swipe :down
    sleep 0.5
    swipe :down
    wait_for_elements_exist "* marked:'TODAY'", :timeout => 10
    touch "* marked:'TODAY'"
    sleep 1
    wait_for_elements_exist "GLHomeDailyLogEntryCell", :timeout => 10
    sleep 1.5
    touch "GLHomeDailyLogEntryCell"
    wait_for_none_animating
    touch "* id:'back'"
    sleep 1
  end


  def close_insights_popup
    sleep 1
    wait_for(:timeout => 10, :retry_frequency => 1) do
      element_exists "* id:'icon-cancel-shadow'"
    end
    touch "* id:'icon-cancel-shadow'"
  end

  def keyboard_input(n)
    wait_touch "UIKBKeyView index:#{n}"
  end

  def logout
    wait_for_none_animating
    if element_exists "* marked:'Invite your partner!'"
      wait_touch "* id:'gl-foundation-popup-close'"
    end
    scroll_to_row_with_mark "Settings"
    wait_for_none_animating
    wait_touch "* marked:'Settings'"
    scroll_to_row_with_mark "Logout"
    wait_for_none_animating
    sleep 0.5
    wait_touch "* marked:'Logout'"
    sleep 1
    touch "* marked:'Yes, log out'"
    wait_for_element_does_not_exist "* marked:'Yes, log out'"
    sleep 0.5
  end

  def open(tab_name)
    case tab_name.downcase
    when "home"
      wait_touch "UITabBarButtonLabel marked:'Home'"
    when "community"
      wait_touch "UITabBarButtonLabel marked:'Community'"
      sleep 1
      if element_exists  "* id:'gl-foundation-popup-close'"
        touch "* id:'gl-foundation-popup-close'"
      end
    when "genius"
      wait_touch "UITabBarButtonLabel marked:'Genius'"
    when "alert"
      wait_touch "UITabBarButtonLabel marked:'Alert'"
    when "me"
      wait_touch "UITabBarButtonLabel marked:'Me'"
    end
    sleep 1
    close_chat_popup
  end

  def tap_login_link
    sleep 1
    pass_sso
    wait_for_element_exists("* marked:'Log in with Glow account'", :timeout => 20)
    touch("* marked:'Log in with Glow account'", :offset => {:x => -50, :y => -10})
    sleep 1
  end

  def get_started
    logout_if_already_logged_in
    wait_touch "* marked:'Get Started!'"
  end


  def login(email, password)
    tap_login_link
    wait_for_none_animating
    wait_touch "* marked:'Email'"
    keyboard_enter_text email
    wait_touch "* marked:'Password'"
    keyboard_enter_text password
    touch "UINavigationButton marked:'Next'"
  end
  
  def ntf_join_group
    wait_for_element_exists "* {text CONTAINS 'Check out the group'}"
    wait_touch "* {text CONTAINS 'Check out the group'}"
    wait_touch "* marked:'Join'"
    sleep 2
  end

  def pass_sso
    if element_exists "* {text CONTAINS 'Continue as'}"
      touch "* {text CONTAINS 'Click here'}"
    end
  end
  
  def signup_flow
    pass_sso
    wait_touch "* marked:'Get Started!'"
    wait_touch "* marked:'Choose'"
    wait_for_none_animating
    wait_touch "* marked:'Done'"
    wait_touch "* marked:'Do you know your due date?' sibling GLPillButton index:0" #Yes
    wait_touch "* marked:'Estimated due date' sibling GLPillButton index:0"
    wait_touch "* marked:'Done'"
    touch "* marked:'Next'"
    wait_touch "* marked:'How did you get pregnant?' sibling GLPillButton"
    wait_touch "* marked:'Done'"

    touch "GLPillButton marked:'Weight'"
    wait_for_none_animating
    wait_touch "* marked:'Done'"
    touch "GLPillButton marked:'Height'"
    wait_for_none_animating
    wait_touch "* marked:'Done'"
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
end