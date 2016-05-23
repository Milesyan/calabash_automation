Given(/^I login$/) do
  logout_if_already_logged_in
  onboard_page.login($user.email, $user.password)
end

Given(/^I logout$/) do
  me_page.logout
end

Given(/^I touch "([^"]*)" button$/) do |text|
  touch "* marked:'#{text}'"
end

And(/^I close premium introduction pop up$/) do
  onboard_page.close_premium_introdution
end

Given(/^I login with no baby$/) do
  logout_if_already_logged_in
  onboard_page.login_with_no_baby($user.email, $user.password)
end