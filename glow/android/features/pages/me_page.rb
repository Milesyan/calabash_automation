require 'calabash-android/abase'

class MePage < Calabash::ABase
  def trait
    "* id:'nav_me' * enabled:'false'"
  end

  def invite_partner
    $user.partner_email = $user.email.sub("@", "_partner@")
    
    scroll_to "* text:'Invite your partner'"
    touch "* marked:'Invite your partner'"

    enter_text "* id:'partner_name'",  "Male Partner"
    enter_text "* id:'partner_email'", $user.partner_email
    touch "* marked:'Invite!'"
  end
end