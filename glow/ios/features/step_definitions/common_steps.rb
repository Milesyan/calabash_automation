Then(/^I logout$/) do
  app_page.open("Me")
  app_page.open_settings
  app_page.logout
end

Given(/^I touch "(.*?)" button$/) do |text|
  sleep 1
  wait_touch "* marked:'#{text}'"
  sleep 0.5
end

Then(/^I touch "(.*?)" link$/) do |text|
  sleep 1
  touch "* marked:'#{text}'"
  sleep 0.5
  touch "* marked:'#{text}'" if element_exists "* marked:'#{text}'"
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
	puts "Log in using #{user1_name}'s email and password: #{$user.email}, #{$user.password}" 
	app_page.login($user.email,$user.password)	
end



Then(/^I login as "([^"]*)"$/) do |arg1|
	puts "Log in as #{arg1}" + $user2.email, $user2.password 
	app_page.login($user2.email,$user2.password)	
end

Given(/^I open "(.*?)" page$/) do |tab_name|
  app_page.open(tab_name)
end
