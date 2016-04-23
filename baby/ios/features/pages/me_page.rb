require 'calabash-cucumber/ibase'

class MePage < Calabash::IBase
  def trait
    "*"
  end

  def leave_baby
    until_element_exists "* marked: 'Logout'", action: lambda { scroll "scrollView index:0", :down }
    wait_touch "* marked:'  Leave this baby'"
    wait_touch "* marked:'Leave this baby'"
    sleep 1
  end

  def logout
    close_invite_partner_popup
    close_premium_multiple_caregivers_popup
    until_element_exists "* marked:'Account settings'", action: lambda { scroll "scrollView", :down }
    wait_touch "* marked:'Account settings'"
    until_element_exists "* marked:'Logout'", action: lambda { scroll "scrollView", :down }
    logger.add event_name: "button_click_settings_logout"
    wait_touch "* marked:'Logout'"
  end

  def close_invite_partner_popup
    sleep 1
    touch "* id:'gl-foundation-popup-close'" if element_exists "* id:'gl-foundation-popup-close'"
  end

  def close_premium_multiple_caregivers_popup
    sleep 2
    touch "UIImageView marked:'cross-close'" if element_exists "UIImageView marked:'cross-close'"
  end

  def close_baby_profile
    wait_touch "* marked:'icon-close'"
  end

end