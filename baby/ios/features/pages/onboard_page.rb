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
    puts "#{$user.email} has been signed up"
  end

  def login(email, password)
    wait_touch "* marked:'Log in'"
    wait_touch "* marked:'Email'"
    keyboard_enter_text email
    wait_touch "* marked:'Password'"
    keyboard_enter_text password
    wait_touch "* marked:'Log me in!'"
  end
end