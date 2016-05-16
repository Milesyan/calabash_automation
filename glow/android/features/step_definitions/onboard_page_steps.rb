Given(/^I open Glow for the first time$/) do
  #
end

When(/^I login as the partner$/) do
  onboard_page.sign_up_partner
  puts $user.partner_email
end

When(/^I sign up as a single male user$/) do
  onboard_page.sign_up_single_male
  puts $user.email
end

Then(/^I select the user type "(.*?)"$/) do |user_type|
  onboard_page.select_user_type(user_type)
end

Given(/^I fill in email name password and birthday$/) do
  onboard_page.fill_in_email_password($user.email, $user.password)
end

Given(/^I complete Non\-TTC onboarding step (\d+)$/) do |step_number|
  case step_number
  when "1"
    onboard_page.non_ttc_onboard_step1
  when "2"
    onboard_page.non_ttc_onboard_step2
  end
end

Given(/^I complete TTC onboarding step (\d+)$/) do |step_number|
  case step_number
  when "1"
    onboard_page.ttc_onboard_step1
  when "2"
    onboard_page.ttc_onboard_step2
  end
end

Given(/^I complete Fertility Treatment onboarding step (\d+)$/) do |step_number|
  case step_number.to_s
  when "1"
    onboard_page.ft_onboard_step1
  when "2"
    onboard_page.ft_onboard_step2
  end
end

Given(/^I close the onboarding popup$/) do
  sleep 2
  touch "* id:'close'" if element_exists "* id:'close'" # close button is removed, so use press_back_button
  press_back_button
  sleep 1
end