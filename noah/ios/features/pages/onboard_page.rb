require 'calabash-cucumber/ibase'

class OnboardPage < Calabash::IBase
  def trait
    "*"
  end

  def login(email, password)
    open_login_link
    wait_touch "* marked:'Email'"
    keyboard_enter_text email
    wait_touch "* marked:'Password'"
    keyboard_enter_text password
    # touch "* marked:'Next'"
    touch "* marked:'Log me in!' index:0"
    sleep 3
  end

  def open_login_link
    wait_touch "* marked:'Log in'"
  end

  def open_forgot_password
    wait_touch "* marked:'Forgot password'"
  end

  def input_email_password(email, password, full_name = "Glow iOS", is_partner = false)
    wait_touch "* marked:'First & Last name'"
    keyboard_enter_text full_name
    #unless is_partner
      wait_touch "UITextField index:1"
      #set_text "UITextField index:1", email
      keyboard_enter_text email
    #end

    wait_touch "UITextField index:2"
    keyboard_enter_text password
    wait_touch "UITextField index:3"
    wait_touch "* marked:'OK'"

    wait_touch "* marked:'Next'"
    wait_touch "label {text BEGINSWITH 'Yes'}"
    sleep 2
    wait_for_elements_do_not_exist("NetworkLoadingView", :timeout => 60)
  end



end