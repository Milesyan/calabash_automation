def premium_user(args={})
  ForumUser.new(args).login.leave_all_groups.join_group
end
##########>>>WWW layer steps<<<##########
Given(/^A premium user miles3 and a non-premium user milesn have been created for test$/) do
  $user = premium_user :email => "miles3@g.com", :password => "111111"
  $user.turn_on_chat.turn_on_signature.remove_all_participants.remove_all_contacts.remove_all_blocked
  puts "$user user id = 8830"
  $user2 = premium_user :email => "milesn@g.com", :password => "111111"
  $user2.turn_on_chat.remove_all_participants.remove_all_contacts.remove_all_blocked
  puts "$user2 user id = 6502"
end

Given(/^I login as(?: the)? premium user$/) do
  logout_if_already_logged_in
  puts "Log in using email and password: #{$user.email}, #{$user.password}" 
  app_page.login($user.email,$user.password)
  sleep 2
  app_page.finish_tutorial 
end

Given(/^I login as(?: the)? premium user and turn off chat$/) do
  $user.turn_off_chat
  logout_if_already_logged_in
  puts "Log in using email and password: #{$user.email}, #{$user.password}" 
  app_page.login($user.email,$user.password)
  sleep 2
  app_page.finish_tutorial 
end


Given(/^A new user "([^"]*)" is created$/) do |name|
  $new_user = forum_new_user(first_name: name)
end

Then(/^I login as the new user$/) do
  logout_if_already_logged_in
  puts "Log in using email and password: #{$new_user.email}, #{$new_user.password}" 
  app_page.login($new_user.email,$new_user.password)
  sleep 2
  app_page.finish_tutorial 
end

Given(/^I login as (?:the )?non\-premium user$/) do
  logout_if_already_logged_in
  puts "Log in using email and password: #{$user2.email}, #{$user2.password}" 
  app_page.login($user2.email,$user2.password)
  sleep 2
  app_page.finish_tutorial 
end

Given(/^the premium user create a topic in the test group$/) do
  puts GROUP_ID
  $user.create_topic({:topic_title => "Test premium", :group_id => GROUP_ID})
end


Given(/^the non\-premium user create a topic in the test group$/) do
  puts GROUP_ID
  $user2.create_topic({:topic_title => "Test premium", :group_id => GROUP_ID})
end

Given(/^A premium user miles3 established chat relationship with a new user "([^"]*)"$/) do |name|
  $user = premium_user :email => "miles3@g.com", :password => "111111"
  $user.turn_on_chat
  $user.remove_all_participants.remove_all_contacts.remove_all_blocked
  $new_user = forum_new_user(first_name: name)
  $user.establish_chat $new_user
  if $user.res["rc"] == 0 
    puts "CHAT RELATIONSHIP CREATED SUCCESSFULLY"
  end
end

Given(/^premium user miles3 established chat relationship with the new user$/) do
  $user.establish_chat $new_user
  if $user.res["rc"] == 0 
    puts "CHAT RELATIONSHIP CREATED SUCCESSFULLY"
  end
end

Given(/^A premium user miles3 sent chat request to a new user "([^"]*)"$/) do |name|
  $user = premium_user :email => "miles3@g.com", :password => "111111"
  $user.login.turn_on_chat
  $user.remove_all_participants.remove_all_contacts
  $new_user = forum_new_user(first_name: name)
  $user.send_chat_request $new_user.user_id
  if $user.res["rc"] == 0 
    puts "CHAT REQUEST SENT SUCCESSFULLY"
  end
end


Given(/^I create another non\-premium user "([^"]*)" and create a topic in the test group with topic name "([^"]*)"$/) do |user_name, topic_name|
  $new_user = forum_new_user(first_name: user_name)
  puts GROUP_ID
  $new_user.create_topic({:topic_title => topic_name, :group_id => GROUP_ID})
end

Given(/^I create another non\-premium user "([^"]*)" and create a topic in the test group with topic name "([^"]*)" and the user turns chat off$/) do |user_name, topic_name|
  $new_user = forum_new_user(first_name: user_name).join_group
  puts GROUP_ID
  $new_user.create_topic({:topic_title => topic_name, :group_id => GROUP_ID})
  $new_user.turn_off_chat
end


When(/^I enter new user's profile$/) do
  wait_touch "* {text CONTAINS '#{$new_user.first_name}'}"
end

Given(/^a new user "([^"]*)" creates 1 topic with name "([^"]*)" and 1 comment and 1 subreply for each comment$/) do |user_name,topic_name|
  $new_user = forum_new_user(first_name: user_name)
  $new_user.create_topic :topic_title => topic_name
  $new_user.reply_to_topic $new_user.topic_id, reply_content: "new_user premium test comment"
  $new_user.reply_to_comment $new_user.topic_id, $new_user.reply_id, reply_content: "new_user premium test subreply"
end

Given(/^a new user "([^"]*)" creates 1 topic with name "([^"]*)" and 1 comment and 1 subreply for each comment with chat off$/) do |user_name,topic_name|
  $new_user = forum_new_user(first_name: user_name)
  $new_user.turn_off_chat
  $new_user.create_topic :topic_title => topic_name
  $new_user.reply_to_topic $new_user.topic_id, reply_content: "new_user premium test comment"
  $new_user.reply_to_comment $new_user.topic_id, $new_user.reply_id, reply_content: "new_user premium test subreply"
end

Given(/^the premium user miles3 creates 1 topic with name "([^"]*)" and 1 comment and 1 subreply for each comment$/) do |topic_name|
  $user.create_topic :topic_title => topic_name
  $user.reply_to_topic $user.topic_id, reply_content: "premium user test comment"
  $user.reply_to_comment $user.topic_id, $user.reply_id, reply_content: "premium user test subreply"
end


Given(/^(?:the )?premium user miles3 turns off signature$/) do
  $user.turn_off_signature
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
  check_element_exists "* id:'gl-community-plus-badge.png'"
  unless [2, 7].include? query("* id:'gl-community-plus-badge.png' index:1 sibling *").size 
    puts query("* id:'gl-community-plus-badge.png' index:1 sibling *").size
    screenshot_and_raise(msg='The number of elements for signature-off user is incorrect!') 
  end
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
  wait_for_element_exists "* {text CONTAINS 'Get Glow Premium'}", :time_out => 3
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
    wait_touch "* marked:'miles3'"
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
  begin
    wait_for_element_exists "* marked:'Done'",:time_out=>1
    touch "* marked:'Done'" 
  rescue RuntimeError
    wait_touch "* {text CONTAINS 'Accept Request'}"
    forum_page.click_back_button
  end 
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

#----CHAT WINDOW---
Then(/^I go to the chat window for the new user$/) do
  wait_for_element_exists "* marked:'Messages'"
  wait_for_element_exists "* marked:'Start chatting now.'"
  wait_touch "* marked:'#{$new_user.first_name}'"
  attempts = 0
  begin 
    attempts = attempts + 1
    check_element_exists "* marked:'Enter Message'"
  rescue RuntimeError
    wait_touch "* marked:'#{$new_user.first_name}'" if attempts < 3
  end
end

Then(/^I click chat settings$/) do
  premium_page.click_chat_settings
end

Given(/^I click "([^"]*)" in chat options$/) do |arg1|
  wait_touch "* marked:'#{arg1}'"
end

Then(/^I confirm to block the user$/) do
  wait_touch "* marked:'Yes, I am sure'"
end

Then(/^I confirm to delete the user$/) do
  wait_touch "* marked:'Yes, delete'"
end

Given(/^I send a message with text "([^"]*)"$/) do |arg1|
  premium_page.send_text_in_chat arg1
end

Then(/^I should see the chat history has been deleted$/) do
  sleep 2
  check_element_does_not_exist "* {text CONTAINS 'test delete history'}"
end

Then(/^I send a message with last image$/) do
  premium_page.send_image_in_chat
end

Then(/^I should see the image I sent$/) do
  wait_for_element_exists "MWTapDetectingView"
  touch "* marked:'Back'"
  if element_exists "* marked:'Back'"
    touch "* marked:'Back'"
  end
end

Then(/^I choose one of the reasons as report reason$/) do
  wait_for_element_exists "* marked:'Report'"
  enum_reason = ["Spam or scam", "Rude", "Pornographic, Hate, or Threat"].sample
  wait_touch "* marked:'#{enum_reason}'"
end

Then(/^I check the chat request is received$/) do
  wait_for_element_exists "* marked:'New Chat Request'"
  wait_for_element_exists "* {text contains '#{$user.first_name}'}"
end

Then(/^I click accept request button$/) do
  premium_page.touch_accept_request
  wait_touch "* marked:'Confirm'"
end

Then(/^I go back to previous page from chat request page$/) do
  sleep 1
  app_page.close_chat_popup
  wait_touch "* marked:'gl community back'"
end

Then(/^I goes to chat window and click close button$/) do
  wait_for_element_exists "* marked:'Close'"
  touch "* marked:'Close'"
end

Then(/^I go to contact list$/) do
  premium_page.open_contact_list
end

Then(/^I should see the user "([^"]*)" is in the contact list$/) do |arg1|
  wait_for_element_exists "* {text contains '#{arg1}'}"
end

Then(/^I should see the lock icon after the user's name$/) do
  wait_for_element_exists "* id:'contacts-lock'"
end

When(/^I click the name of user "([^"]*)"$/) do |arg1|
  wait_touch "* {text contains '#{arg1}'}"
end

And(/^I click settings in chat request page and see edit profile page$/) do
  premium_page.touch_accept_request
  wait_touch "* {text CONTAINS 'settings'}"
  wait_for_element_exists "* marked:'Edit Profile'"
end

When(/^I swipe the conversation log and click delete$/) do
  swipe "left", {:query => "* {text CONTAINS 'Swipe'}"}
  sleep 2
  wait_touch "* marked:'Delete'"
end

When(/^I swipe the contact person and click delete$/) do
  swipe "left", {:query => "* {text CONTAINS '#{$new_user.first_name}'}"}
  sleep 2
  wait_touch "* marked:'Delete'"
end

Then(/^I should see the contact person is deleted$/) do
  wait_for_element_exists "* marked:'Discover interesting people'"
end


#------TOUCH POINTS------
Then(/^I checked all the touch points for "([^"]*)"$/) do |arg1|
  strategy= 
    ["premium->non-premium", "non-premium->premium", "non-premium->non-premium",
     "premium->premium", "existing relationship", "chat off premium", 
     "chat off non-premium"]
  strategy_index = strategy.index arg1
  if strategy.include? arg1
    premium_page.check_touch_points_in_topic strategy_index
  else
    screenshot_and_raise(msg='The input for strategy is incorrect.')
  end
end


#UNDONE
Then(/^I check the recommended people section and elements$/) do
  wait_for_element_exists "DiscoveredPeopleCollectionViewCell"
end

When(/^I click chat button in recommended people section$/) do
  wait_touch "* marked:'Chat'"
end

Then(/^I can see a chat request is sent or premium prompt dialog$/) do
  begin
    wait_for_element_exists "* {text CONTAINS 'Get Glow Premium'}", :time_out => 1
  rescue RuntimeError => e 
    wait_for_element_exists "* {text CONTAINS 'Send request'}", :time_out => 1
  end  
  premium_page.close_request_dialog
end

When(/^I click see all button in recommended people section$/) do
  wait_touch "* marked:'See all'"
end

Then(/^I can see the list and check the elements$/) do
  wait_for_element_exists "* text:'Find other women in the community to chat with!'"
end

When(/^I click chat button in recommended people list$/) do
  wait_touch "* marked:'Chat'"
end

Then(/^I check the premium banner under discover tab$/) do
  check_element_exists "ForumDiscoverBanner"
  flick "ForumDiscoverBanner", {x:-100,y:0}
  puts "No way to check the image now."
end


Given(/^I login as(?: the)? premium user and reset all the flags under profile page$/) do
  $user.reset_all_flags
  logout_if_already_logged_in
  puts "Log in using email and password: #{$user.email}, #{$user.password}" 
  app_page.login($user.email,$user.password)
  sleep 2
  app_page.finish_tutorial 
end


Then(/^I turn on all the flags$/) do
  forum_page.scroll_down_to_see "Turn off Signature"
  sleep 1
  if query("UISwitch marked:'Hide posts in profile?'")[0]["value"]!= "0"
    screenshot_and_raise("Hide post flag error", :name => "Flag.png")
  # elsif query("UISwitch marked:'Hide from discovery'")[0]["value"]!= "0"
  #   screenshot_and_raise("Hide from discovery error", :name => "Flag.png")
  elsif query("UISwitch marked:'Turn off Chat'")[0]["value"]!= "0"
    screenshot_and_raise("Turn off chat error", :name => "Flag.png")
  elsif query("UISwitch marked:'Turn off Signature'")[0]["value"]!= "0"
    screenshot_and_raise("Turn off signature error", :name => "Flag.png")
  end
  wait_touch "UISwitch marked:'Hide posts in profile?'"
  touch "UISwitch marked:'Hide from discovery'"
  touch "UISwitch marked:'Turn off Chat'"
  touch "UISwitch marked:'Turn off Signature'"
end


Then(/^I check all the flags are turned on$/) do
  forum_page.scroll_down_to_see 'Turn off Signature'
  if query("UISwitch marked:'Hide posts in profile?'")[0]["value"]!= '1'
    screenshot_and_raise("Hide post flag error", :name => "Flag_after_turn_on.png")
  # elsif query("UISwitch marked:'Hide from discovery'")[0]["value"]!= '1'
  #   screenshot_and_raise("Hide from discovery error", :name => "Flag_after_turn_on.png")
  elsif query("UISwitch marked:'Turn off Chat'")[0]["value"]!= '1'
    screenshot_and_raise("Turn off chat error", :name => "Flag_after_turn_on.png")
  elsif query("UISwitch marked:'Turn off Signature'")[0]["value"]!= '1'
    screenshot_and_raise("Turn off signature error", :name => "Flag_after_turn_on.png")
  end
end

Then(/^I click the requestor's profile photo to see the profile page$/) do
  premium_page.touch_accept_request
  wait_touch ["* marked:'would like to chat with you.' sibling * index:0","* marked:'would like to chat with you.' sibling * index:1"].sample
  wait_for_element_exists "* marked:'Follow'"
end




















