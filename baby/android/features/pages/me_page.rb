require 'calabash-android/abase'

class MePage < Calabash::ABase
  def trait
    "*"
  end

  def logout
    nav_page.open "more options"
    touch "* marked:'Log out'"
  end
end