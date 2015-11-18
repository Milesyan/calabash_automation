Given(/^I open Glow for the first time$/) do
end

When(/^I sign up as a single male user$/) do
  onboard_page.sign_up_single_male
  puts $user.email
end

Then(/^I select the user type "(.*?)"$/) do |user_type|
  onboard_page.select_user_type(user_type)
end

Given(/^I fill in email name password and birthday$/) do
  onboard_page.input_email_password($user.email, $user.password)
end

Given(/^I input wrong email and password$/) do
  onboard_page.input_wrong_email_password
end

Then(/^I input my email "(.*?)" and send$/) do |email|
  keyboard_enter_text email
  wait_touch "* marked:'Send'"
  sleep 2
end

Given(/^I open the login screen$/) do
  logout_if_already_logged_in
  onboard_page.open_login_link
end

Then(/^I open forgot password screen$/) do
  onboard_page.open_forgot_password
end

Given(/^I complete Non\-TTC onboarding step (\d+)$/) do |step_number|
  case step_number
  when "1"
    onboard_page.complete_non_ttc_step1
  when "2"
    onboard_page.complete_non_ttc_step2
  end
end

Given(/^I complete TTC onboarding step (\d+)$/) do |step_number|
  case step_number
  when "1"
    onboard_page.complete_ttc_step1
  when "2"
    onboard_page.complete_ttc_step2
  end
end

Given(/^I complete Fertility Treatment onboarding step (\d+)$/) do |step_number|
  case step_number
  when "1"
    onboard_page.complete_ft_step1
  when "2"
    onboard_page.complete_ft_step2
  when "3"
    onboard_page.complete_ft_step3
  end
end

Given(/^I choose "(.*?)" status for fertility treatment$/) do |status|
  onboard_page.complete_ft_step1(status)
end

Then(/^I login as the partner$/) do
  onboard_page.sign_up_partner
end

Given(/^I close the onboarding popup$/) do
  tap_when_element_exists "* id:'close'"
end