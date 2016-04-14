require 'calabash-cucumber/ibase'
class AppPage < Calabash::IBase
  def trait
    "*"
  end

  def close_chat_popup
    if element_exists  "* id:'gl-foundation-popup-close'"
      touch "* id:'gl-foundation-popup-close'"
    end
    if element_exists "* marked:'Messages'"
      wait_touch "* marked:'Done'"
    end
  end


  def open(tab_name)
    wait_for_element_exists "UITabBar"
    case tab_name.downcase
    when "home"
      wait_touch "UITabBarButtonLabel marked:'Home'"
    when "community"
      wait_for_element_exists "UITabBarButtonLabel marked:'Community'"
      touch "UITabBarButtonLabel marked:'Community'"
      sleep 1
      get_started_popup = "* id:'gl-foundation-popup-close'"
      wait_touch get_started_popup if element_exists get_started_popup
    when "alert"
      wait_touch "UITabBarButtonLabel marked:'Alert'"
    when "me"
      wait_touch "UITabBarButtonLabel marked:'More'"
    end
  end

  def logout
    wait_for_element_exists "* id:'Settings'"
    scroll_to_row_with_mark "Logout"
    wait_touch "* marked:'Logout'"
    wait_for_none_animating
    sleep 1
  end

  def login(email, password)
    open_login_link
    wait_touch "* marked:'Email'"
    keyboard_enter_text email
    wait_touch "* marked:'Password'"
    keyboard_enter_text password
    # touch "* marked:'Next'"
    touch "* marked:'Log me in!' index:0"
    sleep 3
  end

  def open_login_link
    pass_sso
    wait_touch "* marked:'Log in'"
  end

  def open_forgot_password
    wait_touch "* marked:'Forgot password'"
  end


  def open_settings
    wait_for(:timeout => 10, :retry_frequency => 2) do
      app_page.open "me"
      element_exists "* marked:'Tell friends about Glow Baby'"
    end
    wait_touch "* marked:'Account settings'"
  end
  
  def finish_tutorial
    puts "NO TUTORIAL IN BABY"
  end

  def ntf_join_group
    wait_for_element_exists "* {text CONTAINS 'Check it out'}"
    wait_touch "* {text CONTAINS 'Check it out'}"
    wait_touch "* marked:'Join'"
    sleep 2
  end

  def pass_sso
    if element_exists "* {text CONTAINS 'Continue'}"
      touch "* {text CONTAINS 'Click here to switch user'}"
    end
  end

  def signup_flow
    pass_sso
    wait_touch "* marked:'Sign up!'"
  end

  def touch_terms
    x,y,w,h = forum_page.get_coordinate 'Terms and Privacy Policy'
    _x = x + w * 0.3
    _y = y + h * 0.85
    forum_page.touch_coordinate _x,_y
  end

  def touch_privacy_policy
    x,y,w,h = forum_page.get_coordinate 'Terms and Privacy Policy'
    _x = x + w * 0.6
    _y = y + h * 0.85
    forum_page.touch_coordinate _x,_y
  end

  def hint_section 
    wait_for_element_exists "* {text CONTAINS 'Terms and Privacy Policy'}"
  end

end