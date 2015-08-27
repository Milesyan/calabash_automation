require 'calabash-android/abase'

class LoginPage < Calabash::ABase
  def trait
    "* id:'sign_in_button'"
  end

  def login
    enter_text "* id:'email'", $user.email
    enter_text "* id:'password'", $user.password
    touch "* id:'sign_in_button'"
  end
end