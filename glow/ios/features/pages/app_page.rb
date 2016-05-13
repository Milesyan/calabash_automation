require 'calabash-cucumber/ibase'

class AppPage < Calabash::IBase
  include Calabash::Cucumber::Operations
  
  def trait
    "*"
  end

  def login(email, password)
    $login_acc = email
    open_login_link
    wait_touch "* marked:'Email'"
    keyboard_enter_text email
    wait_touch "* marked:'Password'"
    keyboard_enter_text password
    touch "* marked:'Next'"
    sleep 2
    finish_tutorial
  end

  def open_login_link 
    sleep 1
    pass_sso
    wait_touch "* marked:'Log in'"
    if element_does_not_exist "* marked:'Email'"
      wait_touch "* marked:'Log in'"
    end
  end

  def open_forgot_password
    wait_touch "* marked:'Forgot password'"
  end


  def open_settings
    forum_page.scroll_down_to_see 'Account settings'
    scroll_to_row_with_mark 'Account settings'
    sleep 1
    wait_touch "label marked:'Account settings'"
  end

  def logout
    close_chat_popup
    # forum_page.scroll_down_to_see 'Logout'
    scroll_to_row_with_mark 'Logout'
    close_chat_popup
    wait_touch "* marked:'Logout'"
    close_chat_popup
    touch "* marked:'Logout'" # for some reason, have to touch Logout button twice since 5.2
    close_chat_popup
    wait_touch "* marked:'Yes, log out'"
    $login_acc = nil
    wait_for_none_animating
    wait_for(:timeout => 5) do
      element_exists("* marked:'Log in'") || element_exists("* {text CONTAINS 'Continue as'}")
    end
  end
  
  def open(tab_name)
    close_chat_popup
    wait_for_element_exists "UITabBar"
    sleep 1
    case tab_name.downcase
    when "home"
      wait_touch "* marked:'Home'"
    when "community"
      wait_touch "* marked:'Community'"
      wait_for_none_animating :post_timeout => 0.8
      close_chat_popup
      wait_for_element_exists "* marked:'Community'", :post_timeout => 0.5
      if element_does_not_exist "* marked:'New'"
        touch "* marked:'Community'"
      end
    when "genius"
      wait_touch "* marked:'Genius'"
    when "alert"
      wait_touch "* marked:'Alert'"
    when "me"
      close_chat_popup
      wait_touch "* marked:'Me'"
      sleep 1
      if element_exists "* marked:'gl foundation popup close'"
        touch "* marked:'gl foundation popup close'"
      end
    end
    close_chat_popup
  end

  def ntf_join_group
    wait_for_element_exists "* {text CONTAINS 'Check out the group'}"
    wait_touch "* {text CONTAINS 'Check out the group'}"
    wait_touch "* marked:'Join'"
    sleep 2
  end

  def close_chat_popup
    2.times do
      until element_does_not_exist("* id:'gl-foundation-popup-close'") && element_does_not_exist("* marked:'Messages'")
        touch "* id:'gl-foundation-popup-close'" if element_exists "* id:'gl-foundation-popup-close'"
        touch "* marked:'Done'" if element_exists "* marked:'Messages'"
        sleep 0.5
      end
    end
  end

  def finish_tutorial
    premium_page.pass_premium_promt
    sleep 0.5
    just_tutorial
    close_chat_popup
  end

  def just_tutorial
    if element_exists "* id:'tutorial-arrow-right'"
      log_msg "Glow Tutorial"
      until_element_does_not_exist("* id:'tutorial-arrow-right'", :action => lambda {swipe :left, :query => "NewDateButton index:2"})
      wait_for_none_animating
      wait_touch "* marked:'Today'"
      wait_for_none_animating
      from = "NewDateButton index:2"
      to = "* marked:'Complete log!'"
      until_element_does_not_exist("* marked:'Pull down to see the full calendar view'", :action => lambda { pan from, to, duration: 1 } )  
      wait_for_none_animating
      from = "* marked:'WED'"
      to = "* marked:'Sex'" #if ["iui", "ivf", "med", "prep"].include? $user.type
      until_element_does_not_exist("* marked:'Pull down to see the small calendar view'", :action => lambda { pan from, to, duration: 1 })
      wait_for_none_animating
      touch_later_link
      wait_for_none_animating
    end
  end

  def touch_later_link
    begin
      when_element_exists("* marked:'Later'", :timeout => 3)
      touch "* marked:'Later'"
    rescue # Calabash::Cucumber::WaitHelpers::WaitError
    end
  end

  def pass_sso
    if element_exists "* {text CONTAINS 'Continue as'}"
      touch "* {text CONTAINS 'Click here'}"
    end
  end
  
  def signup_flow
    pass_sso
    wait_touch "* marked:'Get Started!'"
    wait_touch "button index:0"
    wait_touch "* marked:'Choose'"
    wait_touch "* marked:'Condom'"
    wait_touch "* marked:'Done'"
    wait_touch "button marked:'Weight'"
    wait_touch "* marked:'150'"
    wait_touch "* marked:'Done'"
    wait_touch "button marked:'Height'"
    wait_touch "* marked:'6 ft'"
    wait_touch "* marked:'0 in'"
    wait_touch "* marked:'Done'"
    wait_touch "button marked:'Next'"

    wait_touch "button marked:'-- days'"
    wait_touch "* marked:'30'"
    wait_touch "button marked:'OK'"
    wait_touch "button marked:'M/D/Y'"
    #wait_touch "* marked:'#{(Time.now - 3600*48).strftime("%d")}'"
    wait_touch "* marked:'Today'"
    wait_touch "button marked:'Done'"
    wait_for_none_animating
    wait_touch "* marked:'Next'"
  end


  def touch_terms
    wait_for_elements_exist "* marked:'Terms'", :timeout  => 50
    touch "* marked:'Terms'"
  end

  def touch_privacy_policy
    wait_for_elements_exist "* marked:'Privacy Policy'",  :timeout  => 50
    touch "* marked:'Privacy Policy'"
  end

  def hint_section 
    wait_for_elements_exist "* marked:'Terms", "* marked:'Privacy Policy'"
  end

  def check_TOS_website
    wait_for_elements_exist "* marked:'Close'", :timeout  => 30
  end
end