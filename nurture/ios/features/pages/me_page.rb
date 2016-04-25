require 'calabash-cucumber/ibase'

class MePage < Calabash::IBase
  def trait
    "*"
  end

  def logout
    scroll_to_row_with_mark "Account settings"
    wait_for_none_animating
    wait_touch "* marked:'Account settings'"
    scroll_to_row_with_mark "Logout"
    wait_for_none_animating
    wait_touch "* marked:'Logout'"
    sleep 2
    touch "* marked:'Yes, log out'"
    sleep 2
  end

  def try_glow_premium_for_free
    touch "* marked:'Try Glow Premium for FREE!'"
    wait_for_none_animating
    touch "* id:'sk-cross-close'"
  end

  def open_my_baby_profile
    touch "* marked:'My baby\\'s profile'"
    touch "* id:'back'"
  end

  def open_my_health_profile
    touch "* marked:'My health profile'"
    touch "* marked:'Back'"
  end

  def open_my_care_team_contacts
    touch "* marked:'My Care Team contacts'"
    wait_for_none_animating
    touch "* marked:'Back'"
  end

  def open_settings
    scroll_to_row_with_mark "Account settings"
    wait_for_none_animating
    touch "* marked:'Account settings'"
  end

  def invite_partner
    wait_for_none_animating
    touch "* id:'profile-addpartner'"
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