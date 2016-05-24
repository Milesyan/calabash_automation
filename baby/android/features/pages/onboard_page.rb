require 'calabash-android/abase'

class OnboardPage < Calabash::ABase
  def trait
    "*"
  end

  def signup
    sleep 1
    touch "* id:'sign_up'"
    enter_text "* id:'name'", $user.first_name + " " + $user.last_name
    enter_text "* id:'email'", $user.email
    enter_text "* id:'password'", $user.password
    touch "* id:'birthday_picker'"
    set_date "datePicker", date_str($user.birthday)
    touch "* marked:'Done'"
    touch "* id:'action_sign_up'"
    sleep 1
    puts "User #{$user.email} has just signed up"
    #wait_for_text_to_disappear "Loading...", timeout: 30
    #wait_for_text "Tell us a little bit about your baby"
  end

  def login(email, password)
    touch "* marked:'Log in'"
    enter_text "* id:'email'", email
    enter_text "* id:'password'", password
    touch "* id:'action_login'"
    sleep 3
    touch "* id:'dismiss_button'"
  end

  def close_premium_introdution
    sleep 2
    touch "* id:'dismiss_button'" if element_exists "* id:'dismiss_button'"
  end

  def login_with_no_baby(email, password)
    touch "* marked:'Log in'"
    enter_text "* id:'email'", email
    enter_text "* id:'password'", password
    touch "* id:'action_login'"
  end

end