Given(/^I login$/) do
  logout_if_already_logged_in
  app_page.login_with $user.email, $user.password
end

Given(/^I logout$/) do
  app_page.open("me")
  app_page.logout
end

Then(/^I touch the "(.*?)" button$/) do |text|
  touch "* marked:'#{text}'"
end

Then(/^I login as the new user "([^"]*)" created through www$/) do |user1_name|
  logout_if_already_logged_in
  app_page.tap_login
  puts "Log in using #{user1_name}'s email and password: #{$user.email}, #{$user.password}" 
  app_page.login_with $user.email,$user.password
end

Then(/^I login as "([^"]*)"$/) do |arg1|
  logout_if_already_logged_in
  puts "Log in as #{arg1}; Email>>>#{$user2.email} Password>>>#{$user2.password }"
  app_page.tap_login
  app_page.login_with $user2.email,$user2.password
end

Given(/^I open "(.*?)" page$/) do |page|
  sleep 3
  app_page.open(page.downcase)
  sleep 1
end

Then(/^I check the text and click the buttons for this type of notification$/) do
  case $ntf_type
  when "1050","1085","1086","1087","1051","1053", "1059", "1060", "1088", "1089"
    puts "Touch Check it out"
    wait_touch "* marked:'Check it out'"
  when "1055"
    puts "Touch Take a look"
    wait_touch "* marked:'Check it out'"
  when ""
    puts "Touch Checkout out the results"
    wait_touch "* marked:'Check out the results'"
  when "1091"
    wait_touch "* marked:'You have a new follower!'"
  when "1092"
    sleep 10
  end
end

Then(/^I should see the page is navigating to the right page$/) do
  case $ntf_type
  when "1050", "1085", "1086", "1087","1051","1055", "1060", "1088", "1089"
    wait_for_element_exists "* marked:'notification_#{$ntf_type}'"
  when "1053","1059"
    wait_for_element_exists "* marked:'notification_#{$ntf_type}'" 
    wait_for_element_exists "* {text CONTAINS 'Reply_#{$ntf_type}'}"
  when "1091"
    wait_for_element_exists "* marked:'Follow'"
  end
end

Then(/^I go back to community page$/) do
  case $ntf_type
  when "1050", "1085", "1086", "1087","1051","1053","1055", "1059", "1060", "1088", "1089"
    forum_page.click_back_button
  when "1091", "1092"
    forum_page.click_back_button
  end
end
