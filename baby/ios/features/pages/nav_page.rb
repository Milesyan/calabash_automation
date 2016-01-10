require 'calabash-cucumber/ibase'

class NavPage < Calabash::IBase
  def trait
    "UITabBar"
  end

  def open(tab_name)
    wait_touch "UITabBarButtonLabel marked:'#{tab_name.capitalize}'"
  end
end