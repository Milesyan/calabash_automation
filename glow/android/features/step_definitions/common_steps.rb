Then(/^I touch the "(.*?)" button$/) do |text|
  touch "* marked:'#{text}'"
end

Given(/^I open "(.*?)" page$/) do |page|
  common_page.open(page.downcase)
  sleep 1
end


Given(/^I logout$/) do
  common_page.open "me"
  common_page.logout
end

Given(/^I login$/) do
  logout_if_already_logged_in
  common_page.tap_login
  common_page.login
end

Then(/^I login as the new user "([^"]*)" created through www$/) do |user1_name|
  logout_if_already_logged_in
  common_page.tap_login
  puts "Log in using #{user1_name}'s email and password: #{$user.email}, #{$user.password}" 
  common_page.login_with $user.email,$user.password
end



Then(/^I login as "([^"]*)"$/) do |arg1|
  logout_if_already_logged_in
  puts "Log in as #{arg1}; Email>>>#{$user2.email} Password>>>#{$user2.password }"
  common_page.tap_login
  common_page.login_with $user2.email,$user2.password
end






