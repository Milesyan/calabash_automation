require 'calabash-android/abase'

class MePage < Calabash::ABase
  def trait
    "* marked:'Glow Blog'"
  end

  def logout
    nav_page.open "more options"
    wait_for_element_exists "* marked:'Log out'"
    touch "* marked:'Log out'"
  end
end