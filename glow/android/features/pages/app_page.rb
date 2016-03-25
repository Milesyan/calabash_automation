require 'calabash-android/abase'

class AppPage < Calabash::ABase
  def trait
    "* id:'sign_in_button'"
  end

  def login
    enter_text "* id:'email'", $user.email
    enter_text "* id:'password'", $user.password
    touch "* id:'sign_in_button'"
  end

  def login_with(email, password)
    enter_text "* id:'email'", email
    enter_text "* id:'password'", password
    sleep 1
    touch "* id:'sign_in_button'"
  end

  def open(page)
    sleep 1
    case page.downcase
    when 'home'
      touch "* id:'nav_home'"
    when 'community'
      touch "* id:'nav_community'"
    when 'genius'
      touch "* id:'nav_gg'"
    when 'alert'
      touch "* id:'nav_alert'"
    when 'me'
      touch "* id:'nav_me'"
    end
  end


  def tap_login
    puts "TOUCH LOGIN HERE "
    touch "* id:'log_in'"
  end

  def logout
    wait_for_element_exists "android.support.v7.widget.ActionMenuPresenter$OverflowMenuButton"
    menu_button = "android.support.v7.widget.ActionMenuPresenter$OverflowMenuButton"
    wait_for(:timeout => 10, :regry_frequency => 2) do
      element_exists menu_button
    end
    touch menu_button
    sleep 1
    touch "* text:'Log out'"
  end
  
  def forum_element
    wait_for_elements_exist "* marked:'Community'"
  end
end