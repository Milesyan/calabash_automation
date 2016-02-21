require 'calabash-cucumber/ibase'

class NavPage < Calabash::IBase
  def trait
    #"UITabBarButton"
    "*"
  end

  def open(tab_name)
    case tab_name.downcase
    when "home"
      wait_touch "UITabBarButton marked:'Home'"
    when "community"
      wait_touch "UITabBarButtonLabel marked:'Community'"
      if element_does_not_exist "* marked:'New'"
        wait_touch "UITabBarButtonLabel marked:'Community'"
      end
      sleep 1
      if element_exists  "* id:'gl-foundation-popup-close'"
        touch "* id:'gl-foundation-popup-close'"
      end
    when "alert"
      wait_touch "UITabBarButtonLabel marked:'Alert'"
      if element_does_not_exist "* marked:'Notifications'"
        wait_touch "UITabBarButtonLabel marked:'Alert'"
      end
    when "me"
      wait_touch "UITabBarButton marked:'Me'"
    end
  end
end