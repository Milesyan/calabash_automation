require 'calabash-android/abase'

class NavPage < Calabash::ABase
  def trait
    "* id:'tab'"
  end

  def open(tab_name)
  	sleep 1
    i = ["home", "community", "alert", "me", "more options"].find_index tab_name.downcase
    touch "android.support.v7.widget.AppCompatImageView index:#{i}"
  end
end