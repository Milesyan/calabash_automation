require 'calabash-cucumber/ibase'

class MePage < Calabash::IBase
  def trait
    "*"
  end

  def logout
    scroll_to_row_with_mark "Settings"
    wait_for_none_animating
    wait_touch "* marked:'Settings'"
    scroll_to_row_with_mark "Logout"
    wait_for_none_animating
    wait_touch "* marked:'Logout'"
    sleep 2
    touch "* marked:'Yes, log out'"
    sleep 2
  end

  def open_settings
    scroll_to_row_with_mark "Settings"
    wait_for_none_animating
    touch "* marked:'Settings'"
  end

  def invite_partner
    wait_for_none_animating
    touch "* marked:'Invite partner'"
    touch "* marked:'Enter partner\’s name'"
    keyboard_enter_text $user.partner_name
    tap_keyboard_action_key
    touch "* marked:'Enter partner\’s email'"
    keyboard_enter_text $user.partner_email
    tap_keyboard_action_key
    # wait_touch "* marked:'Invite now'"
    sleep 1
    wait_touch "* marked:'Back'"
  end

  def tap_partner_icon
    touch "* id:'profile-addpartner'"
  end

end