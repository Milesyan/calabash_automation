require 'calabash-android/abase'

class LoginPage < Calabash::ABase
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
    nav_page.open "genius"
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

end