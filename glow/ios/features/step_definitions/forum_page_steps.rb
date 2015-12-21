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

Then(/^I should see the topic is posted successfully$/) do
    sleep 1
    wait_for_elements_exist "* {text CONTAINS 'Posted by'}"
    wait_touch "* marked:'Back'"
    wait_for_none_animating
end

Given(/^I open "(.*?)" tab in community$/) do |tab_name|
  sleep 2
  wait_for_none_animating
  wait_touch "* marked:'#{tab_name}'"
end

Given(/^I open the topic created by user "(.*?)"$/) do |arg1|
  wait_touch "* marked:'#{$user_a.topic_title}'"
  wait_for_none_animating
end

Given(/^I open the topic "(.*?)"$/) do |arg1|
  wait_touch "label {text CONTAINS '#{arg1}'} index:0"
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
  forum_page.back_to_group
end

Then (/^I go to group page in topic "([^"]*)"$/) do |topic_name|
  touch "* marked:'#{topic_name}' index:1"
  forum_page.back_to_group
end  

Then(/^I edit the topic "([^"]*)" and change the title and content$/) do |topic_name|
  forum_page.edit_topic(topic_name)
end

Then(/^I delete the topic index (\d+)$/) do |args1|
  forum_page.delete_topic(args1)
end


Then(/^I delete the comment index (\d+)$/) do |args1|
  forum_page.delete_comment(args1)
end


Then(/^I expand all the comments$/) do
  wait_touch "UIButtonLabel marked:'Show entire discussion'"
end

Then(/^I click view all replies$/) do
  wait_touch "UILabel marked:'View all replies'"
end

Then(/^I scroll "([^"]*)" to see "([^"]*)"$/) do |action,content|
  puts "the gesture is #{action}"
  puts "the target content is * marked:#{content}"
  if action == "up"
    until_element_exists("* marked:'#{content}'", :timeout => 30 , :action => lambda {swipe :down, :"swipe-delta" =>{:vertical => {:dx=> 0, :dy=> 368} }})
  elsif  action == "down"
    until_element_exists("* marked:'#{content}'", :timeout => 30 , :action => lambda {swipe :up, :"swipe-delta" =>{:vertical => {:dx=> 0, :dy=> 368} }})
  else 
    puts "Gesture  Error"
  end
end


Then(/^I go to search bar$/) do
  swipe :down, force: :strong
  wait_touch "UIButton marked:'Topics/Comments'"
end

Then(/^I search the topic "([^"]*)"$/) do |text|
  $rand_topic = Random.rand($topic_numbers.to_i)+1
  text = "Test search #{$time_created}"
  puts text
  keyboard_enter_text text
  tap_keyboard_action_key
end  

Then(/^I should see the search result$/) do
  #wait_for(:timeout=>3) {element_exists "* marked:''"}
  puts "search for 'Test search #{$rand_topic} #{$time_created}'"
  until_element_exists("* marked:'Test search #{$rand_topic} #{$time_created}'", :timeout => 3 , :action => lambda {swipe :up, :"swipe-delta" =>{:vertical => {:dx=> 0, :dy=> 200} }})
  wait_touch "UILabel marked:'Test search #{$rand_topic} #{$time_created}'"
end

Then(/^I return to group page from search result$/) do
  forum_page.back_to_group
  wait_touch "* marked:'Cancel'"
end

Then(/^I click search for comment "([^"]*)"$/) do |arg1|
  wait_touch "UISegment marked:'Comments'"
  keyboard_enter_text arg1
  tap_keyboard_action_key
end

Then(/^I check the search result for comment "([^"]*)"$/) do |search_result|
  random_number = Random.rand(10).to_i+1
  puts "Search for #{search_result} #{random_number}"
  until_element_exists("* marked:'#{search_result} #{random_number}'", :timeout => 10 , :action => lambda {swipe :up, :"swipe-delta" =>{:vertical => {:dx=> 0, :dy=> 300} }})
  wait_touch "UILabel marked:'#{search_result} #{random_number}'"
  wait_for_elements_exist("* marked:'#{search_result} #{random_number}'")
  puts "See element '#{search_result} #{random_number}'"

end

Then(/^I check the search result for sub-reply "([^"]*)"$/) do |search_result|
  random_number = Random.rand(10).to_i+1
  puts "Search for #{search_result} #{random_number}"
  until_element_exists("* marked:'#{search_result} #{random_number}'", :timeout => 10 , :action => lambda {swipe :up, :"swipe-delta" =>{:vertical => {:dx=> 0, :dy=> 300} }})
  wait_touch "UILabel marked:'#{search_result} #{random_number}'"
  wait_touch "UIButtonLabel marked:'Show entire discussion'"
  wait_touch "UILabel marked:'View all replies'"
  puts "Finding element '#{search_result} #{random_number}'"
  until_element_exists("* marked:'#{search_result} #{random_number}'", :timeout => 10 , :action => lambda {swipe :down, :"swipe-delta" =>{:vertical => {:dx=> 0, :dy=> 300} }})
end


Then(/^I click search for special comment$/) do
  wait_touch "UISegment marked:'Comments'"
  keyboard_enter_text "#{$random_str1}"
  tap_keyboard_action_key
end

Then(/^I check the search result for special comment$/) do
  puts "Search for #{$random_str1}"
  until_element_exists("* marked:'#{$random_str1}'", :timeout => 10 , :action => lambda {swipe :up, :"swipe-delta" =>{:vertical => {:dx=> 0, :dy=> 300} }})
  wait_touch "UILabel marked:'#{$random_str1}'"
  wait_for_elements_exist("* {text CONTAINS 'THis post has been removed'}")
  wait_touch "* marked:'OK'"
end


























































