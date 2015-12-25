def new_ttc_user
  GlowUser.new(type: "ttc").ttc_signup.login.complete_tutorial.leave_group(1).join_group
end
  
def new_non_ttc_user
  GlowUser.new(type: "non-ttc").non_ttc_signup.login.complete_tutorial.join_group
end

def new_ft_user(args = {})
  GlowUser.new(type: args[:type]).ft_signup(args).login.complete_tutorial.join_group
end

Given(/^I create a new "(.*?)" glow user$/) do |type|
  case type.downcase
  when "non-ttc"
    $user = new_non_ttc_user.complete_tutorial
  when "ttc"
    $user = new_ttc_user.complete_tutorial
  when "prep", "med", "iui", "ivf"
    $user = new_ft_user(type: type).complete_tutorial
  when "single male"
    $user = GlowUser.new(gender: "male").male_signup.complete_tutorial.join_group
  end
  puts $user.email, $user.password
end

Given(/^I create a new "(.*?)" "(.*?)" glow partner user$/) do |type, gender|
  case type.downcase
  when "non-ttc"
    u = new_non_ttc_user.invite_partner
    if gender.downcase == "male"
      $user = GlowUser.new(gender: "male", email: u.partner_email, first_name: u.partner_first_name).male_signup.complete_tutorial
    elsif gender.downcase == "female"
      $user = GlowUser.new(gender: "female", type: "female-partner", email: u.partner_email, first_name: u.partner_first_name).ttc_signup.login.complete_tutorial
      # secondary user should follow the primary user's status
    end
  when "ttc"
    u = new_ttc_user.invite_partner
    if gender.downcase == "male"
      $user = GlowUser.new(gender: "male", email: u.partner_email, first_name: u.partner_first_name).male_signup.complete_tutorial
    elsif gender.downcase == "female"
      $user = GlowUser.new(gender: "female", type: "female-partner", email: u.partner_email, first_name: u.partner_first_name).non_ttc_signup.login.complete_tutorial
      # secondary user should follow the primary user's status
    end
  when "prep", "med", "iui", "ivf"
    u = new_ft_user(type: type.downcase).invite_partner
    if gender.downcase == "male"
      $user = GlowUser.new(gender: "male", email: u.partner_email, first_name: u.partner_first_name).male_signup.complete_tutorial
    elsif gender.downcase == "female"
      $user = GlowUser.new(gender: "female", type: "female-partner", email: u.partner_email, first_name: u.partner_first_name).non_ttc_signup.login.complete_tutorial
      # secondary user should follow the primary user's status
    end
  end
end

Given(/^I complete my health profile via www$/) do
  $user.female_complete_health_profile($user.type)
end



#----------------Community--------------------


Given(/^The user create a "([^"]*)" topic in group "([^"]*)"$/) do |topic_type, group_id|
  puts 'New GlowUser created '+ $user.email, $user.password
  case topic_type.downcase
  when "text"
    $user.create_topic({:title => 'create topic by www api', :group_id => group_id.to_i})
  when "poll"
    $user.create_poll({:title => 'create poll by www api', :group_id => group_id.to_i})
  end
  puts "Topic created, the title is  #{$user.topic_title}"
  logout_if_already_logged_in
end

Then(/^I create another glow user and create a topic in group (\d+)$/) do |arg1|
  $user2 = new_non_ttc_user.complete_tutorial.join_group
  $user2.create_topic({:title => "Test follow/block user", :group_id => arg1})
end

Then(/^I created another user to vote the poll$/) do
  $user2 = new_ttc_user.leave_group(1).join_group
  $user2.vote_poll({ topic_id: $user.topic_id})
  puts "#{$user2.email} voted on #{$user.email}'s topic, #{$user.topic_id}"
end


Then(/^the user add (\d+) comments and user2 added (\d+) subreplies to each comment\.$/) do |comment_number, subreply_number|
  puts "GlowUser topic_id is #{$user.topic_id}"
  $user2 = new_non_ttc_user.leave_group(1).join_group
  puts "user2 user id is: #{$user2.user_id},  email is: #{$user2.email}"
  comment_number.to_i.times do |comment_number|
    $user.reply_to_topic $user.topic_id, reply_content: "content number #{comment_number+1}"
    puts "GlowUser reply_id is #{$user.reply_id}"
    subreply_number.to_i.times do |subreply_number|
      puts "GlowUser sub reply ++; subreply number is #{subreply_number+1}"
      $user2.reply_to_comment $user.topic_id, $user.reply_id, reply_content: "subreply number #{subreply_number+1}"
    end
  end
end



Then(/^the user create (\d+) topics$/) do |arg1|
  arg1.to_i.times do |arg1|
    $user.create_topic({:title => "Test load more topic #{arg1+1}"})
  end
end




Then(/^the user create (\d+) topics for search topics$/) do |arg1|
  $topic_numbers = arg1
  $time_created = $user.random_str
  arg1.to_i.times do |arg1|
    $user.create_topic({:title => "Test+search+#{arg1+1}+#{$time_created}" })
  end
end


Then(/^the user create (\d+) topics and (\d+) comments and (\d+) subreply for each comment$/) do |arg1, comment_number, subreply_number|
  $user.create_topic
  puts "GlowUser topic_id is #{$user.topic_id}, topic title is #{$user.topic_title}"
  $comment_number = comment_number
  $subreply_number = subreply_number
  comment_number.to_i.times do |comment_number|
    $user.reply_to_topic $user.topic_id, reply_content: "Test search comment #{comment_number+1}"
    puts "GlowUser reply_id is #{$user.reply_id}"
    subreply_number.to_i.times do |subreply_number|
      puts "GlowUser sub reply ++"
      $user.reply_to_comment $user.topic_id, $user.reply_id, reply_content: "Test search sub-reply #{subreply_number+1}"
    end
  end
end


Then(/^the user create topics and comments and replies for delete use$/) do
  $user.create_topic
  puts "GlowUser topic_id is #{$user.topic_id}, topic title is #{$user.topic_title}"
  $random_str1 = $user.random_str
  $random_str2 = $user.random_str
  $user.reply_to_topic $user.topic_id, reply_content: "#{$random_str1}"
  puts "GlowUser reply_id is #{$user.reply_id}, reply_content = #{$random_str1}"
  $user.reply_to_comment $user.topic_id, $user.reply_id, reply_content: "#{$random_str2}"
  puts "GlowUser subreply content is #{$random_str2}"
  $user.delete_topic $user.topic_id
end


Then(/^I follow another user and the user follows me$/) do
  $user2 = new_non_ttc_user
  $user.follow_user $user2.user_id
  $user2.follow_user $user.user_id
end


Then(/^the user bookmarked the topic$/) do
  $user.bookmark_topic $user.topic_id
end


Given(/^the user upvote the first comment$/) do
  $user.
end
