require 'calabash-android/abase'

class MePage < Calabash::ABase
  def trait
    "* id:'profile_image'"
  end

  def invite_partner(partner_gender = "male")
    partner_name  =  partner_gender == "male" ? "Male" : "Female"
    if partner_gender == "male"
      $user.partner_email = $user.email.sub("@", "_mp@") 
    else
      $user.partner_email = $user.email.sub("@", "_fp@") 
    end
    
    scroll_to "* text:'Invite your partner'"
    touch "* marked:'Invite your partner'"

    enter_text "* id:'partner_name'",  partner_name
    enter_text "* id:'partner_email'", $user.partner_email
    touch "* marked:'Invite!'"
    puts $user.partner_email + " has been invited"
  end
end