require 'calabash-android/abase'

class MePage < Calabash::ABase
  def trait
    "*" 
    # "* id:'profile_image'"
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

  # Health Profile
  def open_health_profile
    touch "* id:'health_profile_completion_rate'"
  end

  def check_my_health_profile
    if $user.gender == "male"
      sleep 1
      assert_equal $user.gender, query("all * marked:'Gender' sibling all * id:'subtitle'", :text).first.downcase
      flick_up
      sleep 1
      assert_equal "94304", query("* marked:'Zipcode' sibling * id:'subtitle'", :text).first.downcase
      assert_equal "Employed", query("all * marked:'Occupation' sibling all * id:'subtitle'", :text).first
    else
      flick_up
      sleep 1
      assert_equal $user.gender, query("all * marked:'Gender' sibling all * id:'subtitle'", :text).first.downcase
      assert_equal "94304", query("* marked:'Zipcode' sibling * id:'subtitle'", :text).first.downcase
    end

  end

  def back_from_health_profile
    touch "android.widget.ImageButton contentDescription:'Navigate up'"
  end

  # Fertility Tests and Wrokup

  def open_fertility_tests
    touch "* marked:'Fertility testing and workup'"
  end

  def check_my_fertility_tests
    sleep 1
    assert_equal "doctor wei", query("all * marked:'Doctor' sibling all * id:'item_result'", :text).first.strip.downcase
    assert_equal "nurse li", query("all * marked:'Nurse' sibling all * id:'item_result'", :text).first.strip.downcase
    assert_equal "15.0 pg/ml", query("all * marked:'E2' sibling all * id:'item_result'", :text).first.strip.downcase
  end

  def back_from_fertility_tests
    touch "android.widget.ImageButton contentDescription:'Navigate up'"
  end

  def save_fertility_tests
    touch "* id:'save_results'"
  end

end