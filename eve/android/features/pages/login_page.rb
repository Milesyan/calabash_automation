require 'calabash-android/abase'

class LoginPage < Calabash::ABase
  def trait
    "*"
  end

  def tap_login
    puts "TOUCH LOGIN HERE "
    touch "* id:'login'"
  end

  def login
    enter_text "* id:'email'", $user.email
    enter_text "* id:'password'", $user.password
    touch "* id:'sign_in_button'"
    bypass_eve
  end

  def login_with(email, password)
    enter_text "* id:'email'", email
    enter_text "* id:'password'", password
    sleep 1
    touch "* id:'sign_in_button'"
    bypass_eve
  end

  def bypass_eve
    wait_touch "* id:'cycleDaysQuestionButton'"
    sleep 0.5
    touch "* marked:'25 days'"
    sleep 0.5
    touch "* marked:'NEXT'"
    sleep 0.5
    touch "* id:'lastPeriodStartQuestionButton'"
    sleep 0.3
    touch "* marked:'14'"
    sleep 0.5
    touch "* marked:'Done'"
    sleep 0.5
    touch "* marked:'NEXT'"
    touch "* id:'birthControlQuestionButton'"
    touch "* marked:'None'"
    sleep 0.5
    touch "* marked:'DONE'"
  end

end