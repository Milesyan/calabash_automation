require 'calabash-cucumber/ibase'

class MePage < Calabash::IBase
  def trait
    "*"
  end

  def logout
    wait_for_none_animating
    if element_exists "* marked:'Invite your partner!'"
      wait_touch "* id:'gl-foundation-popup-close'"
    end
    scroll_to_row_with_mark "Settings"
    wait_for_none_animating
    wait_touch "* marked:'Settings'"
    scroll_to_row_with_mark "Logout"
    wait_for_none_animating
    sleep 0.5
    wait_touch "* marked:'Logout'"
    sleep 1
    touch "* marked:'Yes, log out'"
    wait_for_element_does_not_exist "* marked:'Yes, log out'"
    sleep 0.5
  end
end