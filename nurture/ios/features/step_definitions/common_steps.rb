require 'calabash-cucumber/calabash_steps'


Then(/^I wait until I see "(.*?)"$/) do |text|
  wait_for(:timeout => 20, :retry_frequency => 2) do
    element_exists "* marked:'#{text}'"
  end
end


Then(/^I login as the new user "([^"]*)" created through www$/) do |user1_name|
	puts "Log in using #{user1_name}'s email and password: #{$user.email}, #{$user.password}" 
	app_page.login($user.email,$user.password)
  sleep 2
  app_page.finish_tutorial	
end

Then(/^I login as "([^"]*)"$/) do |arg1|
	puts "Log in as #{arg1}" + $user2.email, $user2.password 
	app_page.login($user2.email,$user2.password)	
  app_page.finish_tutorial
end


#OLD

Given(/^I touch "(.*?)" button$/) do |text|
  sleep 1
  touch "* marked:'#{text}'"
  sleep 0.5
  touch "* marked:'#{text}'" if element_exists "* marked:'#{text}'"
end

Then(/^I touch "(.*?)" link$/) do |text|
  sleep 1
  touch "* marked:'#{text}'"
  sleep 0.5
  touch "* marked:'#{text}'" if element_exists "* marked:'#{text}'"
end


Given(/^I get started$/) do
  app_page.get_started
end

Given(/^I open the login screen$/) do
  app_page.tap_login_link
end

Given(/^I complete the onboard steps$/) do
  app_page.step1
  app_page.step2
  app_page.step3
  sleep 3
end

Given(/^I open "(.*?)" page$/) do |name|
  app_page.open name
end

Then(/^I close the insights popup$/) do
  app_page.close_insights_popup
end

Then(/^I finish the tutorial$/) do
  app_page.finish_tutorial
end

Then(/^I logout$/) do
  app_page.open("Me")
  app_page.logout
end