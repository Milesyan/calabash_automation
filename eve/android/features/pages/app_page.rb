require 'calabash-android/abase'

class AppPage < Calabash::ABase
  def trait
    "*"
  end

  def tap_login
    pass_sso
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
    $login_acc = email
    enter_text "* id:'email'", email
    enter_text "* id:'password'", password
    sleep 1
    touch "* id:'sign_in_button'"
    # bypass_eve
    wait_for_element_does_not_exist "* id:'sign_in_button'"
    sleep 1
    finish_tutorial
  end

  def open(tab_name)
    sleep 1
    i = ["home", "community", "alert", "me", "more options"].find_index tab_name.downcase
    touch "android.support.design.widget.ci index:#{i}"
  end

  def logout
    menu_button = "* marked:'More options'"
    wait_for(:timeout => 10, :regry_frequency => 2) do
      element_exists menu_button
    end
    sleep 1
    touch menu_button
    sleep 0.5
    touch "* text:'Log out'"
    $login_acc = nil
    wait_for(:timeout=>5) do
      element_exists("* id:'login'") || element_exists("* marked:' CLICK HERE TO SWITCH USER '")
    end
    sleep 0.5
  end
  
  def forum_element
    begin 
      wait_for(:timeout => 3) do
        elements_exist "ci"
      end
    rescue RuntimeError
      puts "EVE ANDROID tabbar element class wrong"
    end
  end
 
  def ntf_join_group
    wait_for_element_exists "* {text CONTAINS 'Join the group!'}"
    wait_touch "* {text CONTAINS 'Check it out'}"
    wait_touch "* marked:'Join group'"
    sleep 2
  end

  def pass_sso
    if element_exists "* {text CONTAINS 'Continue as'}"
      touch "* marked:' CLICK HERE TO SWITCH USER '"
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
    premium_page.pass_premium_promt
    sleep 0.5
    pass_eve_question
  end

  def pass_eve_question
    if element_exists "* text:'Did you start your new period?'"
      wait_touch "* marked:'NO'"
      wait_touch "* marked:'10 days'"
    end
  end
  
end