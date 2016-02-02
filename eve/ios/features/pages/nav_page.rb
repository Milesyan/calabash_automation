require 'calabash-cucumber/ibase'

class NavPage < Calabash::IBase
  def trait
    #"UITabBarButton"
    "*"
  end

  def open(tab_name)
    case tab_name.downcase
    when "home"
      wait_touch "UITabBarButtonLabel marked:'Home'"
    when "community"
      wait_touch "UITabBarButtonLabel marked:'Community'"
      sleep 1
      if element_exists  "* id:'gl-foundation-popup-close'"
        touch  "* id:'gl-foundation-popup-close'"
      end
    when "alert"
      wait_touch "UITabBarButtonLabel marked:'Alert'"
    when "me"
      wait_touch "UITabBarButtonLabel marked:'Me'"
    end
  end
end