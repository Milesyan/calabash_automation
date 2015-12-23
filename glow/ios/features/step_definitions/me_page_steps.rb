Then(/^I invite my male partner$/) do
  me_page.invite_partner
end

Given(/^I change to "(.*?)" status$/) do |status|
  me_page.change_status_to(status)
end

Given(/^I complete my health profile$/) do
  health_profile_page.complete_health_profile
end

Then(/^"(.*?)" screen in Help Center should be loaded fine$/) do |page_name|
  puts page_name
  case page_name.downcase
  when "faq", "web", "blog", "facebook", "twitter"
    wait_touch "* marked:'#{page_name}'"
    wait_for_elements_exist "* id:'browser-reload'"
  when "terms of service"
    wait_for_none_animating
    scroll_to_row_with_mark "Privacy policy"
    wait_for_none_animating
    wait_touch "* marked:'Terms of service'"
    wait_for_elements_exist "* id:'browser-reload'"
  when "privacy policy"
    wait_for_none_animating
    scroll_to_row_with_mark "Privacy policy"
    wait_for_none_animating
    wait_touch "* marked:'Privacy policy'"
    wait_for_elements_exist "* id:'browser-reload'"
  end
  sleep 1
  wait_touch "* id:'back'"
end

Given(/^I open "(.*?)" on Me page$/) do |page_name|
  case page_name.downcase
  when "health profile"
    me_page.open_health_profile
  when "help center"
    me_page.open_help_center
  end
end

When(/^my health profile should be "(.*?)"$/) do |percentage|
  assert_equal percentage, query("PersistentBackgroundLabel", :text).first
end

When(/^I open and check my health profile$/) do
  me_page.open_health_profile
  health_profile_page.back_to_me_page
end