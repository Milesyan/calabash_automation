Given(/^I login$/) do
  app_page.login_with $user.email, $user.password
end

Given(/^I logout$/) do
  app_page.open("me")
  app_page.logout
end

Then(/^I touch the "(.*?)" button$/) do |text|
  sleep 1
  touch "* marked:'#{text}'"
  sleep 0.5
  touch "* marked:'#{text}'" if element_exists "* marked:'#{text}'"
end

Then(/^I login as the new user "([^"]*)" created through www$/) do |user1_name|
  app_page.tap_login
  puts "Log in using #{user1_name}'s email and password: #{$user.email}, #{$user.password}" 
  app_page.login_with $user.email,$user.password
end

Then(/^I login as "([^"]*)"$/) do |arg1|
  puts "Log in as #{arg1}; Email>>>#{$user2.email} Password>>>#{$user2.password }"
  app_page.tap_login
  app_page.login_with $user2.email,$user2.password
end

Given(/^I open "(.*?)" page$/) do |page|
  sleep 1
  app_page.open(page.downcase)
  sleep 0.5
end


