require 'calabash-cucumber/ibase'
class MePage < Calabash::IBase
  def trait
    #"* marked:'Choose another status'"
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
    when "pregnant"
      wait_touch "* marked:'I\\'m pregnant' sibling PillButton index:0"
      sleep 1
      case $user.type
      when "non-ttc"
        wait_touch "* marked:'Yes, please'" 
        wait_touch "UINavigationItemButtonView"
      when "ttc"
        wait_touch "* marked:'Later'"
        sleep 2
        wait_touch "* id:'gl-foundation-popup-close'"
      end
    when "non-ttc"
      wait_touch "* marked:'Avoiding pregnancy' sibling PillButton index:0"
      wait_for_none_animating
    when "prep"
      wait_touch "* marked:'Fertility treatments' sibling PillButton index:0"
      wait_for_none_animating
      $user.type = "ft"
      $user.treatment_type = "prep"
      onboard_page.complete_ft_step1
      #onboard_page.complete_ft_step2
    when "med"
      wait_touch "* marked:'Fertility treatments' sibling PillButton index:0"
      wait_for_none_animating
      $user.type = "ft"
      $user.treatment_type = "med"
      onboard_page.complete_ft_step1
      #onboard_page.complete_ft_step2
    when "iui"
      wait_touch "* marked:'Fertility treatments' sibling PillButton index:0"
      wait_for_none_animating
      $user.type = "ft"
      $user.treatment_type = "iui"
      onboard_page.complete_ft_step1
      #onboard_page.complete_ft_step2
    when "ivf"
      wait_touch "* marked:'Fertility treatments' sibling PillButton index:0"
      wait_for_none_animating
      $user.type = "ft"
      $user.treatment_type = "ivf"
      onboard_page.complete_ft_step1
      #onboard_page.complete_ft_step2
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

    sleep 3
    # wait_for(:timeout => 20, :retry_frequency => 0.3) do
    #   element_exists("* marked:'Invitation sent!'") or element_exists("label text:'Failed to invite partner'")
    # end
    puts $user.partner_email
  end

  def await
    wait_for(:timeout => 10, :retry_frequency => 2) do
      tab_bar_page.open "me"
      element_exists "* marked:'Choose another status'"
      element_exists "* marked:'Health profile'"
    end
    self
  end
end