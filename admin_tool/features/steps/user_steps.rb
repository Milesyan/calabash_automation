Given(/^I am Glow admin$/) do
  $user = User.new email: "linus@glowing.com", password: "Glow12345"
  logout_if_already_logged_in
end

Given(/^I login$/) do
  visit '/login'
  page.driver.browser.switch_to.alert.accept
  login_page.login($user.email, $user.password)
  sleep 1
end

Given(/^I open "([^"]*)"$/) do |page|
  nav_to page
  sleep 3
end

Given(/^I should see "([^"]*)"$/) do |text|
  expect(page).to have_text text
end

Then(/^I logout$/) do
  page.execute_script("angular.element('#header-navbar').scope().logout();")
  sleep 1
end

Then(/^I check the alerts queue$/) do
  click_on "Spam Queue"
  sleep 10
  expect(page.all('tbody').size).to be > 1
end
