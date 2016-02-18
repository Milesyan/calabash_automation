require 'calabash-android/abase'

class NavPage < Calabash::ABase
  def trait
    "android.support.design.widget.TabLayout id:'tab'"
  end

  def open(tab_name)
    if tab_name.downcase == "more options"
      touch "android.support.v7.widget.ActionMenuPresenter$OverflowMenuButton"
    else
      i = ["home", "hommunity", "alert", "me"].find_index tab_name.downcase
      touch "android.support.design.widget.TabLayout$TabView index:#{i}"
    end
  end
end