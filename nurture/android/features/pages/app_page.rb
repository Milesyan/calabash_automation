require 'calabash-android/abase'

class AppPage < Calabash::ABase
  def trait
    "*"
  end

  def tap_login
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
end