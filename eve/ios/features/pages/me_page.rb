require 'calabash-cucumber/ibase'

class MePage < Calabash::IBase
  def trait
    "*"
  end

  def logout
    wait_touch "* marked:'Settings'"
    scroll_to_row_with_mark "Logout"
    wait_for_none_animating
    wait_touch "* marked:'Logout'"
    wait_for_element_exists "* marked:'Get it, Girl'"
  end
end