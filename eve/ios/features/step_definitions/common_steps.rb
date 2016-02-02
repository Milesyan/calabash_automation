require 'calabash-cucumber/calabash_steps'


Then(/^I wait until I see "(.*?)"$/) do |text|
  wait_for(:timeout => 20, :retry_frequency => 2) do
    element_exists "* marked:'#{text}'"
  end
end


Then(/^I login as the new user "([^"]*)" created through www$/) do |user1_name|
	logout_if_already_logged_in
	puts "Log in using #{user1_name}'s email and password: #{$user.email}, #{$user.password}" 
	onboard_page.login($user.email,$user.password)
end

Then(/^I login as "([^"]*)"$/) do |arg1|
	logout_if_already_logged_in
	puts "Log in as #{arg1}" + $user2.email, $user2.password 
	onboard_page.login($user2.email,$user2.password)	
end


#OLD

Given(/^I touch "(.*?)" button$/) do |text|
  wait_touch "* marked:'#{text}'"
end

Then(/^I touch "(.*?)" link$/) do |text|
  wait_touch "* marked:'#{text}'"
end


Given(/^I get started$/) do
  onboard_page.get_started
end

Given(/^I open the login screen$/) do
  onboard_page.tap_login_link
end

Given(/^I open "(.*?)" page$/) do |name|
  nav_page.open name
end


Then(/^I logout$/) do
  nav_page.open("Me")
  me_page.logout
end