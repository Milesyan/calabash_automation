require 'calabash-cucumber/ibase'

class HomePage < Calabash::IBase
  def trait
    "*"
  end

  def touch_later_link
    begin
      when_element_exists("* marked:'Later'", :timeout => 3)
    rescue Calabash::Cucumber::WaitHelpers::WaitError
    end
  end


  def finish_tutorial_via_www
    sleep 2
    NoahUser.new(email: $user.email, password: $user.password).logintouch
  end

  def finish_tutorial_for_partner_via_www
    sleep 2
    NoahUser.new(email: $user.partner_email, password: $user.password).logintouch
  end

  

  def keyboard_input(n)
    wait_touch "UIKBKeyView index:#{n}"
  end

