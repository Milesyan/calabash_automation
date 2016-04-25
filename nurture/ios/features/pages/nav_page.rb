require 'calabash-cucumber/ibase'

class NavPage < Calabash::IBase
  def trait
    #"UITabBarButton"
    "*"
  end

  def open(tab_name)
    sleep 1
    wait_touch "UITabBarButtonLabel marked:'#{tab_name}'"
    wait_for_none_animating
    case tab_name
    when "Me"
      touch_if_elements_exist "* id:'gl-foundation-popup-close'"
      touch "UITabBarButtonLabel marked:'Me'"
    end
  end
end