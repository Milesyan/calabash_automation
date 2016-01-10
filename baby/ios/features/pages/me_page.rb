require 'calabash-cucumber/ibase'

class MePage < Calabash::IBase
  def trait
    "*"
  end

  def logout
    until_element_exists "* marked:'Account settings'", action: lambda { scroll "scrollView", :down }
    wait_touch "* marked:'Account settings'"
    wait_touch "* marked:'Logout'"
  end
end