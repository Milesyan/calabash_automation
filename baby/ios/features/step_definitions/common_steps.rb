Then(/^I logout$/) do
  app_page.open("Me")
  app_page.open_settings
  app_page.logout
end

Then(/^I touch "([^"]*)" (?:button|link)$/) do |arg1|
  sleep 1
  touch "* marked:'#{arg1}'"
  sleep 0.5
  touch "* marked:'#{arg1}'" if element_exists "* marked:'#{arg1}'"
end


Then(/^I login as the new user "([^"]*)" created through www$/) do |user1_name|
	log_important "Log in using #{user1_name}'s email and password: #{$user.email}, #{$user.password}" 
	app_page.login($user.email,$user.password)	
end



Then(/^I login as "([^"]*)"$/) do |arg1|
	app_page.login($user2.email,$user2.password)	
end

Given(/^I open "(.*?)" page$/) do |tab_name|
  app_page.open(tab_name)
end

