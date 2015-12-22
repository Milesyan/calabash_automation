class SettingsPage < Calabash::IBase
  def trait
    "* id:'Settings'"
  end

  def logout
    scroll_to_row_with_mark "Logout"
    wait_touch "* marked:'Logout'"
    touch "* marked:'Logout'" # for some reason, have to touch Logout button twice since 5.2
    wait_touch "* marked:'Yes, log out'"
    wait_for_none_animating
    sleep 1
  end
end