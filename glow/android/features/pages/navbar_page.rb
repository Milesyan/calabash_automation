require 'calabash-android/abase'

class NavbarPage < Calabash::ABase
  def trait
    "* id:'nav_bar'"
  end

  def open(page)
    sleep 1
    case page.downcase
    when 'home'
      touch "* id:'nav_home'"
    when 'community'
      touch "* id:'nav_community'"
    when 'genius'
      touch "* id:'nav_gg'"
    when 'alert'
      touch "* id:'nav_alert'"
    when 'me'
      touch "* id:'nav_me'"
    end
  end

end