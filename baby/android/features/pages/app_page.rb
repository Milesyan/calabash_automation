require 'calabash-android/abase'

class AppPage < Calabash::ABase
  def trait
    "*"
  end


  def tap_login
    pass_sso
    puts "TOUCH LOGIN HERE "
    touch "* marked:'Log in'"
  end

  def login
    enter_text "* id:'email'", $user.email
    enter_text "* id:'password'", $user.password
    sleep 1
    touch "* id:'action_login'"
  end

  def login_with(email, password)
    pass_sso
    touch "* marked:'Log in'"
    enter_text "* id:'email'", email
    enter_text "* id:'password'", password
    sleep 1
    touch "* id:'action_login'"
  end

  def pass_sso
    if element_exists "* {text CONTAINS 'Continue as'}"
      touch "* marked:'Sign up with another account'"
    end
  end

  def open(tab_name)
    sleep 1.5
    wait_for_element_exists "android.support.design.widget.TabLayout$TabView", :time_out => 10
    sleep 1.5
    i = ["home", "community", "alert", "me", "more options"].find_index tab_name.downcase
    if i ==4
      puts "i == 4"
      touch "* marked:'More options'"
    else 
      wait_touch "android.support.design.widget.TabLayout$TabView index:#{i}"
    end
    sleep 1
    if element_exists  "* id:'gl-foundation-popup-close'"
      touch "* id:'gl-foundation-popup-close'"
    end
    if element_exists "* marked:'Connect now!'"
      sleep 0.5
      touch "* marked:'Cancel'"
    end
  end

  def logout
    sleep 1
    touch "* marked:'More options'"
    wait_for(:timeout => 10, :regry_frequency => 2) do
      element_exists "* marked:'Log out'"
    end
    touch "* marked:'Log out'"
    wait_for_element_exists "* {text CONTAINS 'Log in'}"
  end

  def forum_element
    wait_for_elements_exist "AppCompatImageView index:0"
  end
  
  def ntf_join_group
    wait_for_element_exists "* {text CONTAINS 'Join the group!'}"
    wait_touch "* {text CONTAINS 'Check it out'}"
    wait_touch "* marked:'Join group'"
    sleep 2
  end

  def signup_flow
    pass_sso
    wait_touch "* marked:'Sign up!'"
  end


  def touch_terms
    x,y,width = forum_page.get_element_x_y 'terms'
    perform_action('touch_coordinate',(x+width*0.4), y+45)
  end

  def touch_privacy_policy
    x,y,width = forum_page.get_element_x_y 'terms'
    perform_action('touch_coordinate',(x+width*0.55), y+45)
  end

  def hint_section 
    wait_for_element_exists "* marked:'terms'"
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