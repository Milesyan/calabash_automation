require 'calabash-android/abase'

class ToolbarPage < Calabash::ABase
  def trait
    #"* id:'profile_tool_bar'"
    "android.support.v7.widget.ActionMenuPresenter$OverflowMenuButton"
  end

  def logout
    #touch "* id:'home_tool_bar'"
    #press_menu_button
    sleep 1
    touch "android.support.v7.widget.ActionMenuPresenter$OverflowMenuButton"
    touch "* text:'Log out'"
  end
end