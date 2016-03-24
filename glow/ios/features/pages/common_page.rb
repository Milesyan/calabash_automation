require 'calabash-cucumber/ibase'

class CommonPage < Calabash::IBase
  def trait
    "*"
  end

  def login(email, password)
    open_login_link
    wait_touch "* marked:'Email'"
    keyboard_enter_text email
    wait_touch "* marked:'Password'"
    keyboard_enter_text password
    touch "* marked:'Next'"
    sleep 2
  end

  def dismiss_install_message
    if element_exists "* {text CONTAINS 'Congrats'}"
      puts "Add dismiss install"
    end
  end 

  def open_login_link 
    wait_touch "* marked:'Log in'"
    if element_does_not_exist "* marked:'Email'"
      wait_touch "* marked:'Log in'"
    end
  end

  def open_forgot_password
    wait_touch "* marked:'Forgot password'"
  end

  def input_email_password(email, password, full_name = "Glow iOS", is_partner = false)
    wait_touch "* marked:'First & Last name'"
    keyboard_enter_text full_name
    #unless is_partner
    wait_touch "UITextField index:1"
    #set_text "UITextField index:1", email
    keyboard_enter_text email
    #end

    wait_touch "UITextField index:2"
    keyboard_enter_text password
    wait_touch "UITextField index:3"
    wait_touch "* marked:'OK'"

    wait_touch "* marked:'Next'"
    wait_touch "label {text BEGINSWITH 'Yes'}"
    sleep 2
    wait_for_elements_do_not_exist("NetworkLoadingView", :timeout => 60)
  end

  def input_wrong_email_password
    wait_touch "label text:'Email'"
    keyboard_enter_text "doesnotexist@glowtest.com"
    wait_touch "label text:'Password'"
    keyboard_enter_text "123456"
    wait_touch "* marked:'Next'"
    wait_for_elements_do_not_exist("NetworkLoadingView", :timeout => 60)
  end

  def check_user_status(expected_status)
    if $user.instance_of? ForumUser
      wait_for timeout: 30, retry_frequency: 3 do
        $user.pull_content
        case expected_status.downcase
        when "ttc"
          0 == $user.res["user"]["settings"]["current_status"]
        when "non-ttc"
          3 == $user.res["user"]["settings"]["current_status"]
        when "pregnant"
          2 == $user.res["user"]["settings"]["current_status"]
        when "iui", "ivf", "med", "prep"
          4 == $user.res["user"]["settings"]["current_status"]
        end
      end
    end
  end


  def change_status_to(status)
    wait_touch "* marked:'Choose another status'"
    case status.downcase
    when "ttc"
      wait_touch "* marked:'Trying to conceive' sibling PillButton index:0"
      wait_for_none_animating
      common_page.choose_ttc_time
      common_page.choose_children_number
      wait_touch "* marked:'Next'"
      check_user_status "ttc"
    when "pregnant"
      wait_touch "* marked:'I\\'m pregnant' sibling PillButton index:0"
      sleep 1
      case $user.type.downcase
      when "non-ttc"
        wait_touch "* marked:'Yes, please'" 
        wait_touch "UINavigationItemButtonView"

      when "ttc"
        wait_touch "* marked:'Later'"
        sleep 2
        wait_touch "* id:'gl-foundation-popup-close'"
      end
      check_user_status "pregnant"
    when "non-ttc"
      wait_touch "* marked:'Avoiding pregnancy' sibling PillButton index:0"
      wait_for_none_animating
      $user.type = "non-ttc"
    when "prep"
      wait_touch "* marked:'Fertility treatments' sibling PillButton index:0"
      wait_for_none_animating
      $user.type = "prep"
      common_page.complete_ft_step1
      check_user_status "prep"
    when "med"
      wait_touch "* marked:'Fertility treatments' sibling PillButton index:0"
      wait_for_none_animating
      $user.type = "med"
      common_page.complete_ft_step1
      check_user_status "med"
    when "iui"
      wait_touch "* marked:'Fertility treatments' sibling PillButton index:0"
      wait_for_none_animating
      $user.type = "iui"
      common_page.complete_ft_step1
      check_user_status "iui"
    when "ivf"
      wait_touch "* marked:'Fertility treatments' sibling PillButton index:0"
      wait_for_none_animating
      $user.type = "ivf"
      common_page.complete_ft_step1
      check_user_status "ivf"
    end
  end

  def open_settings
    scroll_to_row_with_mark "Settings"
    sleep 1
    wait_touch "label marked:'Settings'"
  end

  def open_health_profile
    wait_touch "* marked:'Health profile'"
    sleep 1
  end

  def open_help_center
    scroll_to_row_with_mark "Settings"
    sleep 1
    wait_touch "label marked:'Help center'"
  end

  def invite_partner
    scroll_to_row_with_mark "Invite your partner"
    sleep 1
    wait_touch "label marked:'Invite your partner'"
    sleep 1
    tap_mark "Enter partner’s name"
    keyboard_enter_text "Male Partner"
    tap_mark "Invite your partner!"
    tap_mark "Enter partner’s email"
    $user.partner_email = $user.email.sub("@", "_partner@")
    keyboard_enter_text $user.partner_email
    tap_mark "Invite your partner!"
    tap_mark "Invite now"
    wait_for_elements_do_not_exist("* marked:'Invite now'", :timeout => 10)
    sleep 1
    puts $user.partner_email
  end

  def close_invite_partner_popup
    begin
      when_element_exists("* id:'gl-foundation-popup-close'", :timeout => 2)
    rescue Calabash::Cucumber::WaitHelpers::WaitError
      #puts "no invite partner popup"
    end
  end


  def logout
    scroll_to_row_with_mark "Logout"
    wait_touch "* marked:'Logout'"
    touch "* marked:'Logout'" # for some reason, have to touch Logout button twice since 5.2
    wait_touch "* marked:'Yes, log out'"
    wait_for_none_animating
    sleep 1
  end
  
  def open(tab_name)
    case tab_name.downcase
    when "home"
      wait_touch "UITabBarButtonLabel marked:'Home'"
    when "community"
      wait_touch "UITabBarButtonLabel marked:'Community'"
      sleep 1
      if element_exists  "* id:'gl-foundation-popup-close'"
        touch "* id:'gl-foundation-popup-close'"
      end
    when "genius"
      wait_touch "UITabBarButtonLabel marked:'Genius'"
    when "alert"
      wait_touch "UITabBarButtonLabel marked:'Alert'"
    when "me"
      wait_touch "UITabBarButtonLabel marked:'Me'"
      sleep 1
      if element_exists "* marked:'gl foundation popup close'"
        touch "* marked:'gl foundation popup close'"
      end
    end
  end

  def ntf_join_group
    wait_for_element_exists "* {text CONTAINS 'Check out the group'}"
    wait_touch "* {text CONTAINS 'Check out the group'}"
    wait_touch "* marked:'Join'"
    sleep 2
  end
end