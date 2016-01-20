require 'calabash-android/abase'

class NavbarPage < Calabash::ABase
  def trait
    "AppCompatImageView"
  end

  def open(tab_name)
    sleep 1
    i = ["home", "hommunity", "alert", "me", "more options"].find_index tab_name.downcase
    touch "android.support.v7.widget.AppCompatImageView index:#{i}"
  end

end