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
