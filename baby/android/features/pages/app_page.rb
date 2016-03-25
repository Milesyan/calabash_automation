require 'calabash-android/abase'

class AppPage < Calabash::ABase
  def trait
    "*"
  end


  def tap_login
    puts "TOUCH LOGIN HERE "
    touch "* marked:'Log in'"
  end

  def login
    enter_text "* id:'email'", $user.email
    enter_text "* id:'password'", $user.password
    touch "* id:'action_login'"
  end

  def login_with(email, password)
    touch "* marked:'Log in'"
    enter_text "* id:'email'", email
    enter_text "* id:'password'", password
    sleep 1
    touch "* id:'action_login'"
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
      touch "android.support.design.widget.TabLayout$TabView index:#{i}"
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
  # def login(email, password)
  #   touch "* marked:'Log in'"
  #   enter_text "* id:'email'", email
  #   enter_text "* id:'password'", password
  #   touch "* id:'action_login'"
  # end
end