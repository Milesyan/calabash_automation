def forum_new_user(args = {})
	BabyUser.new(args).signup.login.leave_all_groups.join_group
end

def forum_new_other_user(args = {})
	BabyUser.new(args).signup.login
end 


Given(/^"([^"]*)" create a "([^"]*)" topic in the test group$/) do |user_name, topic_type|
  puts "New GlowBaby User '#{user_name}' created: #{$user.email}, #{$user.password}"
  case topic_type.downcase
  when "text"
    $user.create_topic({:topic_title => 'create topic by www api', :group_id => GROUP_ID})
  when "poll"
    $user.create_poll({:topic_title => 'create poll by www api', :group_id => GROUP_ID})
  end
  puts "Topic created, the title is  >>>>#{$user.topic_title}<<<<"
  logout_if_already_logged_in
end

Then(/^an existing GlowBaby user "([^"]*)" has created a topic in the test group$/) do |user_name|
  $user2 = forum_new_user(first_name: user_name)
  $user2.create_topic({:topic_title => "Test follow/block user", :group_id => GROUP_ID})
end

Then(/^I created another user to vote the poll$/) do
  $user2 = forum_new_user
  $user2.vote_poll  topic_id: $user.topic_id
  puts "#{$user2.email} voted on #{$user.email}'s topic, #{$user.topic_id}"
end


Then(/^"([^"]*)" add (\d+) comment(?:s)? and "([^"]*)" added (\d+) subrepl(?:y|ies) to each comment\.$/) do |user1_name, comment_number, user2_name, subreply_number|
  puts "Glow User #{user1_name} topic_id is #{$user.topic_id}"
  $user2 = forum_new_user(first_name: user2_name)
  puts "#{user2_name} user id is: #{$user2.user_id},  email is: #{$user2.email}"
  comment_number.to_i.times do |comment_number|
    $user.reply_to_topic $user.topic_id, reply_content: "content number #{comment_number+1}"
    puts "GlowBaby User #{user1_name} reply_id is #{$user.reply_id}"
    subreply_number.to_i.times do |subreply_number|
      puts "GlowBaby User #{user2_name} sub reply ++; subreply number is #{subreply_number+1}"
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
  puts "GlowBaby User #{user_name} topic_id is #{$user.topic_id}, topic title is #{$user.topic_title}"
  $comment_number = comment_number
  $subreply_number = subreply_number
  $random_prefix = ('a'..'z').to_a.shuffle[0,5].join
  comment_number.to_i.times do |comment_number|
    $user.reply_to_topic $user.topic_id, reply_content: "#{$random_prefix} comment #{comment_number+1}"
    if comment_number == 0
      $first_comment_id = $user.reply_id
      puts "first reply id is #{$first_comment_id}"
    end
    puts "GlowBaby User reply_id is #{$user.reply_id}"
    subreply_number.to_i.times do |subreply_number|
      puts "GlowBaby User sub reply ++"
      $user.reply_to_comment $user.topic_id, $user.reply_id, reply_content: "#{$random_prefix} sub-reply #{subreply_number+1}"
    end
  end
end



Then(/^another user "([^"]*)" create (\d+) topic(?:s)? and (\d+) comment(?:s)? and (\d+) subrepl(?:y|ies) for each comment$/) do |name, arg1, comment_number, subreply_number|
  $user2 = forum_new_user(first_name: name)
  $user2.create_topic :topic_title => "Test hide/flag #{$user2.random_str}"
  puts "Glow User #{name} topic_id is #{$user2.topic_id}, topic title is #{$user2.topic_title}"
  $comment_number2 = comment_number
  $subreply_number2 = subreply_number
  comment_number.to_i.times do |comment_number|
    $user2.reply_to_topic $user2.topic_id, reply_content: "Test hide/report comment #{comment_number+1}"
    $hidereply_content = "Test hide/report comment #{comment_number+1}"
    puts "GlowBaby User2 reply_id is #{$user2.reply_id}"
    subreply_number.to_i.times do |subreply_number|
      puts "GlowBaby User2 sub reply ++"
      $user2.reply_to_comment $user2.topic_id, $user2.reply_id, reply_content: "Test hide/report sub-reply #{subreply_number+1}"
    end
  end
end

Then(/^"([^"]*)" create topics and comments and replies for delete use$/) do |name|
  $user.create_topic
  puts "GlowBaby User #{name} topic_id is #{$user.topic_id}, topic title is #{$user.topic_title}"
  $random_str1 = $user.random_str
  $random_str2 = $user.random_str
  $user.reply_to_topic $user.topic_id, reply_content: "#{$random_str1}"
  puts "GlowBaby User #{name} reply_id is #{$user.reply_id}, reply_content = #{$random_str1}"
  $user.reply_to_comment $user.topic_id, $user.reply_id, reply_content: "#{$random_str2}"
  puts "GlowBaby User #{name} subreply content is #{$random_str2}"
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
    new_user = forum_new_other_user.upvote_topic $user.topic_id
    puts "#{new_user.first_name} upvoted #{$user.topic_id}  >> #{$user.topic_title} << "
  end
  arg2.to_i.times do
    new_user = forum_new_other_user.downvote_topic $user.topic_id
    puts "#{new_user.first_name} downvoted #{$user.topic_id} >> #{$user.topic_title} << "
  end
end

Given(/^(\d+) other users upvote the comment and (\d+) other users downvote the comment$/) do |arg1, arg2|
  arg1.to_i.times do
    new_user = forum_new_other_user.upvote_comment $user.topic_id, $first_comment_id
    puts "#{new_user.first_name} upvoted comment #{$first_comment_id} under #{$user.topic_id}  >> #{$user.topic_title} << "
  end
  arg2.to_i.times do
    new_user = forum_new_other_user.downvote_comment $user.topic_id, $first_comment_id
    puts "#{new_user.first_name} downvoted comment #{$first_comment_id} under #{$user.topic_id} >> #{$user.topic_title} << "
  end
end

Given(/^(\d+) other users reported the topic$/) do |arg1|
  reason_poll = ["Wrong group", "Rude", "Obscene", "Spam", "Solicitation"]
  arg1.to_i.times do
    new_user = forum_new_other_user.report_topic $user.topic_id, reason_poll.sample
    puts "#{new_user.first_name} reported #{$user.topic_id}"
  end
end


Given(/^(\d+) other users reported the comment$/) do |arg1|
  reason_poll = ["Rude", "Obscene", "Spam", "Solicitation"]
  arg1.to_i.times do
    new_user = forum_new_other_user.report_comment $user.topic_id, $first_comment_id, reason_poll.sample
    puts "#{new_user.first_name} reported #{$user.topic_id}"
  end
end

Given(/^I create a new glow forum user with name "(.*?)"$/) do |name|
  logout_if_already_logged_in
  $user = forum_new_user(first_name: name)
  puts "Email:>> #{$user.email}\nPwd:>>#{$user.password}"
  puts "Default group id is #{GROUP_ID}"
end


Then(/^"(.*?)" reply to (\d+) topics created by others$/) do |name, number|
  number.to_i.times do
    new_user = forum_new_other_user.create_topic
    $user.reply_to_topic new_user.topic_id
  end
  puts "#{name} replied to #{number} topics. "
end

Given(/^a user created a group in "(.*?)" category$/) do |arg1|
  other_user = forum_new_other_user
  other_user.create_group
end