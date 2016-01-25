require 'calabash-cucumber/ibase'

class MePage < Calabash::IBase
  def trait
    "*"
  end

  def leave_baby
    until_element_exists "* marked: 'FAMILY MEMBERS'", action: lambda { scroll "scrollView index:0", :down }
    wait_touch "* marked:'  Leave this baby'"
    wait_touch "* marked:'Disconnect'"
    sleep 1
  end

  def logout
    until_element_exists "* marked:'Account settings'", action: lambda { scroll "scrollView", :down }
    wait_touch "* marked:'Account settings'"
    wait_touch "* marked:'Logout'"
  end
end