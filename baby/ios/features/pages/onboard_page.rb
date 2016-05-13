require 'calabash-cucumber/ibase'

class OnboardPage < Calabash::IBase
  def trait
    "*"
  end

  def signup
    wait_touch "* marked:'Sign up!'"
    wait_touch "UITextFieldLabel marked:'Your Name'"
    keyboard_enter_text $user.first_name + " " + $user.last_name
    wait_touch "UITextFieldLabel marked:'MM/DD/YYYY'"
    picker_set_date_time $user.birthday.to_datetime
    wait_touch "* marked:'Done'"
    wait_touch "UITextFieldLabel marked:'email@domain.com'"
    keyboard_enter_text $user.email
    wait_touch "UITextFieldLabel marked:'6 characters'"
    keyboard_enter_text $user.password
    tap_keyboard_action_key # to toggle keyboard on small screens like iPhone 5
    wait_touch "* marked:'Sign me up!'"
    sleep 1
    wait_for_none_animating
    puts "#{$user.email} has been signed up!"
  end

  def login(email, password)
    wait_touch "* marked:'Log in'"
    wait_touch "* marked:'Email'"
    keyboard_enter_text email
    wait_touch "* marked:'Password'"
    keyboard_enter_text password
    wait_touch "* marked:'Log me in!'"
    wait_touch "* id:'sk-cross-close'"
  end

  def login_with_no_baby(email, password)
    wait_touch "* marked:'Log in'"
    wait_touch "* marked:'Email'"
    keyboard_enter_text email
    wait_touch "* marked:'Password'"
    keyboard_enter_text password
    wait_touch "* marked:'Log me in!'"
  end

  def click_signup
    wait_touch "* marked:'Sign up!'"
  end

  def click_terms
    touch :x =>100, :y =>590
    puts "Terms clickable"
    sleep 10
  end

  def click_privacy_policy
    touch :x =>180, :y =>590
    puts "Privacy Policy clickable"
    sleep 10
  end

  def close_page
    wait_touch "* marked:'gl foundation back'"
  end

  def go_back_onboarding

  end

  def close_premium_introdution
    sleep 2
    wait_touch "* id:'sk-cross-close'"
  end
end