Given(/^I login$/) do
  logout_if_already_logged_in
  onboard_page.login($user.email, $user.password)
end

Given(/^I logout$/) do
  nav_page.open("me")
  me_page.logout
end