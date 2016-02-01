require 'calabash-cucumber/ibase'

class MePage < Calabash::IBase
  def trait
    "*"
  end

  def logout
    scroll_to_row_with_mark "Settings"
    wait_for_none_animating
    wait_touch "* marked:'Settings'"
    scroll_to_row_with_mark "Logout"
    wait_for_none_animating
    wait_touch "* marked:'Logout'"
    sleep 2
    touch "* marked:'Yes, log out'"
    sleep 2
  end
end