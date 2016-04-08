Then(/^I logout$/) do
  app_page.open("Me")
  app_page.open_settings
  app_page.logout
end

Given(/^I touch "(.*?)" button$/) do |text|
  wait_touch "* marked:'#{text}'"
end

Then(/^I touch "(.*?)" link$/) do |text|
  wait_touch "* marked:'#{text}'"
end

Then(/^I wait until I see "(.*?)"$/) do |text|
  wait_for(:timeout => 20, :retry_frequency => 2) do
    element_exists "* marked:'#{text}'"
  end
end



Given(/^I relaunch the app$/) do
  relaunch_app
end

Then(/^I login as the new user "([^"]*)" created through www$/) do |user1_name|
	logout_if_already_logged_in
	puts "Log in using #{user1_name}'s email and password: #{$user.email}, #{$user.password}" 
	app_page.login($user.email,$user.password)	
end



Then(/^I login as "([^"]*)"$/) do |arg1|
	logout_if_already_logged_in
	puts "Log in as #{arg1}" + $user2.email, $user2.password 
	app_page.login($user2.email,$user2.password)	
end

Given(/^I open "(.*?)" page$/) do |tab_name|
  app_page.open(tab_name)
end
