class SettingsPage < Calabash::IBase
  def trait
    "* id:'Settings'"
  end

  def logout
    scroll_to_row_with_mark "Logout"
    wait_touch "* marked:'Logout'"
    wait_for_none_animating
    sleep 1
  end
end