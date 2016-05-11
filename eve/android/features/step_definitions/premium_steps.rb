def premium_user(args={})
  ForumUser.new(args).login.complete_tutorial.pull.leave_all_groups.join_group
end
##########>>>WWW layer steps<<<##########
Given(/^A premium user and a non-premium user have been created for test$/) do
  $user = premium_user :email => premium_email, :password => "111111"
  $user.turn_on_chat.turn_on_signature.remove_all_participants.remove_all_contacts.remove_all_blocked
  $user2 = premium_user :email => non_premium_email, :password => "111111"
  $user2.turn_on_chat.remove_all_participants.remove_all_contacts.remove_all_blocked
end

Given(/^A premium user has been created for test$/) do
  $user = premium_user :email => premium_email, :password => "111111"
  $user.turn_on_chat.turn_on_signature.remove_all_participants.remove_all_contacts.remove_all_blocked
end

Given(/^I login as(?: the)? premium user$/) do
  app_page.tap_login
  puts "Log in #{$user.user_id} using email and password: #{$user.email}, #{$user.password}" 
  app_page.login_with($user.email,$user.password)
  sleep 2
end

Given(/^I login as(?: the)? premium user and turn off chat$/) do
  $user.turn_off_chat
  app_page.tap_login
  puts "Log in #{$user.user_id} using email and password: #{$user.email}, #{$user.password}" 
  app_page.login_with($user.email,$user.password)
  sleep 2
end

Given(/^A new user "([^"]*)" is created$/) do |name|
  $new_user = forum_new_user(first_name: name)
end

Then(/^I login as the new user$/) do
  sleep 1
  app_page.tap_login
  puts "Log in #{$new_user.user_id} using email and password: #{$new_user.email}, #{$new_user.password}" 
  app_page.login_with($new_user.email,$new_user.password)
  sleep 2
end

Given(/^I login as (?:the )?non\-premium user$/) do
  app_page.tap_login
  puts "Log in #{$user2.user_id} using email and password: #{$user2.email}, #{$user2.password}" 
  app_page.login_with($user2.email,$user2.password)
  sleep 2 
end

Given(/^the premium user create a topic in the test group$/) do
  $user.create_topic({:topic_title => "Test premium", :group_id => GROUP_ID})
end


Given(/^the non\-premium user create a topic in the test group$/) do
  $user2.create_topic({:topic_title => "Test premium", :group_id => GROUP_ID})
end

Given(/^A premium user established chat relationship with a new user "([^"]*)"$/) do |name|
  $user = premium_user :email => premium_email, :password => "111111"
  $user.turn_on_chat
  $user.remove_all_participants.remove_all_contacts.remove_all_blocked
  $new_user = forum_new_user(first_name: name)
  $new_user.establish_chat $user
  if $user.res["rc"] == 0 
    puts "CHAT RELATIONSHIP CREATED SUCCESSFULLY"
  end
end

Given(/^premium user established chat relationship with the new user$/) do
  $user.establish_chat $new_user
  if $user.res["rc"] == 0 
    puts "CHAT RELATIONSHIP CREATED SUCCESSFULLY"
  end
end


Given(/^A premium user sent chat request to a new user "([^"]*)"$/) do |name|
  $user = premium_user :email => premium_email, :password => "111111"
  $user.turn_on_chat
  $user.remove_all_participants.remove_all_contacts
  $new_user = forum_new_user(first_name: name)
  $user.send_chat_request $new_user.user_id
  if $user.res["rc"] == 0 
    puts "CHAT REQUEST SENT SUCCESSFULLY"
  end
end



Given(/^I create another non\-premium user "([^"]*)" and create a topic in the test group with topic name "([^"]*)"$/) do |user_name, topic_name|
  $new_user = forum_new_user(first_name: user_name)
  $new_user.create_topic({:topic_title => topic_name, :group_id => GROUP_ID})
end

Given(/^I create another non\-premium user "([^"]*)" and create a topic in the test group with topic name "([^"]*)" and the user turns chat off$/) do |user_name, topic_name|
  $new_user = forum_new_user(first_name: user_name)
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

Given(/^the premium user creates 1 topic with name "([^"]*)" and 1 comment and 1 subreply for each comment$/) do |topic_name|
  $user.create_topic :topic_title => topic_name
  $user.reply_to_topic $user.topic_id, reply_content: "premium user test comment"
  $user.reply_to_comment $user.topic_id, $user.reply_id, reply_content: "premium user test subreply"
end


Given(/^(?:the )?premium user turns off signature$/) do
  $user.turn_off_signature
end
##########>>>APP steps<<<##########
Then(/^I check the badge on the profile page exists$/) do
  # wait_for_element_exists "UILabel marked:'Glow Plus'", :timeout  => 5
  sleep 1
  wait_for_element_exists "* marked:'Premium'"
end


Then(/^I input URL in edit profile page$/) do
  premium_page.input_url_in_profile_page
end


When(/^I enter premium user's profile$/) do
  premium_page.enter_premium_profile
end

When(/^I enter non\-premium user's profile$/) do
  premium_page.enter_non_premium_profile
end

Then(/^I go back to user profile page$/) do
  forum_page.click_back_button
end

Then(/^I click the url and check the link works$/) do
  premium_page.check_url
end

Then(/^I go back to previous page from the pop-up web page$/) do
    sleep 3
    system("adb shell input keyevent KEYCODE_BACK")
    sleep 3
    if element_does_not_exist "*"
      puts "CLICK AGAIN!"
      system("adb shell input keyevent KEYCODE_BACK")
    end
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
  sleep 1.5
  wait_touch "* marked:'Chat'"
  retries = 0
  begin
    wait_for_element_exists "DialogTitle id:'alertTitle' {text CONTAINS 'Send request to'}"
  rescue Timeout::Error
    raise if (retries += 1) > 3
    retry
  end
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
  check_element_does_not_exist "* id:'premium_author_profile_bg'"
end

Then(/^I update bio and location info$/) do
  premium_page.update_bio_location
end

Then(/^I checked the elements in a signature$/) do
  check_element_exists "* marked:'Chat'"
  check_element_exists "* id:'premium_author_profile_bg'"
end

Then(/^I click the areas in signature$/) do
  wait_touch "* marked:'Chat' index:0 parent * index:0"
end

Then(/^I should go to profile page$/) do
  sleep 0.5
  wait_for_element_exists "* marked:'Following'"
end

Given(/^I enter the topic "([^"]*)"$/) do |arg1|
  wait_for_element_exists "* id:'community_recommended_group_action_btn'"
  sleep 0.5
  touch "* marked:'#{arg1}'"
end

Then(/^I check the signature does not display$/) do
  check_element_does_not_exist "* marked:'Chat'"
  check_element_does_not_exist "* id:'premium_author_profile_bg'"
end

Then(/^I should see the send request dialog$/) do
  wait_for_element_exists "* {text CONTAINS 'Send request'}", :timeout  => 3
end

Then(/^I should see the prompt premium dialog$/) do
  premium_page.click_upgrade_premium
  sleep 1
  wait_touch "* marked:'OK'" 
  # wait_for_element_exists "* {text CONTAINS 'Upgrade to Glow Premium'}", :timeout  => 3
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
  wait_touch "* marked:'CONFIRM'"
end

When(/^I ignore the chat request$/) do
  wait_touch "* marked:'IGNORE'"
end

Then(/^I enter the chat window and start to chat$/) do
  sleep 3
  if element_exists "* marked:'I accepted your chat request.'"
    touch "* marked:'I accepted your chat request.'"
  else 
    puts "HERE IS A BUG!!!"
    wait_touch "* marked:'#{premium_name}'"
  end
  if element_does_not_exist "* marked:'Type something'"
    touch "* marked:'I accepted your chat request.'"
    puts "TOUCH AGAIN!"
  end
  premium_page.send_text_in_chat "Send text"
end

Then(/^I click the name of the new user and enter the user's profile page$/) do
  premium_page.enter_new_user_profile
end

Then(/^I should see the chat request is ignored$/) do
  sleep 2
  check_element_does_not_exist "* marked:'#{premium_name}'"
end

Then(/^I click done to close messages$/) do
  forum_page.click_back_button
end

Then(/^I cannot see a url field in edit profile page$/) do
  wait_for_element_does_not_exist "* marked:'Link'"
end

Then(/^I close the request dialog$/) do
  premium_page.close_request_dialog
end

Then(/^I check that the chat request failed to be sent$/) do
  premium_page.chat_request_fail
end


Then(/^I can see the status is following$/) do
  wait_for_element_exists "* marked:'Following'"
end

#----CHAT WINDOW---
Then(/^I go to the chat window for the new user$/) do
  wait_for_element_exists "* marked:'Messages'"
  # attempt = 0
  # begin 
  #   wait_touch "* marked:'#{$new_user.first_name}'"
  # rescue RuntimeError
  #   retry if attempt <4
  #   attempt += 1
  # end 
  wait_poll(:timeout => 10,
      :timeout_message => 'Unable to click chat requester',
      :until_exists => "* marked:'Type something'") do
    wait_touch "* marked:'#{$new_user.first_name}'"
  end
  # wait_for_element_exists "* marked:'Type something'"
end

Then(/^I click chat settings$/) do
  premium_page.click_chat_settings
end

Given(/^I click "([^"]*)" in chat options$/) do |arg1|
  wait_touch "* marked:'#{arg1}'"
end

Then(/^I confirm to block the user$/) do
  wait_for_element_exists "* marked:'Block'"
  wait_touch "* marked:'OK'"
  sleep 2
end

Then(/^I confirm to delete the user$/) do
  wait_touch "* marked:'Delete'"
end

Given(/^I send a message with text "([^"]*)"$/) do |arg1|
  premium_page.send_text_in_chat arg1
end

Then(/^I should see the chat history has been deleted$/) do
  sleep 0.5
  touch "* marked:'Delete'" if element_exists "* marked:'Delete'"
  sleep 1
  wait_for_element_does_not_exist "* {text CONTAINS 'test delete history'}"
end

Then(/^I send a message with last image$/) do
  premium_page.send_image_in_chat
end

Then(/^I should see the image I sent$/) do
  touch "* marked:'Back'"
  if element_exists "* marked:'Back'"
    touch "* marked:'Back'"
  end
end

Then(/^I choose one of the reasons as report reason$/) do
  wait_for_element_exists "* {text CONTAINS 'Please select the reason'}"
  enum_reason = ["Spam or scam", "Rude", "Pornographic, Hate, or Threat"].sample
  wait_touch "* marked:'#{enum_reason}'"
end

Then(/^I check the chat request is received$/) do
  wait_for_element_exists "* marked:'New Chat Request'"
  wait_for(:timeout =>2) do
    element_exists("* marked:'#{$user.first_name} is requesting to chat with you!'")||element_exists("* marked:'#{$user.first_name} is requesting to chat with you!\n\n'")
  end
end

Then(/^I click accept request button$/) do
  wait_touch "* marked:'Check it out'"
  premium_page.click_name_of_chat_requester
  wait_touch "* marked:'CONFIRM'"
end

Then(/^I go back to previous page from chat request page$/) do
  sleep 1
  forum_page.click_back_button
end

Then(/^I goes to chat window and click close button$/) do
  # wait_for_element_exists "* marked:'Close'"
  # touch "* marked:'Close'"
  forum_page.click_back_button
end

Then(/^I go to contact list$/) do
  premium_page.open_contact_list
end

Then(/^I should see the user "([^"]*)" is in the contact list$/) do |arg1|
  wait_for_element_exists "* {text contains '#{arg1}'}"
end

Then(/^I should see the lock icon after the user's name$/) do
  # wait_for_element_exists "* id:'contacts-lock'"
  wait_for_element_exists "* id:'chat_lock'"
end

When(/^I click the name of user "([^"]*)"$/) do |arg1|
  wait_touch "* {text contains '#{arg1}'}"
end

And(/^I click settings in chat request page and see edit profile page$/) do
  wait_touch "* marked:'Check it out'"
  premium_page.click_name_of_chat_requester
  wait_touch "* id:'hit_msg'"
  wait_for_element_exists "* marked:'Update cover photo'"
end

When(/^I swipe the conversation log and click delete$/) do
  sleep 1
  pan "android.widget.RelativeLayout", :left
  wait_touch "* marked:'Delete'"
end

When(/^I swipe the contact person and click delete$/) do
  sleep 1
  pan "android.widget.RelativeLayout", :left
  wait_touch "* marked:'Delete'"
  wait_touch "* marked:'Remove'"
  # if element_exists "android.widget.RelativeLayout"
  #   pan "android.widget.RelativeLayout", :left
  #   wait_touch "* marked:'Delete'"
  #   wait_touch "* marked:'Remove'"
  # end
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
  wait_for_element_exists "* id:'discover_category_list'"
  wait_for_element_exists "* id:'discover_category_people_card'"
  wait_for_element_exists "* id:'discover_people_info_container'"
  wait_for_element_exists "* id:'discover_category_people_name'"
  wait_for_element_exists "* id:'discover_category_people_brief1'"
  wait_for_element_exists "* id:'discover_category_people_brief2'"

end

When(/^I click chat button in recommended people section$/) do
  wait_touch "* marked:'Chat'"
end

Then(/^I can see a chat request is sent or premium prompt dialog$/) do
  # wait_for_element_exists "* marked:'Learn more'", :timeout  => 1
  options = {:timeout => 2,
             :retry_frequency => 0.2,
             :post_timeout => 0.1,
             :timeout_message => "Time out for chat or premium prompt"}
  wait_for(options) do
    element_exists("* marked:'Learn more'")|| element_exists("* marked:'Try for FREE'")|| element_exists("* {text CONTAINS 'Send request'}")
  end
  # wait_for_element_exists "* {text CONTAINS 'Send request'}", :timeout  => 1
  premium_page.close_request_dialog
end

When(/^I click see all button in recommended people section$/) do
  wait_touch "* marked:'See all'"
end

Then(/^I can see the list and check the elements$/) do
  wait_for_element_exists "* marked:'Find friends & Chat in private!'"
end

When(/^I click chat button in recommended people list$/) do
  wait_for_element_exists "* id:'user_brief_info'"
  wait_touch "* marked:'Chat'"
end

Then(/^I check the premium banner under discover tab$/) do
  pan "* id:'daimajia_slider_viewpager'", :left
  wait_for_element_exists "* id:'daimajia_slider_image'"
end

Given(/^I login as(?: the)? premium user and reset all the flags under profile page$/) do
  $user.reset_all_flags
  app_page.tap_login
  puts "Log in #{$user.user_id} using email and password: #{$user.email}, #{$user.password}" 
  app_page.login_with($user.email,$user.password)
  sleep 2
end

Then(/^I turn on all the flags$/) do
  forum_page.scroll_down_to_see "Turn off signature"
  sleep 1
  # if query("* marked:'Hide posts in profile?'")[0]["value"]!= "0"
  #   screenshot_and_raise("Hide post flag error", :name => "Flag.png")
  # # elsif query("* marked:'Hide from discovery'")[0]["value"]!= "0"
  # #   screenshot_and_raise("Hide from discovery error", :name => "Flag.png")
  # elsif query("* marked:'Turn off Chat'")[0]["value"]!= "0"
  #   screenshot_and_raise("Turn off chat error", :name => "Flag.png")
  # elsif query("* marked:'Turn off Signature'")[0]["value"]!= "0"
  #   screenshot_and_raise("Turn off signature error", :name => "Flag.png")
  # end
  begin
    wait_touch "* marked:'Hide posts in profile' sibling *"
  rescue RuntimeError
    wait_touch "* marked:'Hide posts in profile?' sibling *"
  end
  touch "* marked:'Hide from discovery' sibling *"
  touch "* marked:'Turn off chat' sibling *"
  touch "* marked:'Turn off signature' sibling *"
end


Then(/^I check all the flags are turned on$/) do
  forum_page.scroll_down_to_see 'Turn off signature'
  $user.get_user_info
  res = $user.res["data"]
  all_flags = [res["chat_off"], res["discoverable"],res["hide_posts"],res["signature_on"]]
  if all_flags != [1,0,1,0]
    screenshot_and_raise "Flags are wrong",:name => "flags_from_www_are_wrong.png"
  end
  sleep 1
end

Then(/^I click the requestor's profile photo to see the profile page$/) do
  wait_touch "* marked:'Check it out'"
  premium_page.click_name_of_chat_requester
  wait_touch "* id:'req_in_avatar'"
  wait_for_element_exists "* marked:'Follow'"
end

Then(/^I check the accept chat request notification is received$/) do
  if $new_user.code_name != 'noah' && $new_user.code_name != 'lexie'
    wait_for_element_exists "* marked:'Chat Now!'"
  else 
    wait_for_element_exists "* marked:'Check it out'"
  end
end

When(/^I click chat now button$/) do
  begin 
    touch "* marked:'Chat Now!'"
  rescue RuntimeError
    touch "* marked:'Check it out'"
  end
end

Then(/^I should see the messages page$/) do
  wait_for_element_exists "* marked:'Messages'"
end

When(/^I block the chat request$/) do
  sleep 1
  wait_touch "* marked:'BLOCK'"
  wait_for_element_exists "* marked:'Block this user?'"
  wait_touch "* marked:'Block'"
  wait_for_element_exists "* marked:'Blocked!'"
end

Then(/^I should see the chat requst is blocked$/) do
  puts "NEED TO CONFIRM THE TEXT HERE"
end

