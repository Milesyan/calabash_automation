
Given(/^I fill in email name password and birthday$/) do
  onboard_page.fill_in_email_password($user.email, $user.password)
end

Given(/^I close the onboarding popup$/) do
  sleep 2
  touch "* id:'close'" if element_exists "* id:'close'"
  sleep 1
end