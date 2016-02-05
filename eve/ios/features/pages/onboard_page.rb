require 'calabash-cucumber/ibase'

class OnboardPage < Calabash::IBase
  def trait
    "*"
  end

  def tap_login_link
    wait_for_element_exists "* marked:'LOG\u2028IN'"
    touch "* marked:'LOG\u2028IN'"
    if element_does_not_exist "* marked:'Email'"
      wait_touch "* marked:'LOG\u2028IN'"
    end
    sleep 1
  end

  def get_started
    logout_if_already_logged_in
    wait_touch "* marked:'Get it, Girl'"
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