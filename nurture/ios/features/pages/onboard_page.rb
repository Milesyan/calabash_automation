require 'calabash-cucumber/ibase'

class OnboardPage < Calabash::IBase
  def trait
    "*"
  end

  def tap_login_link
    sleep 1
    if element_exists "* {text CONTAINS 'Continue as'}"
      touch "* {text CONTAINS 'Click here'}"
    end
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
end