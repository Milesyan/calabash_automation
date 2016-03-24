require 'calabash-cucumber/ibase'
class MePage < Calabash::IBase

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

  def trait
    "* marked:'Health profile'"
  end

  def change_status_to(status)
    wait_touch "* marked:'Choose another status'"
    case status.downcase
    when "ttc"
      wait_touch "* marked:'Trying to conceive' sibling PillButton index:0"
      wait_for_none_animating
      onboard_page.choose_ttc_time
      onboard_page.choose_children_number
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
      onboard_page.complete_ft_step1
      check_user_status "prep"
    when "med"
      wait_touch "* marked:'Fertility treatments' sibling PillButton index:0"
      wait_for_none_animating
      $user.type = "med"
      onboard_page.complete_ft_step1
      check_user_status "med"
    when "iui"
      wait_touch "* marked:'Fertility treatments' sibling PillButton index:0"
      wait_for_none_animating
      $user.type = "iui"
      onboard_page.complete_ft_step1
      check_user_status "iui"
    when "ivf"
      wait_touch "* marked:'Fertility treatments' sibling PillButton index:0"
      wait_for_none_animating
      $user.type = "ivf"
      onboard_page.complete_ft_step1
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

  def await
    wait_for(:timeout => 10, :retry_frequency => 2) do
      close_invite_partner_popup
      tab_bar_page.open "me"
      element_exists "* marked:'Choose another status'"
      element_exists "* marked:'Health profile'"
    end
    self
  end
end