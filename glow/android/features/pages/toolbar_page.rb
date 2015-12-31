require 'calabash-android/abase'

class ToolbarPage < Calabash::ABase
  def trait
    #"* id:'profile_tool_bar'"
    "android.support.v7.widget.ActionMenuPresenter$OverflowMenuButton"
  end

  def logout
    #touch "* id:'home_tool_bar'"
    #press_menu_button
    sleep 2
    navbar_page.open "me"
    menu_button = "android.support.v7.widget.ActionMenuPresenter$OverflowMenuButton"
    wait_for(:timeout => 10, :regry_frequency => 2) do
      element_exists menu_button
    end
    touch menu_button
    touch "* text:'Log out'"
  end
end