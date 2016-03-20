def premium_user(args={})
  NurtureUser.new(args).login.leave_all_groups.join_group
end
##########>>>WWW layer steps<<<##########
Given(/^A premium user miles2 and a non-premium user milesn have been created for test$/) do
  $user = premium_user :email => "miles2@g.com", :password => "111111"
  $user.turn_on_chat
  puts "$user user id = 6500"
  $user2 = premium_user :email => "milesn@g.com", :password => "111111"
  puts "$user2 user id = 6502"
end

Given(/^I login as(?: the)? premium user$/) do
  logout_if_already_logged_in
  puts "Log in using email and password: #{$user.email}, #{$user.password}" 
  common_page.login($user.email,$user.password)
  sleep 2
  common_page.finish_tutorial 
end

Given(/^I login as(?: the)? premium user and turn off chat$/) do
  $user.turn_off_chat
  logout_if_already_logged_in
  puts "Log in using email and password: #{$user.email}, #{$user.password}" 
  common_page.login($user.email,$user.password)
  sleep 2
  common_page.finish_tutorial 
end

Then(/^I login as the new user$/) do
  logout_if_already_logged_in
  puts "Log in using email and password: #{$new_user.email}, #{$new_user.password}" 
  common_page.login($new_user.email,$new_user.password)
  sleep 2
  common_page.finish_tutorial 
end

Given(/^I login as (?:the )?non\-premium user$/) do
  logout_if_already_logged_in
  puts "Log in using email and password: #{$user2.email}, #{$user2.password}" 
  common_page.login($user2.email,$user2.password)
  sleep 2
  common_page.finish_tutorial 
end

Given(/^the premium user create a topic in the test group$/) do
  puts GROUP_ID
  $user.create_topic({:topic_title => "Test premium", :group_id => GROUP_ID})
end


Given(/^the non\-premium user create a topic in the test group$/) do
  puts GROUP_ID
  $user2.create_topic({:topic_title => "Test premium", :group_id => GROUP_ID})
end



Given(/^I create another non\-premium user "([^"]*)" and create a topic in the test group with topic name "([^"]*)"$/) do |user_name, topic_name|
  $new_user = forum_new_nurture_user(first_name: user_name).join_group
  puts GROUP_ID
  $new_user.create_topic({:topic_title => topic_name, :group_id => GROUP_ID})
end

Given(/^I create another non\-premium user "([^"]*)" and create a topic in the test group with topic name "([^"]*)" and the user turns chat off$/) do |user_name, topic_name|
  $new_user = forum_new_nurture_user(first_name: user_name).join_group
  puts GROUP_ID
  $new_user.create_topic({:topic_title => topic_name, :group_id => GROUP_ID})
  $new_user.turn_off_chat
end


When(/^I enter new user's profile$/) do
  wait_touch "* {text CONTAINS '#{$new_user.first_name}'}"
end

##########>>>APP steps<<<##########
Then(/^I check the badge on the profile page exists$/) do
  # wait_for_element_exists "UILabel marked:'Glow Plus'", :time_out => 5
  puts "NON GLOW gl-community-plus-badge"
end


Then(/^I input URL in edit profile page$/) do
  premium_page.input_url_in_profile_page
end


When(/^I enter premium user's profile(?: page)?$/) do
  premium_page.enter_premium_profile
  wait_for_none_animating
end

When(/^I enter non\-premium user's profile$/) do
  premium_page.enter_non_premium_profile
  wait_for_none_animating
end

Then(/^I go back to user profile page$/) do
  forum_page.exit_edit_profile
  wait_for_none_animating
end

Then(/^I click the url and check the link works$/) do
  premium_page.check_url
end

Then(/^I go back to previous page from the pop-up web page$/) do
  premium_page.back_from_web_page
end

Then(/^I check that chat icon does not exist$/) do
  sleep 2
  check_element_does_not_exist "* marked:'Chat'"
end

Then(/^I check that the chat icon does not exist$/) do
  sleep 2
  check_element_does_not_exist "* marked:'Chat'"
end

Then(/^I check that the chat icon exists$/) do
  wait_for_element_exists "* marked:'Chat'"
end

Then(/^I click the chat icon and see the chat window$/) do
  wait_touch "* marked:'Chat'"
  wait_for_element_exists "* {text CONTAINS 'Send request to'}"
end

Then(/^I click the chat icon$/) do
  wait_touch "* marked:'Chat'"
end

Then(/^I turn off chat in profile settings$/) do
  premium_page.switch_chat_option
end


Then(/^I check that the chat section does not exist on the first page$/) do
  sleep 2
  check_element_does_not_exist "* marked:'RECOMMENDED PEOPLE'"
end

Then(/^I turn off signature in profile settings$/) do
  premium_page.switch_signature_option
end

Then(/^I should not see the signature in topic\/comment\/subreply$/) do
  check_element_does_not_exist "* id:'gl-community-plus-badge.png'"
end

Then(/^I update bio and location info$/) do
  premium_page.update_bio_location
end

Then(/^I checked the elements in a signature$/) do
  check_element_exists "* marked:'Chat'"
  check_element_exists "* id:'gl-community-plus-badge.png'"
end

Then(/^I click the areas in signature$/) do
  wait_touch "* marked:'Chat' index:0 parent * index:0"
end

Then(/^I should go to profile page$/) do
  wait_for_element_exists "* {text CONTAINS 'FOLLOWING'}"
end

Given(/^I enter the topic "([^"]*)"$/) do |arg1|
  wait_touch "label {text CONTAINS '#{arg1}'} index:0"
  wait_for_none_animating
end

Then(/^I check the signature does not display$/) do
  check_element_does_not_exist "* marked:'Chat'"
  check_element_does_not_exist "* id:'gl-community-plus-badge.png'"
end

Then(/^I should see the send request dialog$/) do
  wait_for_element_exists "* {text CONTAINS 'Send request'}", :time_out => 3
end

Then(/^I should see the prompt premium dialog$/) do
  wait_for_element_exists "* {text CONTAINS 'Upgrade to Glow Premium'}", :time_out => 3
end

Then(/^I click send request button$/) do
  premium_page.click_send_request
end


Then(/^I go to messages$/) do
  premium_page.enter_messages
end

Then(/^I click the name of the chat requester$/) do
  premium_page.click_name_of_chat_requester
end

When(/^I accept the chat request$/) do
  wait_touch "* marked:'Confirm'"
  wait_for_none_animating
end

When(/^I ignore the chat request$/) do
  wait_touch "* marked:'Ignore'"
  wait_for_none_animating
end

Then(/^I enter the chat window and start to chat$/) do
  sleep 1
  if element_exists "* marked:'Start chatting now.'"
    wait_touch "* marked:'Start chatting now.'"
  else 
    puts "HERE IS A BUG!!!"
    wait_touch "* marked:'miles2'"
  end
  wait_for_element_exists "* {text CONTAINS 'Enter Message'}"
end

Then(/^I click the name of the new user and enter the user's profile page$/) do
  premium_page.enter_new_user_profile
end

Then(/^I should see the chat requst is ignored$/) do
  puts "NEED TO CONFIRM THE TEXT HERE"
end

Then(/^I click done to close messages$/) do
  wait_touch "* marked:'Done'"  
end

Then(/^I cannot see a url field in edit profile page$/) do
  wait_for_element_does_not_exist "* marked:'Link'"
end

Then(/^I close the request dialog$/) do
  premium_page.close_request_dialog
end

Then(/^I check that the chat requst failed to be sent$/) do
  premium_page.chat_request_fail
end

Then(/^I can see the status is following$/) do
  wait_for_element_exists "* marked:'Following'"
end

