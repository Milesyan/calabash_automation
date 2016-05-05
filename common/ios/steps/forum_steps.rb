#WWW STEPS
Then(/^I create another forum user "([^"]*)" and create a topic in the test group$/) do |user_name|
  $user2 = forum_new_user(first_name: user_name).join_group
  puts GROUP_ID
  $user2.create_topic({:topic_title => "Test follow/block user", :group_id => GROUP_ID})
end

Given(/^"([^"]*)" create a "([^"]*)" topic in the test group$/) do |user_name, topic_type|
  puts "New Forum User '#{user_name}' created: #{$user.email}, #{$user.password}"
  puts "GROUP id = #{GROUP_ID}"
  case topic_type.downcase
  when "text"
    $user.create_topic({:topic_title => 'create topic by www api', :group_id => GROUP_ID})
  when "poll"
    $user.create_poll({:topic_title => 'create poll by www api', :group_id => GROUP_ID})
  when "photo"
    $user.create_photo({:topic_title => 'create photo by www api', :group_id => GROUP_ID})
  end
  puts "Topic created, the title is  >>>>#{$user.topic_title}<<<<"
end

Then(/^I created another user to vote the poll$/) do
  $user2 = forum_new_user
  $user2.vote_poll({ topic_id: $user.topic_id})
  puts "#{$user2.email} voted on #{$user.email}'s topic, #{$user.topic_id}"
end


Then(/^"([^"]*)" add (\d+) comment(?:s)? and "([^"]*)" added (\d+) subrepl(?:y|ies) to each comment\.$/) do |user1_name, comment_number, user2_name, subreply_number|
  puts "Forum User #{user1_name} topic_id is #{$user.topic_id}"
  $user2 = forum_new_user(first_name: user2_name)
  puts "#{user2_name} user id is: #{$user2.user_id},  email is: #{$user2.email}"
  comment_number.to_i.times do |comment_number|
    $user.reply_to_topic $user.topic_id, reply_content: "content number #{comment_number+1}"
    puts "ForumUser #{user1_name} reply_id is #{$user.reply_id}"
    subreply_number.to_i.times do |subreply_number|
      $user2.reply_to_comment $user.topic_id, $user.reply_id, reply_content: "subreply number #{subreply_number+1}"
    end
  end
end


Then(/^"([^"]*)" create (\d+) topics$/) do |name, number|
  number.to_i.times do |number|
    $user.create_topic({:topic_title => "Test load more topic #{number+1}"})
  end
end


Then(/^"([^"]*)" create (\d+) topics for searching topic$/) do |name, arg1|
  $topic_numbers = arg1
  $time_created = $user.random_str
  arg1.to_i.times do |arg1|
    $user.create_topic({:topic_title => "Test+search+#{arg1+1}+#{$time_created}" })
  end
end

Then(/^"([^"]*)" create (\d+) topic(?:s)? and (\d+) comment(?:s)? and (\d+) subrepl(?:y|ies) for each comment$/) do |user_name, arg1, comment_number, subreply_number|
  $user.create_topic
  puts "ForumUser #{user_name} topic_id is #{$user.topic_id}, topic title is #{$user.topic_title}"
  $comment_number = comment_number
  $subreply_number = subreply_number
  $random_prefix = ('a'..'z').to_a.shuffle[0,5].join
  comment_number.to_i.times do |comment_number|
    $user.reply_to_topic $user.topic_id, reply_content: "#{$random_prefix} comment #{comment_number+1}"
    if comment_number == 0
      $first_comment_id = $user.reply_id
      puts "first reply id is #{$first_comment_id}"
    end
    puts "ForumUser reply_id is #{$user.reply_id}"
    subreply_number.to_i.times do |subreply_number|
      $user.reply_to_comment $user.topic_id, $user.reply_id, reply_content: "#{$random_prefix} sub-reply #{subreply_number+1}"
    end
  end
end


Then(/^another user "([^"]*)" create (\d+) topic(?:s)? and (\d+) comment(?:s)? and (\d+) subrepl(?:y|ies) for each comment$/) do |name, arg1, comment_number, subreply_number|
  $user2 = forum_new_user(first_name: name)
  $user2.create_topic :topic_title => "Test hide/flag #{$user2.random_str}"
  puts "Forum User #{name} topic_id is #{$user2.topic_id}, topic title is #{$user2.topic_title}"
  $comment_number2 = comment_number
  $subreply_number2 = subreply_number
  comment_number.to_i.times do |comment_number|
    $user2.reply_to_topic $user2.topic_id, reply_content: "Test hide/report comment #{comment_number+1}"
    $hidereply_content = "Test hide/report comment #{comment_number+1}"
    puts "ForumUser2 reply_id is #{$user2.reply_id}"
    subreply_number.to_i.times do |subreply_number|
      $user2.reply_to_comment $user2.topic_id, $user2.reply_id, reply_content: "Test hide/report sub-reply #{subreply_number+1}"
    end
  end
end

Then(/^"([^"]*)" create topics and comments and replies for delete use$/) do |name|
  $user.create_topic
  puts "ForumUser #{name} topic_id is #{$user.topic_id}, topic title is #{$user.topic_title}"
  $random_str1 = $user.random_str
  $random_str2 = $user.random_str
  $user.reply_to_topic $user.topic_id, reply_content: "#{$random_str1}"
  puts "ForumUser #{name} reply_id is #{$user.reply_id}, reply_content = #{$random_str1}"
  $user.reply_to_comment $user.topic_id, $user.reply_id, reply_content: "#{$random_str2}"
  puts "ForumUser #{name} subreply content is #{$random_str2}"
  $user.delete_topic $user.topic_id
end

Then(/^I follow another user "([^"]*)" and the user also follows me$/) do |arg1|
  $user2 = forum_new_user(first_name: arg1)
  $user.follow_user $user2.user_id
  $user2.follow_user $user.user_id
end


Then(/^the user bookmarked the topic$/) do
  $user.bookmark_topic $user.topic_id
end


Given(/^the user upvote the first comment$/) do
  $user.upvote_comment $user.topic_id, $first_comment_id
end

Given(/^(\d+) other users upvote the topic and (\d+) other users downvote the topic$/) do |arg1, arg2|
  arg1.to_i.times do
    new_user = forum_new_user.upvote_topic $user.topic_id
    puts "#{new_user.first_name} upvoted #{$user.topic_id}  >> #{$user.topic_title} << "
  end
  arg2.to_i.times do
    new_user = forum_new_user.downvote_topic $user.topic_id
    puts "#{new_user.first_name} downvoted #{$user.topic_id} >> #{$user.topic_title} << "
  end
end

Given(/^(\d+) other users upvote the comment and (\d+) other users downvote the comment$/) do |arg1, arg2|
  arg1.to_i.times do
    new_user = ntf_user.upvote_comment $user.topic_id, $first_comment_id
    puts "#{new_user.first_name} upvoted comment #{$first_comment_id} under #{$user.topic_id}  >> #{$user.topic_title} << "
  end
  arg2.to_i.times do
    new_user = ntf_user.downvote_comment $user.topic_id, $first_comment_id
    puts "#{new_user.first_name} downvoted comment #{$first_comment_id} under #{$user.topic_id} >> #{$user.topic_title} << "
  end
end

Given(/^(\d+) other users reported the topic$/) do |arg1|
  reason_poll = ["Wrong group", "Rude", "Obscene", "Spam", "Solicitation"]
  arg1.to_i.times do
    new_user = forum_new_user.report_topic $user.topic_id, reason_poll.sample
    puts "#{new_user.first_name} reported #{$user.topic_id}"
  end
end


Given(/^(\d+) other users reported the comment$/) do |arg1|
  reason_poll = ["Rude", "Obscene", "Spam", "Solicitation"]
  arg1.to_i.times do
    new_user = forum_new_user.report_comment $user.topic_id, $first_comment_id, reason_poll.sample
    puts "#{new_user.first_name} reported #{$user.topic_id}"
  end
end

#change
Given(/^I create a new forum user with name "([^"]*)"$/) do |name|
  $user = forum_new_user(first_name: name).complete_tutorial
  puts $user.email, $user.password
  puts "Default group id is #{GROUP_ID}"
end

Given(/^"([^"]*)" create a "([^"]*)" topic in the test group in TMI mode$/) do |user_name, topic_type|
  puts "GROUP id = #{GROUP_ID}"
  if topic_type.downcase == "photo"
    $user.create_photo({:topic_title => 'TEST TMI IMAGE', :group_id => GROUP_ID, :tmi_flag => 1})
  else 
    puts "ONlY PHOTO HAS TMI MODE!!!"
  end
  puts "TMI Photo, the title is  >>>>#{$user.topic_title}<<<<"
end

#community v1.1 new
Then(/^"(.*?)" reply to (\d+) topics created by others$/) do |name, number|
  number.to_i.times do
    new_user = forum_new_user.create_topic
    $user.reply_to_topic new_user.topic_id
  end
  puts "#{name} replied to #{number} topics. "
end

#v1.1 explore page
Given(/^a user created a group in "(.*?)" category$/) do |arg1|
  other_user = forum_new_user
  group_category_id =  GROUP_CATEGORY[arg1]
  other_user.create_group :group_category => group_category_id, :group_name => "TestJoinGroup"
end

Given(/^"([^"]*)" create a group in category "([^"]*)" using www api$/) do |arg1, arg2|
  $group_name = random_group_name
  group_category_id =  GROUP_CATEGORY[arg2]
  $user.create_group :group_category => group_category_id, :group_name => $group_name
  puts "Group >>#{$group_name}<< created in category #{arg2}, category id >>>#{group_category_id}"
end

Given(/^"([^"]*)" create a group in category "([^"]*)" with name "([^"]*)"$/) do |arg1, arg2,arg3|
  group_category_id =  GROUP_CATEGORY[arg2]
  $user.create_group :group_category => group_category_id, :group_name => arg3
  puts "Group >>#{arg3}<< created in category #{arg2}, category id >>>#{group_category_id}"
end

Given(/^I create a new forum user with name "([^"]*)" and join group (\d+)$/) do |name, group|
  $user = forum_new_user(first_name: name).complete_tutorial.leave_all_groups.join_group group
  puts "Email:>> #{$user.email}\nPwd:>>#{$user.password}"
  puts "Default group id is #{GROUP_ID}, join group #{group}"
end

Given(/^the notification test data for type (\d+) has been prepared through www$/) do |arg1|
  $ntf_type = arg1.to_s
  puts $ntf_type
  case $ntf_type
  when "1050","1085","1086","1087"
    n = {"1050"=>1, "1085"=>6, "1086"=>16,"1087"=>50}
    puts "The reply for a topic."
    $user.create_topic :topic_title => "notification_#{$ntf_type}"
    other_user = ntf_user
    n[$ntf_type].times do
      other_user.reply_to_topic $user.topic_id
    end
  when "1051"
    puts "Participant commenter"
    other_user = ntf_user
    other_user.create_topic :topic_title => "notification_1051"
    $user.reply_to_topic other_user.topic_id
    ntf_user.reply_to_topic other_user.topic_id
  when "1053"
    puts "Subreply notification"
    $user.create_topic :topic_title => "notification_1053"
    $user.reply_to_topic $user.topic_id
    other_user = ntf_user :first_name => "Replier"
    other_user.reply_to_comment $user.topic_id, $user.reply_id, :reply_content => "Reply_1053"
  when "1055"
    puts "5+ like for topic"
    $user.create_topic :topic_title => "notification_1055"
    5.times do 
      ntf_user.upvote_topic $user.topic_id
    end
  when "1059"
    puts "3 like for comment"
    $user.create_topic :topic_title => "notification_1059"
    $user.reply_to_topic $user.topic_id, :reply_content => "Reply_1059"
    4.times do
      ntf_user.upvote_comment $user.topic_id,$user.reply_id
    end
  when "1060"
    puts "3 more votes for a poll"
    $user.create_poll :topic_title => "notification_1060"
    3.times do
      ntf_user.vote_poll :topic_id => $user.topic_id, :vote_index => [1,2,3].sample
    end
  when "1088", "1089"
    n = {"1088"=>1, "1089"=>6}
    puts "The reply for a photo."
    $user.create_photo :topic_title => "notification_#{$ntf_type}"
    other_user = ntf_user
    n[$ntf_type].times do
      other_user.reply_to_topic $user.topic_id
    end
  when "1091","1092"
    n = {"1091"=>1, "1092"=>6}
    puts "Test follower"
    n[$ntf_type].times do
      ntf_user.follow_user $user.user_id
    end
  when "1056"
    puts "Subreply Participant"
    temp_user1 = ntf_user
    temp_user1.create_topic :topic_title=>"notification_1056"
    temp_user1.reply_to_topic temp_user1.topic_id, :reply_content=>"commentAAA"
    $user.reply_to_comment temp_user1.topic_id,temp_user1.reply_id
    temp_user2 = ntf_user
    temp_user2.reply_to_comment temp_user1.topic_id,temp_user1.reply_id, :reply_content=>"subreplyAAA"
  end

end


#NON_WWW STEPS
Given(/^I post a "(.*?)" topic$/) do |topic_type|
  case topic_type.downcase
  when "poll"
    forum_page.create_poll
  when "text"
    forum_page.create_post
  when "photo", "image"
    forum_page.create_photo
  when "link"
    forum_page.create_link
  else
    puts "The types should only be 'poll', 'text', 'photo'('image') or 'link'"
  end
end

Then(/^I should see the topic is posted successfully$/) do
    sleep 1
    swipe :up
    wait_for_element_exists "* marked:'Upvote'"
    wait_touch "* marked:'Back'"
    wait_for_none_animating
end

Then(/^I should see the topic cannot be voted$/) do
    sleep 1
    swipe :up
    wait_for_element_exists "* marked:'Upvote'"
    wait_touch "* marked:'Back'"
    wait_for_none_animating
end

Then(/^I should not see the creator name$/) do
    wait_for_none_animating
    sleep 1
    check_element_does_not_exist "* {text CONTAINS '#{$user.first_name}'}"
    wait_touch "* marked:'Back'"
    wait_for_none_animating
end

Given(/^I post a image topic with TMI flag$/) do
  forum_page.create_photo_tmi
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

#----------GROUP-------------
Then(/^I go to the first group$/) do
  forum_page.select_target_group
end

Then(/^I go to the invite target group$/) do 
  wait_touch "* marked:'ab-group-2'"
end


Then(/^I click the DISCOVER button in community tab$/) do
  forum_page.click_discover
end

Then(/^I click Explore button$/) do
  forum_page.click_explore
end

Then(/^I post a text topic with title "([^"]*)"$/) do |arg1|
  forum_page.create_post_in_group :topic_title => arg1
end

And(/^I post a text topic with title "([^"]*)" anonymously$/) do |arg1|
  forum_page.create_post_in_group :topic_title => arg1, :anonymous => 1
end

Then(/^I discard the topic$/) do
  forum_page.discard_topic
end

Then (/^I go back to group$/) do
  forum_page.click_back_button
end

Then (/^I go(?: back)? to previous page$/) do
  if element_exists "* marked:'Back'"
    forum_page.click_back_button
  else
    forum_page.exit_profile_page forum_page.get_UIButton_number-1
  end
end

#---------EDIT TOPIC--------
Then(/^I edit the topic "([^"]*)" and change the title and content$/) do |topic_name|
  forum_page.edit_topic topic_name
end

Then(/^I edit the topic create poll by www api and change the title and content$/) do
  forum_page.edit_poll_topic
end


Then(/^I edit the topic "([^"]*)" which has been voted$/) do |topic_name|
  forum_page.edit_topic_voted topic_name
end

Then(/^I delete the topic with (\d+) visible comment(?:s)?$/) do |args1|
  forum_page.delete_topic args1
end

Then(/^I delete the comment index (\d+)$/) do |args1|
  forum_page.delete_comment args1
end


Then(/^I expand all the comments$/) do
  sleep 2
  wait_touch "UIButtonLabel marked:'Show entire discussion'"
end

Then(/^I click view all replies$/) do
  wait_touch "UILabel marked:'View all replies'"
end

Then(/^I scroll "([^"]*)" to see "([^"]*)"$/) do |action,content|
  puts "the gesture is #{action}"
  puts "the target content is * marked:#{content}"
  forum_page.scroll_to_see action, content
end

#--------Search Topics-----------
Then(/^I go to search bar$/) do
  forum_page.evoke_search_bar
end

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
Then(/^I click search for comment$/) do
  forum_page.search_comments
end

Then(/^I click search for subreply$/) do
  forum_page.search_subreplies
end

Then(/^I check the search result for comment$/) do
  forum_page.check_search_result_comment
end

Then(/^I check the search result for sub-reply$/) do
  forum_page.check_search_result_subreply
end

Then(/^I click search for deleted "([^"]*)"$/) do |arg1|
  case arg1
  when "comment" 
    string = $random_str1
  when "reply"
    string = $random_str2
  end  
  forum_page.search_deleted_comments string
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
  wait_for_elements_exist("* {text CONTAINS 'comment #{$comment_number}'}")
  puts "check element: * with text 'comment #{$comment_number}'"
end





#-------------create/join/leave groups------------------

Then(/^I click the plus button in community tab$/) do
  wait_touch "* marked:'＋'"
end

Then(/^I join the group "([^"]*)"$/) do |arg1|
  forum_page.join_group arg1
  if element_exists("* marked:'Cancel'") 
    wait_touch "* marked:'Cancel'"
  end
  wait_for_elements_exist("* marked:'Post'")
end

Then(/^I long press group "([^"]*)"$/) do |arg1|
  forum_page.long_press arg1
end

Then(/^I quit the group$/) do
  forum_page.leave_group
end

Then(/^I check the button in the group$/) do
  wait_for_elements_exist "* marked:'Poll'"
  check_element_exists "* marked:'Post'"
end

#----------------profile page -------------------------

Then(/^I go to community profile page$/) do
  forum_page.enter_profile_page
end

Then(/^I click edit profile button$/) do
  wait_touch "* marked:'Edit profile'"
end

Then(/^I edit some field in profile page$/) do
  forum_page.edit_text_fields "#{$user.first_name}", "Edit first"
  forum_page.edit_text_fields "Shanghai", "Edit Shanghai"
  swipe :up
  wait_touch "UILabel {text CONTAINS 'Signature'}"
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
  wait_for_none_animating
  sleep 1
  begin
    if not $new_user.nil?
      check_element_exists "* {text CONTAINS '#{$new_user.first_name}'}"
      puts "CHECK NEW CHAT BLOCK"
    else
     check_element_exists "* {text CONTAINS '#{$user2.first_name}'}"
    end
  rescue RuntimeError => e 
    puts "Name not for new user or user2"
  end
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


Then(/^I click confirm to hide it$/) do
  forum_page.confirm_hide
end

Then(/^I click confirm not to hide it$/) do
  forum_page.confirm_hide 2
end

Then(/^I should still see the topic$/) do
  check_element_exists "* marked:'#{$user2.topic_title}'"
  puts "I can sitll see topic #{$user2.topic_title}"
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

Then(/^I should still see the comment$/) do
  check_element_exists "* marked:'#{$hidereply_content}'"
  puts "I can still see comment #{$hidereply_content}"
end

Then(/^I wait to see comment contains "([^"]*)"$/) do |arg1|
  wait_for_elements_exist "* {text CONTAINS '#{arg1}'}"
end

Then(/^I should not see the comment hidden by me$/) do 
  check_element_does_not_exist  "* marked:'#{$hidereply_content}'"
  puts "I cannot see comment #{$hidereply_content}"
end

Then(/^I report the comment by reason "([^"]*)"$/) do |report_reason|
  forum_page.report_comment report_reason
end

Then(/^I click to report the "([^"]*)" and check the reasons:$/) do |arg1,table|
  case arg1.downcase
  when "topic"
    forum_page.report_topic_check_reasons table
  when "comment"
    forum_page.report_comment_check_reasons table
  else
    puts "Wrong input"
  end
end

Then(/^I type in report reason and click flag$/) do
  wait_for_element_exists "* {text CONTAINS 'Please tell us why you are flagging this'}"
  keyboard_enter_text "TestFlagreasonbyMiles"
  wait_touch "* marked:'Flag'"
end

Then(/^I close the rules page$/) do
  forum_page.close_rules_page
end

#community v1.1 new
Then(/^I click create a group$/) do
  forum_page.scroll_down_to_see "Create my own group"
  swipe :up
  wait_touch "* marked:'Create my own group'"
end

Then(/^I create a group$/) do
  forum_page.create_a_group
end

Then(/^I should see the group name which I created$/) do
  wait_for_elements_exist "* {text CONTAINS 'MilesGroup'}"
end

Then(/^I click "([^"]*)" category$/) do |arg1|
  wait_touch "UIButton marked:'#{arg1}'"
end

#community v1.1 logging
Then(/^I click the search icon in explore page$/) do
  forum_page.click_search_under_explore
end

Then(/^I test search group function$/) do
  forum_page.search_groups "test"
  wait_for_element_exists "* {text CONTAINS 'Creator'}"  
  wait_touch "* marked:'Join'"
  wait_for_element_exists "* marked:'Joined!'"
end

Then(/^I click cancel button$/) do
  forum_page.click_cancel
end

Then(/^I go to "([^"]*)" category$/) do |arg1|
  if GROUP_CATEGORY.keys.include? arg1
    wait_touch "* marked:'#{arg1}'"
  else 
    puts "GROUP CATEGORY NAME IS WRONG."
  end
end

Then(/^I click new tab$/) do
  forum_page.touch_new_tab
  wait_for_none_animating
end

Then(/^I check the group I created is there$/) do
  wait_for_element_exists "* {text CONTAINS'#{$group_name}'}"
end

Then(/^I join the group$/) do
  wait_touch "* marked:'#{$group_name}' sibling * marked:'Join'"
end


Then(/^I click see all button after "([^"]*)"$/) do |arg1|
  wait_touch "* {text CONTAINS '#{arg1.upcase}'} sibling * marked:'See all'"
end

Then(/^I can see many groups$/) do
  if query("* {text contains 'Creator'}").count < 5
    raise "Cannot see more than 5 groups here"
  else
    puts "Can see >= 5 groups."
  end
end

Then(/^I touch button containing text "Check it out!"$/) do
  wait_touch "* {text CONTAINS 'Check it out'}"
end 

# -------NEW Invite and hide post flag----------------
Then(/^I invite the user to this group$/) do
  forum_page.invite_user
end

Then(/^I should see the user is already in this group$/) do
  puts "not useful in Android"
end

Then(/^I go to the second group$/) do
  forum_page.go_to_second_group
end

Then(/^I click the button to join the group$/) do
  app_page.ntf_join_group
end

Then(/^I close the group page$/) do
  forum_page.close_rules_page
end


Then(/^I should see "([^"]*)" in my view$/) do |arg1|
  wait_for_element_exists "* marked:'#{arg1}'"
end

Then(/^I scroll down the screen$/) do
  forum_page.scroll_down
end

Then(/^I scroll down the screen with strong force$/) do
  3.times do 
    swipe :up, force: :strong
  end
end

Then(/^I scroll up the screen with strong force$/) do
  3.times do 
    swipe :down, force: :strong
  end
end

Then(/^I scroll up the screen$/) do
  forum_page.scroll_up
end

When(/^I wait for 2 seconds for the next page$/) do
  sleep 2
end

Then(/^I scroll down to see "([^"]*)"$/) do |arg1|
  forum_page.scroll_down_to_see arg1
end

Then(/^I should see the floating buttons for creating topics$/) do
  check_element_exists "* marked:'Poll'"
end

Then(/^I should not see the floating buttons for creating topics$/) do
  check_element_does_not_exist "* marked:'Poll'"
end

When(/^I wait for the animation is finished$/) do
  wait_for_none_animating
  sleep 5
end

#----AGE FILTER----
Given(/^a forum user with the age (\d+) and create a topic in test group$/) do |arg1|
  $young_user = forum_new_user :birthday => 892461217, :first_name => "Age"
  $test_title = "#{$young_user.first_name}Test age filter topic"
  $young_user.create_topic :topic_title => $test_title
  puts "Age filter test user #{$young_user.user_id}, birthday #{$young_user.birthday}"
end

Then(/^I go to test group and check the topic exists$/) do
  forum_page.select_target_group
  wait_for_elements_exist "* text:'#{$test_title}'"
  puts "Young user topic exists >>>#{$test_title}"
end


Then(/^I go to age filter and choose the 3rd choice$/) do
  forum_page.go_to_community_settings
  wait_touch "* marked:'13 - 18'"
  touch "* marked:'19 - 25'"
  forum_page.click_save_button
end
  
Then(/^I go to test group and check the topic not exist$/) do
  forum_page.select_target_group
  check_element_does_not_exist "* text:'#{$test_title}'"
  puts "Yound user topic not exist >>>#{$test_title}"
end

Given(/^a forum user with the age (\d+) and create a topic in test group and some test comments and subreplies are created$/) do |arg1|
  $young_user = forum_new_user :birthday => 892461217, :first_name => "Filter"
  temp_user = ntf_user :birthday => 324558633
  temp_user.create_topic :topic_title => "Test age filter comment"
  temp_user.reply_to_topic temp_user.topic_id, :reply_content => "Should Show"
  $young_user.reply_to_topic temp_user.topic_id, :reply_content => "Filter comment"
  $young_user.reply_to_comment temp_user.topic_id, temp_user.reply_id, :reply_content => "Filter subreply"
  puts "Age filter test user #{$young_user.user_id}, birthday #{$young_user.birthday}"
end

Then(/^I check I can see the user's comment and subreply$/) do
  wait_touch "UIButtonLabel marked:'Show entire discussion'" 
  swipe :up
  wait_for_elements_exist ["* marked:'Filter comment'", "* {text CONTAINS 'Filter subreply'}"]
end

Then(/^I check I can not see the user's comment and subreply$/) do
  touch "UIButtonLabel marked:'Show entire discussion'" if element_exists "UIButtonLabel marked:'Show entire discussion'"
  swipe :up
  # wait_for_elements_do_not_exist ["* marked:'Filter comment'", "* {text CONTAINS 'Filter subreply'}"]
  wait_for_element_does_not_exist "* marked:'Filter comment'"
  forum_page.view_all_replies
  sleep 1
  check_element_does_not_exist "* marked:'Filter subreply'"
end

# ----TOS ----
Given(/^I open the app and go to the signup page$/) do
  app_page.signup_flow
end

When(/^I click the link for Terms$/) do
  app_page.touch_terms
end

Then(/^I should see the correct website for Terms$/) do
  # wait_for_elements_exist ["* id:'gl-foundation-browser-send'", "* id:'gl-foundation-browser-reload'"], :timeout  => 30
  app_page.check_TOS_website
  sleep 2
end

When(/^I click the link for Privacy Policy$/) do
  app_page.touch_privacy_policy
end

Then(/^I should see the correct website for Privacy Policy$/) do
  app_page.check_TOS_website
  sleep 2
end

Then(/^I should see the bottom hint section$/) do
  app_page.hint_section
end
  







