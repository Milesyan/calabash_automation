require 'calabash-android/abase'

class NavbarPage < Calabash::ABase
  def trait
    "by"
  end

  def open(tab_name)
    sleep 1
    i = ["home", "community", "alert", "me", "more options"].find_index tab_name.downcase
    touch "android.support.design.widget.by index:#{i}"
  end

end