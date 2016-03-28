require 'calabash-cucumber/ibase'

class AppPage < Calabash::IBase
  def trait
    "*"
  end

  def login(email, password)
    open_login_link
    wait_touch "* marked:'Email'"
    keyboard_enter_text email
    wait_touch "* marked:'Password'"
    keyboard_enter_text password
    touch "* marked:'Next'"
    sleep 2
  end

  def dismiss_install_message
    if element_exists "* {text CONTAINS 'Congrats'}"
      puts "Add dismiss install"
    end
  end 

  def open_login_link 
    wait_touch "* marked:'Log in'"
    if element_does_not_exist "* marked:'Email'"
      wait_touch "* marked:'Log in'"
    end
  end

  def open_forgot_password
    wait_touch "* marked:'Forgot password'"
  end


  def open_settings
    scroll_to_row_with_mark "Settings"
    sleep 1
    wait_touch "label marked:'Settings'"
  end



  def close_invite_partner_popup
    begin
      when_element_exists("* id:'gl-foundation-popup-close'", :timeout => 2)
    rescue Calabash::Cucumber::WaitHelpers::WaitError
      #puts "no invite partner popup"
    end
  end


  def logout
    scroll_to_row_with_mark "Logout"
    wait_touch "* marked:'Logout'"
    touch "* marked:'Logout'" # for some reason, have to touch Logout button twice since 5.2
    wait_touch "* marked:'Yes, log out'"
    wait_for_none_animating
    sleep 1
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
      sleep 1
      if element_exists "* marked:'gl foundation popup close'"
        touch "* marked:'gl foundation popup close'"
      end
    end
  end

  def ntf_join_group
    wait_for_element_exists "* {text CONTAINS 'Check out the group'}"
    wait_touch "* {text CONTAINS 'Check out the group'}"
    wait_touch "* marked:'Join'"
    sleep 2
  end
end