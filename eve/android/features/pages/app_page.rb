require 'calabash-android/abase'

class AppPage < Calabash::ABase
  def trait
    "*"
  end

  def tap_login
    puts "TOUCH LOGIN HERE "
    touch "* id:'login'"
  end

  def login
    enter_text "* id:'email'", $user.email
    enter_text "* id:'password'", $user.password
    touch "* id:'sign_in_button'"
    bypass_eve
  end

  def login_with(email, password)
    enter_text "* id:'email'", email
    enter_text "* id:'password'", password
    sleep 1
    touch "* id:'sign_in_button'"
    # bypass_eve
    wait_for_element_does_not_exist "* id:'sign_in_button'"
    sleep 2
    if element_exists "* {text CONTAINS 'Did you start your new'}"
      touch "* marked:'YES'"
      touch "* marked:'Done'"
    end
  end

  def open(tab_name)
    sleep 1
    i = ["home", "community", "alert", "me", "more options"].find_index tab_name.downcase
    touch "android.support.design.widget.by index:#{i}"
  end

  def logout
    menu_button = "android.support.v7.widget.f"
    wait_for(:timeout => 10, :regry_frequency => 2) do
      element_exists menu_button
    end
    sleep 1
    touch menu_button
    sleep 0.5
    touch "* text:'Log out'"
    wait_for_element_exists "* id:'login'"
    sleep 0.5
  end
  
  def forum_element
    wait_for_elements_exist "by"
  end
  # def bypass_eve
  #   wait_touch "* id:'cycleDaysQuestionButton'"
  #   sleep 0.5
  #   touch "* marked:'25 days'"
  #   sleep 0.5
  #   touch "* marked:'NEXT'"
  #   sleep 0.5
  #   touch "* id:'lastPeriodStartQuestionButton'"
  #   sleep 0.3
  #   touch "* marked:'14'"
  #   sleep 0.5
  #   touch "* marked:'Done'"
  #   sleep 0.5
  #   touch "* marked:'NEXT'"
  #   touch "* id:'birthControlQuestionButton'"
  #   touch "* marked:'None'"
  #   sleep 0.5
  #   touch "* marked:'DONE'"
  #   sleep 0.5
  #   touch "* contentDescription:'Navigate up'"
  # end
  def ntf_join_group
    wait_for_element_exists "* {text CONTAINS 'Join the group!'}"
    wait_touch "* {text CONTAINS 'Check it out'}"
    wait_touch "* marked:'Join group'"
    sleep 2
  end

  def pass_sso
    if element_exists "* {text CONTAINS 'Continue as'}"
      touch "* marked:'Sign up with another account'"
    end
  end

  def signup_flow
    pass_sso
  end

  def touch_terms
    x,y,width = forum_page.get_element_x_y 'termsAndPolicy'
    perform_action('touch_coordinate',(x+width*0.6), y+10)
  end

  def touch_privacy_policy
    x,y,width = forum_page.get_element_x_y 'termsAndPolicy'
    perform_action('touch_coordinate',(x+width*0.85), y+10)
  end

  def hint_section 
    wait_for_element_exists "* marked:'termsAndPolicy'"
  end
  
  def finish_tutorial
    pass_premium_promt
  end

  def pass_premium_promt
    if element_exists "* marked:'Unlock now!'"
      touch "* marked:'Continue for free'"
      sleep 2
    end
  end
end