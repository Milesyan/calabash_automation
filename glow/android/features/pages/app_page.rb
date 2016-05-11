require 'calabash-android/abase'

class AppPage < Calabash::ABase
  def trait
    '*'
  end

  def login
    enter_text "* id:'email'", $user.email
    enter_text "* id:'password'", $user.password
    wait_touch "* id:'sign_in_button'"
  end

  def login_with(email, password)
    $login_acc = email
    enter_text "* id:'email'", email
    enter_text "* id:'password'", password
    sleep 1
    wait_touch "* id:'sign_in_button'"
    finish_tutorial
  end

  def open(page)
    wait_for_element_exists "* id:'nav_home'"
    sleep 0.5
    case page.downcase
    when 'home'
      touch "* id:'nav_home'"
    when 'community'
      touch "* id:'nav_community'"
    when 'genius'
      touch "* id:'nav_gg'"
    when 'alert'
      touch "* id:'nav_alert'"
    when 'me'
      touch "* id:'nav_me'"
    end
  end


  def tap_login
    sleep 1
    puts "TOUCH LOGIN HERE "
    wait_touch "* id:'log_in'"
  end

  def logout
    open 'me'
    wait_for_element_exists "android.support.v7.widget.ActionMenuPresenter$OverflowMenuButton"
    menu_button = "android.support.v7.widget.ActionMenuPresenter$OverflowMenuButton"
    wait_for(:timeout => 10, :regry_frequency => 2) do
      element_exists menu_button
    end
    wait_touch menu_button
    sleep 0.5
    wait_touch "* text:'Log out'"
    $login_acc = nil
    wait_for(:timeout=> 5) do
      element_exists("* id:'log_in'") || element_exists("* marked:'Sign up with another account'")
    end
  end
  
  def forum_element
    wait_for_elements_exist "* marked:'Community'"
  end

  def ntf_join_group
    wait_for_element_exists "* {text CONTAINS 'Join the group!'}"
    wait_touch "* {text CONTAINS 'Check it out'}"
    wait_touch "* marked:'Join group'"
    sleep 2
  end
  
  def pass_sso
    if element_exists "* {text CONTAINS 'Continue as'}"
      touch "* marked:'Sign up with another account'"
    end
  end

  def signup_flow
    pass_sso
    touch "* marked:'Sign up'"
    touch "* id:'ttc_text'"
    
    touch "* id:'children_count_picker'"
    touch "* marked:'1'"
    touch "* id:'ttc_length_text_view'"
    touch "* marked:'Set'"
    touch "* id:'bmi_calculator'"
    enter_text "* id:'lb_editor'", "144"
    touch "* id:'ft_spinner'"
    touch "* marked:'5 FT'"
    touch "* id:'in_spinner'"
    touch "* marked:'6 IN'"
    touch "* marked:'Set'"
    touch "* marked:'Next'"

    touch "* id:'cycle_length'"
    touch "* marked:'30 days'"
    touch "* id:'first_pb'"
    touch "* id:'month_day'"
    touch "* id:'next_action'" # DONE button
    touch "* id:'next_action'"
  end


  def touch_terms
    x,y,width = forum_page.get_element_x_y 'tos'
    perform_action('touch_coordinate',(x+width*0.4), y+40)
  end

  def touch_privacy_policy
    x,y,width = forum_page.get_element_x_y 'tos'
    perform_action('touch_coordinate',(x+width*0.55), y+40)
  end

  def hint_section 
    wait_for_element_exists "* id:'tos'"
  end

  def finish_tutorial
    premium_page.pass_premium_promt
    pass_insight
  end

  def pass_insight
    begin
      wait_for(:timeout => 3) do
        element_exists("* id:'more_insights_button'") || element_exists("* marked:'Community'")
      end
    rescue RuntimeError
    end
    sleep 0.5
    while element_exists "* id:'more_insights_button'"
      system("adb shell input keyevent KEYCODE_BACK")
      puts "Touch System Back button"
    end
  end

end