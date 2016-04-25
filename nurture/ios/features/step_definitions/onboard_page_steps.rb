Given(/^I get started$/) do
  onboard_page.get_started
end

Given(/^I open the login scree$/) do
  onboard_page.tap_login_link
end

Given(/^I complete the onboard steps$/) do
  onboard_page.step1
  onboard_page.step2
  onboard_page.step3
  onboard_page.close_premium_popup
  sleep 3
end

Given(/^I input wrong email and password$/) do
  onboard_page.login("rachel_glow@yahoo.com", "wrong_password")
  sleep 2
  wait_for_none_animating
end

Given(/^I send the forgot password request$/) do
  wait_for_none_animating
  wait_touch "* marked:'Send'"
  sleep 2
end