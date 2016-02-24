require 'calabash-cucumber/ibase'

class OnboardPage < Calabash::IBase
  def trait
    "*"
  end

  def input_url_in_profile_page
    URL = "https://www.google.com"
    wait_touch "UITextFieldLabel marked:'Link'"
    keyboard_enter_text URL
  end

  def check_url
    wait_for_element_exists "* {text CONTAINS '#{URL}'", :time_out =>3
    touch "* {text CONTAINS '#{URL}'"
  end

  def back_from_web_page
    wait_touch "* id:'gl-foundation-back'"
  end

  def switch_chat_option
    forum_page.scroll_down_to_see "Turn off Chat"
    wait_touch "UISwitch marked:'Turn off Chat'"
  end

  def switch_signature_option
    forum_page.scroll_down_to_see "Turn off Signature"
    wait_touch "UISwitch marked:'Turn off Signature'"
  end

  def update_bio_location
    forum_page.edit_text_fields "Shanghai", "Edit Shanghai"
    wait_touch "UILabel marked:'Bio'"
    keyboard_enter_text "testbio"
  end









end