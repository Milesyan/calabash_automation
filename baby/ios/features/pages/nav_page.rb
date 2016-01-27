require 'calabash-cucumber/ibase'

class NavPage < Calabash::IBase
  def trait
    "UITabBar"
  end

  def open(tab_name)
    event_name = tab_name
    event_name = "me" if tab_name.downcase == "more"
    logger.add event_name: "button_click_tabbar_#{event_name.downcase}"
    wait_touch "UITabBarButtonLabel marked:'#{tab_name.capitalize}'"
    logger.add event_name: "page_impression_#{event_name.downcase}"
  end
end