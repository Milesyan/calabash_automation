require 'calabash-cucumber/ibase'
class CommonPage < Calabash::IBase
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
      wait_touch "UITabBarButtonLabel marked:'Community'"
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
    if element_exists "* {text CONTAINS 'Continue'}"
      touch "* {text CONTAINS 'Click here to switch user'}"
    end
    wait_touch "* marked:'Log in'"
  end

  def open_forgot_password
    wait_touch "* marked:'Forgot password'"
  end

  def input_email_password(email, password, full_name = "Glow iOS", is_partner = false)
    wait_touch "* marked:'First & Last name'"
    keyboard_enter_text full_name
    #unless is_partner
      wait_touch "UITextField index:1"
      #set_text "UITextField index:1", email
      keyboard_enter_text email
    #end

    wait_touch "UITextField index:2"
    keyboard_enter_text password
    wait_touch "UITextField index:3"
    wait_touch "* marked:'OK'"

    wait_touch "* marked:'Next'"
    wait_touch "label {text BEGINSWITH 'Yes'}"
    sleep 2
    wait_for_elements_do_not_exist("NetworkLoadingView", :timeout => 60)
  end


  def open_settings
    wait_for(:timeout => 10, :retry_frequency => 2) do
      common_page.open "me"
      element_exists "* marked:'Tell friends about Glow Baby'"
    end
    wait_touch "* marked:'Account settings'"
  end

end