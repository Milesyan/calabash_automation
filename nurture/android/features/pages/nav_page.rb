require 'calabash-android/abase'

class NavPage < Calabash::ABase
  def trait
    "*"
  end
#need rework in community v1.1
  # def open(tab_name)
  #   wait_for_element_exists "android.support.v7.widget.AppCompatImageView"
  # 	sleep 1
  #   i = ["home", "community", "alert", "me", "more options"].find_index tab_name.downcase
  #   touch "android.support.v7.widget.AppCompatImageView index:#{i}"
  # end

  # def logout
  # 	sleep 1
  #   touch "android.support.v7.widget.AppCompatImageView index:4"
  #   wait_for(:timeout => 10, :regry_frequency => 2) do
  #     element_exists "* marked:'Log out'"
  #   end
  #   touch "* marked:'Log out'"
  # end
  def open(tab_name)
    wait_for_element_exists "* id:'bottom_action_bar'"
    sleep 1
    case tab_name.downcase
    when "home"
      touch "* id:'nav_home'"
    when "community"
      touch "* id:'nav_community'"
    when "genius"
      touch "* id:'nav_gg'"
    when "alert"
      touch "* id:'nav_alert'"
    when "me"
      touch "* id:'nav_me'"
    end
  end

  def logout
    sleep 1
    touch "* id:'nav_me'"
    wait_touch "ActionMenuView"
    wait_for(:timeout => 10, :regry_frequency => 2) do
      element_exists "* marked:'Log out'"
    end
    touch "* marked:'Log out'"
  end

end