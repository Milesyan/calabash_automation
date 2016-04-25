require 'calabash-cucumber/ibase'

class OnboardPage < Calabash::IBase
  def trait
    "*"
  end

  def tap_login_link
    when_element_exists("* marked:'Log in with Glow account'", :timeout => 20)
    touch("* marked:'Log in with Glow account'", :offset => {:x => -50, :y => -10})
    sleep 1
  end

  def get_started
    logout_if_already_logged_in
    wait_touch "* marked:'Get Started!'"
  end

  def login(email, password)
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

  def close_premium_popup
    begin
      wait_for_element_exists("* id:'sk-cross-close'", :timeout => 8)
      touch "* id:'sk-cross-close'"
    rescue 
      puts "no premium popup"
    end
  end

  def choose_due_date
    wait_touch "* marked:'Do you know your due date?' sibling GLPillButton index:0" #Yes
    wait_touch "* marked:'Estimated due date' sibling GLPillButton index:0"
    wait_touch "* marked:'Done'"
  end

  def choose_how_to_get_pregnant
    wait_touch "* marked:'How did you get pregnant?' sibling GLPillButton"
    wait_touch "* marked:'Done'"
  end

  def choose_bmi
    touch "GLPillButton marked:'Weight'"
    wait_for_none_animating
    wait_touch "* marked:'Done'"
    touch "GLPillButton marked:'Height'"
    wait_for_none_animating
    wait_touch "* marked:'Done'"
  end

  def sign_up_partner
    touch "* marked:'Invited by your partner? Sign up here'", :offset => {x: 100, y:0}
    wait_for_none_animating
    wait_touch "* marked:'name@example.com'"
    keyboard_enter_text $user.email
    wait_touch "* marked:'6 characters minimum'"
    keyboard_enter_text $user.password
    touch "* marked:'Next'"
    sleep 2
  end
end