require 'calabash-cucumber/ibase'
class TabBarPage < Calabash::IBase
  def trait
    "UITabBar"
  end

  def open(tab_name)
    case tab_name.downcase
    when "home"
      wait_touch "UITabBarButtonLabel marked:'Home'"
    when "community"
      wait_touch "UITabBarButtonLabel marked:'Community'"
      sleep 1
      get_started_popup = "* id:'gl-foundation-popup-close'"
      wait_touch get_started_popup if element_exists get_started_popup
    when "alert"
      wait_touch "UITabBarButtonLabel marked:'Alert'"
    when "me"
      wait_touch "UITabBarButtonLabel marked:'More'"
    end
  end
end