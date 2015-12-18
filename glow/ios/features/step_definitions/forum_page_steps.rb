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

Then (/^I go to group page$/) do
  touch "* marked:'create topic by www api' index:1"
  forum_page.back_to_group
end  
Then(/^I edit the topic "([^"]*)" and change the title and content$/) do |topic_name|
  forum_page.edit_topic(topic_name)
end