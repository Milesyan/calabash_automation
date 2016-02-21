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
    logout_if_already_logged_in
    tap_login_link
    wait_for_none_animating
    wait_touch "* marked:'Email'"
    keyboard_enter_text email
    wait_touch "* marked:'Password'"
    keyboard_enter_text password
    touch "UINavigationButton marked:'Next'"
    wait_for_none_animating
    sleep 1
    if element_exists "* marked:'Get it, Girl'"
      bypass_temp
    end
  end

  def logout_if_already_logged_in
    if element_does_not_exist "* marked:'LOG\u2028IN'"
      nav_page.open("me")
      me_page.logout
    end
  end
  
  def bypass_temp
    wait_touch "* marked:'Get it, Girl'"
    wait_touch "* {text CONTAINS 'days'}"
    wait_touch "* {text CONTAINS '28'}"
    wait_touch "* {text CONTAINS 'Done'}"
    wait_touch "* {text CONTAINS 'Next'}"
    wait_touch "* {text CONTAINS 'm/d/y'}"
    wait_touch "* {text CONTAINS 'Today'}"
    sleep 1
    wait_touch "UIButtonLabel {text CONTAINS 'Done'}"
    wait_touch "* {text CONTAINS 'Next'}"
    wait_touch "* {text CONTAINS 'Choose'}"
    wait_touch "* {text CONTAINS 'None'}"
    wait_touch "* {text CONTAINS 'Done'} index:1"
    wait_touch "* {text CONTAINS 'Done'} index:0"
  end


end