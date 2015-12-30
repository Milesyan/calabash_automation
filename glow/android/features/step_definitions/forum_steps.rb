Given(/^I post a "(.*?)" topic$/) do |topic_type|
  case topic_type.downcase
  when "poll"
    forum_page.create_poll
  when "text"
    forum_page.create_post
  when "photo"
    forum_page.create_photo
  when "link"
    forum_page.create_link
  end
end


Then(/^I scroll down$/) do
  scroll_down
end


Then(/^I should see "(.*?)"$/) do |arg1|
  wait_for_elements_exist "* {text CONTAINS '#{arg1}'}"
end

Then(/^I should see the topic is posted successfully$/) do
    sleep 1
    wait_for_elements_exist "* {text CONTAINS 'Posted by'}"
    touch "* marked:'Back'"
    wait_for_none_animating
end

Then(/^I touch "(.*?)"$/) do |arg1|
  touch "* marked:'#{arg1}'"
end

Given(/^I open "(.*?)" tab in community$/) do |tab_name|
  sleep 2
  wait_for_none_animating
  touch "* marked:'#{tab_name}'"
end

Given(/^I open the topic created by user "(.*?)"$/) do |arg1|
  touch "* marked:'#{$user_a.topic_title}'"
  wait_for_none_animating
end

Given(/^I open the topic "(.*?)"$/) do |arg1|
  touch "label {text CONTAINS '#{arg1}'} index:0"
  wait_for_none_animating
end


Given(/^I add a comment$/) do
  forum_page.add_comment
end

Given(/^I add an image comment$/) do
  forum_page.add_image_comment
end

Given(/^I add (\d+) comments$/) do |n|
  forum_page.add_comments n
end

Given(/^I upvote the topic$/) do
  forum_page.upvote_topic
end

Given(/^I upvote the comment$/) do
  forum_page.upvote_comment
end

Given(/^I add a reply$/) do
  forum_page.add_reply
end

Given(/^I upvote the reply$/) do
  forum_page.upvote_reply
end

Given(/^I downvote the topic$/) do
  forum_page.downvote_topic
end

Given(/^I downvote the comment$/) do
  forum_page.downvote_comment
end

Given(/^I downvote the reply$/) do
  forum_page.downvote_reply
end

Then(/^I go to the first group$/) do
  forum_page.select_a_group
end

Then(/^I post a text topic with title "([^"]*)"$/) do |arg1|
  forum_page.create_post_in_group({'title': arg1})
end

Then(/^I discard the topic$/) do
  forum_page.discard_topic
end

Then (/^I go back to group$/) do
  forum_page.click_back_button
end

Then (/^I go back to previous page$/) do
  forum_page.click_back_button
end

Then (/^I go to group page in topic "([^"]*)"$/) do |topic_name|
  touch "* marked:'#{topic_name}' index:1"
  forum_page.click_back_button
end  

Then(/^I edit the topic "([^"]*)" and change the title and content$/) do |topic_name|
  forum_page.edit_topic topic_name
end

Then(/^I delete the topic with (\d+) visible comment(?:s)?$/) do |args1|
  forum_page.delete_topic args1
end


Then(/^I delete the comment index (\d+)$/) do |args1|
  forum_page.delete_comment args1
end


Then(/^I expand all the comments$/) do
  touch "UIButtonLabel marked:'Show entire discussion'"
end

Then(/^I click view all replies$/) do
  touch "UILabel marked:'View all replies'"
end

Then(/^I scroll "([^"]*)" to see "([^"]*)"$/) do |action,content|
  puts "the gesture is #{action}"
  puts "the target content is * marked:#{content}"
  forum_page.scroll_to_see action, content
end


Then(/^I go to search bar$/) do
  forum_page.evoke_search_bar
end

#--------Search Topics-----------

Then(/^I search the topic in the first step$/) do
  $rand_topic = Random.rand($topic_numbers.to_i).to_i + 1
  $search_content = "Test+search+#{$rand_topic}+#{$time_created}"
  forum_page.search_topics $search_content
end  


Then(/^I should see the search result for topic$/) do
  puts "search for #{$search_content}"
  forum_page.scroll_down_to_see $search_content
  forum_page.touch_search_result $search_content
end

Then(/^I return to group page from search result$/) do
  forum_page.click_back_button
  forum_page.click_cancel
end

#--------Search Comments-----------
Then(/^I click search for comment "([^"]*)"$/) do |comment|
  forum_page.search_comments comment
end

Then(/^I check the search result for comment "([^"]*)"$/) do |search_result|
  forum_page.check_search_result_comment search_result
end

Then(/^I check the search result for sub-reply "([^"]*)"$/) do |search_result|
  forum_page.check_search_result_subreply search_result
end

Then(/^I click search for deleted "([^"]*)"$/) do |arg1|
  case arg1
  when "comment" 
    string = $random_str1
  when "reply"
    string = $random_str2
  end  
  forum_page.search_comments string
end

Then(/^I check the search result for deleted "([^"]*)"$/) do |arg1|
  case arg1
  when "comment" 
    string = $random_str1
  when "reply"
    string = $random_str2
  end
  puts "Search for #{string}"
  forum_page.scroll_down_to_see string
  forum_page.check_search_result_deleted string
end


#-------------comment linking-------------
Then(/^I enter topic created in previous step$/) do 
  forum_page.enter_topic "#{$user.topic_title}"
end

Then(/^I should see the last comment$/) do 
  wait_for_elements_exist("* marked:'Test search comment #{$comment_number}'")
  puts "check element: * marked:'Test search comment #{$comment_number}'"
end





#-------------create/join/leave groups------------------

Then(/^I click the plus button in community tab$/) do
  touch "* marked:'＋'"
end

Then(/^I click Create a group$/) do
  touch "UIButtonLabel marked:'Create a group'"
end

Then(/^I join the group "([^"]*)"$/) do |arg1|
  forum_page.join_group arg1
  if element_exists("* marked:'Cancel'") 
    touch "* marked:'Cancel'"
  end
  wait_for_elements_exist("* marked:'Post'")
end

Then(/^I long press group "([^"]*)"$/) do |arg1|
  forum_page.long_press arg1
end

Then(/^I quit the group$/) do
  forum_page.leave_group
end

#----------------profile page -------------------------

Then(/^I go to community profile page$/) do
  forum_page.enter_profile_page
end

Then(/^I click edit profile button$/) do
  touch "* marked:'Edit profile'"
end

Then(/^I edit some field in profile page$/) do
  forum_page.edit_text_fields "Glow", "Last name"
  forum_page.edit_text_fields "#{$user.first_name}", "Edit first"
  forum_page.edit_text_fields "Shanghai", "Edit Shanghai"
  touch "UILabel marked:'Bio'"
  keyboard_enter_text "Edit Bio info"
end

Then(/^I go back to user profile page and check the changes in profile page$/) do
  forum_page.exit_edit_profile
  wait_for_none_animating
  check_element_exists("* marked:'Edit Bio info'")
  check_element_exists("* marked:'#{$user.first_name}Edit first'")
  check_element_exists("* marked:'Edit Shanghai'")
end

Then(/^I go back to forum page from forum profile page$/) do
  forum_page.exit_profile_page forum_page.get_UIButton_number-1
end

Then(/^I check "([^"]*)" under forum profile page and exit the page$/) do |arg1|
  forum_page.check_profile_element arg1.downcase
  forum_page.back_to_profile_page
end

Then(/^I check "([^"]*)" without seeing the user under forum profile page and exit the page$/) do |arg1|
  forum_page.check_following_not_exist
  forum_page.back_to_profile_page
end

Then(/^I open "([^"]*)" under forum profile page$/) do |arg1|
  forum_page.check_profile_element arg1.downcase
end

Then(/^I click the name of the creator "([^"]*)" and enter the user's profile page$/) do |arg1|
  forum_page.touch_creator_name arg1
end

Then(/^I "([^"]*)" the user$/) do |action|
  forum_page.action_to_other_user action
end

Then(/^I go to community settings page$/) do
  forum_page.go_to_community_settings
end

Then(/^I go to blocked users part under community settings$/) do
  forum_page.click_blocked_users
end

Then(/^I exit blocking users page$/) do
  forum_page.click_filters_button
end

Then(/^I click save of the community settings page$/) do
  forum_page.click_save_button
end

Then(/^I can see the person I blocked$/) do
  check_element_exists "* {text CONTAINS '#{$user2.first_name}'"
  check_element_exists "* marked:'Blocked'"
end

Then(/^I click the close button and go back to previous page$/) do
  forum_page.click_topnav_close
end

Then(/^I click the bookmark icon$/) do
  forum_page.click_bookmark_icon
end

Then(/^I click the hyperlink of comments$/) do
  forum_page.click_hyperlink_comments
end

Then(/^I enter topic created by another user$/) do 
  forum_page.enter_topic "#{$user2.topic_title}"
end

Then(/^I hide the topic$/) do 
  forum_page.hide_topic
end

Then(/^I should not see the topic hidden by me$/) do 
  check_element_does_not_exist  "* marked:'#{$user2.topic_title}'"
  puts "I cannot see topic #{$user2.topic_title}"
end

Then(/^I report the topic by reason "([^"]*)"$/) do |report_reason|
  forum_page.report_topic report_reason
end

Then(/^I hide the comment$/) do 
  forum_page.hide_comment
end

Then(/^I should not see the comment hidden by me$/) do 
  check_element_does_not_exist  "* marked:'#{$hidereply_content}'"
  puts "I cannot see comment #{$hidereply_content}"
end

Then(/^I report the comment by reason "([^"]*)"$/) do |report_reason|
  forum_page.report_comment report_reason
end
