Given(/^I am a new user$/) do
  create_user
end

Given(/^I am an existing user "(.*?)"$/) do |email|
  fetch_user_by_email email
end

Given(/^I register a new pregnant user$/) do
  create_user
  sign_up_user
  home_page.close_insights_popup
  home_page.finish_tutorial
end

Given(/^I sign up as a partner$/) do
  onboard_page.sign_up_partner
end

Given(/^I login$/) do
  close_premium_popup_if_necessary
  finish_tutorial_if_necessary
  logout_if_already_logged_in

  onboard_page.tap_login_link
  onboard_page.login $user.email, $user.password

  close_premium_popup_if_necessary
  finish_tutorial_if_necessary
end

