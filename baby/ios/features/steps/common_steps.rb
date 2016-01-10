Given(/^I touch "([^"]*)" button$/) do |text|
  touch "* marked:'#{text}'"
end

Given(/^I login$/) do
  logout_if_already_logged_in
  onboard_page.login($user.email, $user.password)
end

And(/^I logout$/) do
  nav_page.open("me")
  me_page.logout
end