require 'calabash-cucumber/ibase'

class OnboardPage < Calabash::IBase
  def trait
    "*"
  end

  def tap_login_link
    wait_for_element_exists("* marked:'Log in with Glow account'", :timeout => 20)
    touch("* marked:'Log in with Glow account'", :offset => {:x => -50, :y => -10})
    sleep 1
  end

  def get_started
    logout_if_already_logged_in
    wait_touch "* marked:'Get Started!'"
  end

  def login(email, password)
    tap_login_link
    wait_for_none_animating
    wait_touch "* marked:'Email'"
    keyboard_enter_text email
    wait_touch "* marked:'Password'"
    keyboard_enter_text password
    touch "UINavigationButton marked:'Next'"
  end

  def step1
    wait_touch "* marked:'Choose'"
    wait_for_none_animating
    wait_touch "* marked:'Done'"
    choose_due_date
    touch "* marked:'Next'"
  end

  def step2
    choose_how_to_get_pregnant
    choose_bmi
    touch "* marked:'Next'"
  end

  def step3
    wait_touch "* marked:'First & Last name'"
    keyboard_enter_text $user.first_name
    wait_touch "* marked:'name@example.com'"
    keyboard_enter_text $user.email
    wait_touch "* marked:'6 characters minimum'"
    keyboard_enter_text $user.password
    wait_touch "* marked:'Required'"
    wait_touch "* marked:'Done'"
    touch "* marked:'Next'"
    sleep 1
  end
end