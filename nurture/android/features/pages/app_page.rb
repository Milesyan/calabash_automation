require 'calabash-android/abase'

class AppPage < Calabash::ABase
  def trait
    "*"
  end

  def tap_login
    pass_sso
    puts "TOUCH LOGIN HERE "
    x,y,width = forum_page.get_element_x_y "log_in"
    perform_action('touch_coordinate',(x+width*0.3), y)
  end

  def login
    enter_text "* id:'email'", $user.email
    enter_text "* id:'password'", $user.password
    touch "* id:'sign_in_button'"
  end

  def login_with(email, password)
    enter_text "* id:'email'", email
    enter_text "* id:'password'", password
    sleep 1
    touch "* id:'sign_in_button'"
    wait_for_element_exists "* id:'bottom_action_bar'"
    sleep 1
    if element_exists "* id:'blockingView'"
      bypass_nurture_tutorial
    end
    app_page.open "genius"
  end

  def pass_sso
    if element_exists "* {text CONTAINS 'Continue as'}"
      touch "* marked:'Sign up with another account'"
    end
  end

  def bypass_nurture_tutorial
    `adb shell input keyevent KEYCODE_HOME`
    attempts = 0
    begin
      attempts = attempts + 1
      start_test_server_in_background
    rescue RuntimeError => e 
      retry if attempts < 3
    end  
  end

  def finish_tutorial
    pass_premium_promt
    if element_exists "* id:'blockingView'"
      bypass_nurture_tutorial
    end
  end

  def pass_premium_promt
    if element_exists "* marked:'Try for FREE'"
      touch "* marked:'dismiss_button'"
      sleep 0.5
    end
  end

  def open(tab_name)
    wait_for_element_exists "* id:'bottom_action_bar'"
    sleep 1
    case tab_name.downcase
    when "home"
      touch "* id:'nav_home'"
    when "community"
      touch "* id:'nav_community'"
    when "genius"
      touch "* id:'nav_gg'"
    when "alert"
      touch "* id:'nav_alert'"
    when "me"
      touch "* id:'nav_me'"
    end
  end

  def logout
    sleep 1
    touch "* id:'nav_me'"
    wait_touch "ActionMenuView"
    wait_for(:timeout => 10, :regry_frequency => 2) do
      element_exists "* marked:'Log out'"
    end
    touch "* marked:'Log out'"
    sleep 2
  end

  def forum_element
    wait_for_elements_exist "AppCompatImageView index:0"
  end

  def ntf_join_group
    wait_for_element_exists "* marked:'Join the group!'}"
    wait_touch "* marked:'Check out the group!'"
    wait_touch "* marked:'Join group'"
    sleep 2
  end

  def signup_flow
    wait_touch "* marked:'Get started'"
    wait_touch "* marked:'Choose'"
    wait_touch "* id:'text1' index:0"
    wait_touch "* id:'yes_selector'"
    wait_touch "* id:'due_date_button'"
    wait_touch "* marked:'OK'"
    wait_touch "* marked:'Next'"
    wait_touch "* id:'how_pregnant_button'"
    wait_touch "* id:'text1' index:0"
    wait_touch "* id:'weight_button'"
    enter_text "* marked:'Weight'", "100"
    wait_touch "* marked:'Set'"
    wait_touch "* id:'height_button'"
    wait_touch "* id:'ft_spinner'"
    wait_touch "* id:'text1' index:1"
    wait_touch "* id:'in_spinner'"
    wait_touch "* id:'text1' index:1"
    wait_touch "* marked:'Set'"
    wait_touch "* marked:'Next'"
    wait_for_element_exists "* marked:'Email'"
  end


  def touch_terms
    x,y,width = forum_page.get_element_x_y 'bottom_hint'
    perform_action('touch_coordinate',(x+width*0.4), y+80)
  end

  def touch_privacy_policy
    x,y,width = forum_page.get_element_x_y 'bottom_hint'
    perform_action('touch_coordinate',(x+width*0.55), y+80)
  end

  def hint_section 
    wait_for_element_exists "* id:'bottom_hint'"
  end
end













