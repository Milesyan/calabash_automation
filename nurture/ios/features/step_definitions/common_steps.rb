require 'calabash-cucumber/calabash_steps'


Then(/^I wait until I see "(.*?)"$/) do |text|
  wait_for(:timeout => 20, :retry_frequency => 2) do
    element_exists "* marked:'#{text}'"
  end
end


Then(/^I login as the new user "([^"]*)" created through www$/) do |user1_name|
	logout_if_already_logged_in
	puts "Log in using #{user1_name}'s email and password: #{$user.email}, #{$user.password}" 
	common_page.login($user.email,$user.password)
  sleep 2
  common_page.finish_tutorial	
end

Then(/^I login as "([^"]*)"$/) do |arg1|
	logout_if_already_logged_in
	puts "Log in as #{arg1}" + $user2.email, $user2.password 
	common_page.login($user2.email,$user2.password)	
  common_page.finish_tutorial
end


#OLD

Given(/^I touch "(.*?)" button$/) do |text|
  wait_touch "* marked:'#{text}'"
end

Then(/^I touch "(.*?)" link$/) do |text|
  wait_touch "* marked:'#{text}'"
end


Given(/^I get started$/) do
  common_page.get_started
end

Given(/^I open the login screen$/) do
  common_page.tap_login_link
end

Given(/^I complete the onboard steps$/) do
  common_page.step1
  common_page.step2
  common_page.step3
  sleep 3
end

Given(/^I open "(.*?)" page$/) do |name|
  common_page.open name
end

Then(/^I close the insights popup$/) do
  common_page.close_insights_popup
end

Then(/^I finish the tutorial$/) do
  common_page.finish_tutorial
end

Then(/^I logout$/) do
  common_page.open("Me")
  common_page.logout
end