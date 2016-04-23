Given(/^I want to sign up$/) do
  logout_if_already_logged_in
  onboard_page.click_signup
end

Given(/^I check the terms are clickable$/) do
  onboard_page.click_terms
end

Given(/^I go back to onbording page$/) do
  onboard_page.go_back
end

Given(/^I check Privacy Policy clickable$/) do
  onboard_page.click_privacy_policy
end

Given(/^I close the page$/) do
  onboard_page.close_page
end