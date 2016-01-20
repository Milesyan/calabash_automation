require 'calabash-android/abase'

class LoginPage < Calabash::ABase
  def trait
    "* marked:'Log in'"
  end


  def tap_login
    puts "TOUCH LOGIN HERE "
    touch "* marked:'Log in'"
  end

  def login
    enter_text "* id:'email'", $user.email
    enter_text "* id:'password'", $user.password
    touch "* id:'action_login'"
  end

  def login_with(email, password)
    touch "* marked:'Log in'"
    enter_text "* id:'email'", email
    enter_text "* id:'password'", password
    sleep 1
    touch "* id:'action_login'"
  end


  # def login(email, password)
  #   touch "* marked:'Log in'"
  #   enter_text "* id:'email'", email
  #   enter_text "* id:'password'", password
  #   touch "* id:'action_login'"
  # end
end