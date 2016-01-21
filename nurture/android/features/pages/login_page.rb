require 'calabash-android/abase'

class LoginPage < Calabash::ABase
  def trait
    "* id:'log_in'"
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
    tap_login
    enter_text "* id:'email'", email
    enter_text "* id:'password'", password
    sleep 1
    touch "* id:'sign_in_button'"
  end


  # def login(email, password)
  #   touch "* marked:'Log in'"
  #   enter_text "* id:'email'", email
  #   enter_text "* id:'password'", password
  #   touch "* id:'action_login'"
  # end
end