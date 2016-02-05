def new_noah_user(args={})
  NoahUser.new(args).signup.login.leave_all_groups.join_group
end

def forum_new_noah_user(args={})
  NoahUser.new(args).signup.login.leave_all_groups.join_group
end

def ntf_user(args = {})
  NoahUser.new(args).signup.login
end
  
Given(/^I create a new noah user$/) do |type|
  $user = new_noah_user
  puts $user.email, $user.password
end



#----------------Community--------------------


Given(/^"([^"]*)" create a "([^"]*)" topic in the test group$/) do |user_name, topic_type|
  puts "New Noah User '#{user_name}' created: #{$user.email}, #{$user.password}"
  case topic_type.downcase
  when "text"
    $user.create_topic({:topic_title => 'create topic by www api', :group_id => GROUP_ID})
  when "poll"
    $user.create_poll({:topic_title => 'create poll by www api', :group_id => GROUP_ID})
  end
  puts "Topic created, the title is  >>>>#{$user.topic_title}<<<<"
  logout_if_already_logged_in
end

Then(/^I create another noah user "([^"]*)" and create a topic in the test group$/) do |user_name|
  $user2 = forum_new_noah_user(first_name: user_name).join_group
  puts GROUP_ID
  $user2.create_topic({:topic_title => "Test follow/block user", :group_id => GROUP_ID})
end

Then(/^I created another user to vote the poll$/) do
  $user2 = forum_new_noah_user
  $user2.vote_poll({ topic_id: $user.topic_id})
  puts "#{$user2.email} voted on #{$user.email}'s topic, #{$user.topic_id}"
end


# Then(/^the user add (\d+) comments and user2 added (\d+) subreplies to each comment\.$/) do |comment_number, subreply_number|
Then(/^"([^"]*)" add (\d+) comment(?:s)? and "([^"]*)" added (\d+) subrepl(?:y|ies) to each comment\.$/) do |user1_name, comment_number, user2_name, subreply_number|
  puts "Noah User #{user1_name} topic_id is #{$user.topic_id}"
  $user2 = forum_new_noah_user(first_name: user2_name)
  puts "#{user2_name} user id is: #{$user2.user_id},  email is: #{$user2.email}"
  comment_number.to_i.times do |comment_number|
    $user.reply_to_topic $user.topic_id, reply_content: "content number #{comment_number+1}"
    puts "NoahUser #{user1_name} reply_id is #{$user.reply_id}"
    subreply_number.to_i.times do |subreply_number|
      puts "NoahUser #{user2_name} sub reply ++; subreply number is #{subreply_number+1}"
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
  puts "NoahUser #{user_name} topic_id is #{$user.topic_id}, topic title is #{$user.topic_title}"
  $comment_number = comment_number
  $subreply_number = subreply_number
  $random_prefix = ('a'..'z').to_a.shuffle[0,5].join
  comment_number.to_i.times do |comment_number|
    $user.reply_to_topic $user.topic_id, reply_content: "#{$random_prefix} comment #{comment_number+1}"
    if comment_number == 0
      $first_comment_id = $user.reply_id
      puts "first reply id is #{$first_comment_id}"
    end
    puts "NoahUser reply_id is #{$user.reply_id}"
    subreply_number.to_i.times do |subreply_number|
      $user.reply_to_comment $user.topic_id, $user.reply_id, reply_content: "#{$random_prefix} sub-reply #{subreply_number+1}"
    end
  end
end



Then(/^another user "([^"]*)" create (\d+) topic(?:s)? and (\d+) comment(?:s)? and (\d+) subrepl(?:y|ies) for each comment$/) do |name, arg1, comment_number, subreply_number|
  $user2 = forum_new_noah_user(first_name: name)
  $user2.create_topic :topic_title => "Test hide/flag #{$user2.random_str}"
  puts "Noah User #{name} topic_id is #{$user2.topic_id}, topic title is #{$user2.topic_title}"
  $comment_number2 = comment_number
  $subreply_number2 = subreply_number
  comment_number.to_i.times do |comment_number|
    $user2.reply_to_topic $user2.topic_id, reply_content: "Test hide/report comment #{comment_number+1}"
    $hidereply_content = "Test hide/report comment #{comment_number+1}"
    puts "NoahUser2 reply_id is #{$user2.reply_id}"
    subreply_number.to_i.times do |subreply_number|
      $user2.reply_to_comment $user2.topic_id, $user2.reply_id, reply_content: "Test hide/report sub-reply #{subreply_number+1}"
    end
  end
end

Then(/^"([^"]*)" create topics and comments and replies for delete use$/) do |name|
  $user.create_topic
  puts "NoahUser #{name} topic_id is #{$user.topic_id}, topic title is #{$user.topic_title}"
  $random_str1 = $user.random_str
  $random_str2 = $user.random_str
  $user.reply_to_topic $user.topic_id, reply_content: "#{$random_str1}"
  puts "NoahUser #{name} reply_id is #{$user.reply_id}, reply_content = #{$random_str1}"
  $user.reply_to_comment $user.topic_id, $user.reply_id, reply_content: "#{$random_str2}"
  puts "NoahUser #{name} subreply content is #{$random_str2}"
  $user.delete_topic $user.topic_id
end


Then(/^I follow another user "([^"]*)" and the user also follows me$/) do |arg1|
  $user2 = forum_new_noah_user(first_name: arg1).leave_group 3
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
    new_user = new_noah_user.upvote_topic $user.topic_id
    puts "#{new_user.first_name} upvoted #{$user.topic_id}  >> #{$user.topic_title} << "
  end
  arg2.to_i.times do
    new_user = new_noah_user.downvote_topic $user.topic_id
    puts "#{new_user.first_name} downvoted #{$user.topic_id} >> #{$user.topic_title} << "
  end
end

Given(/^(\d+) other users upvote the comment and (\d+) other users downvote the comment$/) do |arg1, arg2|
  arg1.to_i.times do
    new_user = new_noah_user.upvote_comment $user.topic_id, $first_comment_id
    puts "#{new_user.first_name} upvoted comment #{$first_comment_id} under #{$user.topic_id}  >> #{$user.topic_title} << "
  end
  arg2.to_i.times do
    new_user = new_noah_user.downvote_comment $user.topic_id, $first_comment_id
    puts "#{new_user.first_name} downvoted comment #{$first_comment_id} under #{$user.topic_id} >> #{$user.topic_title} << "
  end
end

Given(/^(\d+) other users reported the topic$/) do |arg1|
  reason_poll = ["Wrong group", "Rude", "Obscene", "Spam", "Solicitation"]
  arg1.to_i.times do
    new_user = new_noah_user.report_topic $user.topic_id, reason_poll.sample
    puts "#{new_user.first_name} reported #{$user.topic_id}"
  end
end


Given(/^(\d+) other users reported the comment$/) do |arg1|
  reason_poll = ["Rude", "Obscene", "Spam", "Solicitation"]
  arg1.to_i.times do
    new_user = new_noah_user.report_comment $user.topic_id, $first_comment_id, reason_poll.sample
    puts "#{new_user.first_name} reported #{$user.topic_id}"
  end
end

Given(/^I create a new noah user with name "(.*?)"$/) do |name|
  $user = forum_new_noah_user(first_name: name)
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
  logout_if_already_logged_in
end

#community v1.1 new
Then(/^"(.*?)" reply to (\d+) topics created by others$/) do |name, number|
  number.to_i.times do
    new_user = new_noah_user.create_topic
    $user.reply_to_topic new_user.topic_id
  end
  puts "#{name} replied to #{number} topics. "
end

#v1.1 explore page
Given(/^a user created a group in "(.*?)" category$/) do |arg1|
  other_user = new_noah_user
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


#community notification test
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
  end
end

#-----New Invite--------

Given(/^I create a new noah user with name "([^"]*)" and join group (\d+)$/) do |name, group|
  logout_if_already_logged_in
  $user = forum_new_noah_user(first_name: name).join_group group
  puts "Email:>> #{$user.email}\nPwd:>>#{$user.password}"
  puts "Default group id is #{GROUP_ID}, join group #{group}"
end



