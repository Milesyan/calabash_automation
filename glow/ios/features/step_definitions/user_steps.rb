Given(/^I am an existing "(.*?)" user$/) do |type|
  config = Hash[load_yamls]
  case type.downcase
  when "ttc"
    email, password = config["users"]["sandbox"]["ttc"].to_a.first
    puts email + '/' + password
  end
end

Given(/^I am a new "(.*?)" user "(.*?)"$/) do |type, who|

  logout_if_already_logged_in
  email = get_email
  password = GLOW_PASSWORD

  type = type.downcase
  type = "ft" if type == "fertility treatment"
  if %w(prep med iui ivf).include?(type)
    treatment_type = type
    type = "ft"
  end

  if who == "A"
    first_name, last_name = "Alpha A".split " "
    $user_a = User.new(email: email, password: password, first_name: first_name, last_name: last_name, type: type, treatment_type: treatment_type)
    $user = $user_a
  elsif who == "B"
    first_name, last_name = "Beta B".split " "
    $user_b = User.new(email: email, password: password, first_name: first_name, last_name: last_name, type: type, treatment_type: treatment_type)
    $user = $user_b
  end
  
  user_name = "#{first_name}_#{Time.now.to_i} #{last_name}"
  
  puts email + "/" + password + " type: #{type}" + " treatment_type: #{treatment_type}"

  wait_touch "* marked:'Get Started!'"
  onboard_page.select_user_type
  case $user.type
  when "non-ttc"
    onboard_page.complete_non_ttc_step1
    onboard_page.complete_non_ttc_step2
  when "ttc"
    onboard_page.complete_ttc_step1
    onboard_page.complete_ttc_step2
  when "ft"
    onboard_page.complete_ft_step1
    onboard_page.complete_ft_step2
    onboard_page.complete_ft_step3
  end

  onboard_page.input_email_password($user.email, $user.password, user_name)
  home_page.finish_tutorial

end


Given(/^I register a new "(.*?)" user$/) do |type|

  email = get_email
  password = GLOW_PASSWORD
  type = type.downcase
  type = "ft" if type == "fertility treatment"
  
  if %w(prep med iui ivf).include?(type)
    treatment_type = type
    type = "ft"
  end

  $user = Glow.new(email: email, password: password, type: type, treatment_type: treatment_type)
  puts email + "/" + password + " type: #{type}" + " treatment_type: #{treatment_type}"

  wait_touch "* marked:'Get Started!'"
  onboard_page.select_user_type

  case $user.type
  when "non-ttc"
    onboard_page.complete_non_ttc_step1
    onboard_page.complete_non_ttc_step2
  when "ttc"
    onboard_page.complete_ttc_step1
    onboard_page.complete_ttc_step2
  when "ft"
    onboard_page.complete_ft_step1
    onboard_page.complete_ft_step2
    onboard_page.complete_ft_step3
  end

  onboard_page.input_email_password($user.email, $user.password)
  home_page.finish_tutorial
end


Given(/^I am a new "(.*?)" user$/) do |type|
  logout_if_already_logged_in
  email = get_email
  password = GLOW_PASSWORD
  type = type.downcase

  type = "ft" if type == "fertility treatment"
  #this was removed
  if %w(prep med iui ivf).include?(type)
    treatment_type = type
    type = "ft"
  end
  gender = type == "single male" ? "male" : "female"
  $user = Glow.new(email: email, password: password, type: type, gender: gender)
  puts email + "/" + password + " #{type}"
end

Given(/^I create a new "([^"]*)" user and the user create a "([^"]*)" topic in group "([^"]*)"$/) do |user_type, topic_type, group_id|
  case user_type.downcase
  when "non-ttc"
    $user = GlowUser.new(type: "non-ttc").female_non_ttc_signup.login.complete_tutorial.join_group
  when "ttc"
    $user = GlowUser.new(type: "ttc").female_ttc_signup.login.complete_tutorial.leave_group(1).join_group
  end
  puts 'New GlowUser created '+ $user.email, $user.password

  case topic_type.downcase
  when "text"
    $user.create_topic({:title => 'create topic by www api', :group_id => 4})
  when "poll"
    $user.create_poll({:title => 'create poll by www api', :group_id => 4})
  end
  puts 'Topic created, the title is '+ $user.topic_title
  logout_if_already_logged_in
end

Given(/^I login$/) do
  if element_exists " * marked:'Swipe left or right to see different days'"
    home_page.finish_tutorial
  end
  logout_if_already_logged_in
  onboard_page.login($user.email, $user.password)
end

Then(/^I created another user to vote the poll$/) do
  $user2 = GlowUser.new(type: "ttc").female_ttc_signup.login.complete_tutorial.leave_group(1).join_group
  $user2.vote_poll({ topic_id: $user.topic_id})
  puts "#{$user2.email} voted on #{$user.email}'s topic, #{$user.topic_id}"
end


Then(/^the user add (\d+) comments and user2 added (\d+) subreplies to each comment\.$/) do |comment_number, subreply_number|
  puts "GlowUser topic_id is #{$user.topic_id}"
  $user2 = GlowUser.new(type: "ttc").female_ttc_signup.login.complete_tutorial.leave_group(1).join_group
  puts "user2 user id is: #{$user2.user_id},  email is: #{$user2.email}"
  comment_number.to_i.times do |comment_number|
    $user.reply_to_topic $user.topic_id, reply_content: "content number #{comment_number+1}"
    puts "GlowUser reply_id is #{$user.reply_id}"
    subreply_number.to_i.times do |subreply_number|
      puts "GlowUser sub reply ++"
      $user2.reply_to_comment $user.topic_id, $user.reply_id, reply_content: "subreply number #{subreply_number+1}"
    end
  end
end



Given(/^I create a new user and create (\d+) topics$/) do |arg1|
  $user = GlowUser.new(type:"ttc").female_ttc_signup.login.complete_tutorial.leave_group(1).join_group

  arg1.to_i.times do |arg1|
    $user.create_topic({:title => "Test load more topic #{arg1+1}"})
  end
end




Given(/^I create a new user and create (\d+) topics for search topics$/) do |arg1|
  $user = GlowUser.new(type:"ttc").female_ttc_signup.login.complete_tutorial.leave_group(1).join_group
  $topic_numbers = arg1
  $time_created = Time.now.to_i.to_s
  arg1.to_i.times do |arg1|
    $user.create_topic({:title => "Test search #{arg1+1} #{$time_created}" })
  end
end


Given(/^I create a new user and create (\d+) topics and (\d+) comments and (\d+) subreply for each comments$/) do |arg1, comment_number, subreply_number|
  $user = GlowUser.new(type: "non-ttc").female_non_ttc_signup.login.complete_tutorial.join_group.create_topic
  puts "GlowUser topic_id is #{$user.topic_id}, topic title is #{$user.topic_title}"
  $comment_number = comment_number
  comment_number.to_i.times do |comment_number|
    $user.reply_to_topic $user.topic_id, reply_content: "Test search comment #{comment_number+1}"
    puts "GlowUser reply_id is #{$user.reply_id}"
    subreply_number.to_i.times do |subreply_number|
      puts "GlowUser sub reply ++"
      $user.reply_to_comment $user.topic_id, $user.reply_id, reply_content: "Test search sub-reply #{subreply_number+1}"
    end
  end
end


Given(/^I create a new user and create topics and comments and replies for delete use$/) do
  $user = GlowUser.new(type: "non-ttc").female_non_ttc_signup.login.complete_tutorial.join_group.create_topic
  puts "GlowUser topic_id is #{$user.topic_id}, topic title is #{$user.topic_title}"
  $random_str1 = $user.random_str
  $random_str2 = $user.random_str
  $user.reply_to_topic $user.topic_id, reply_content: "#{$random_str1}"
  puts "GlowUser reply_id is #{$user.reply_id}, reply_content = #{$random_str1}"
  $user.reply_to_comment $user.topic_id, $user.reply_id, reply_content: "#{$random_str2}"
  puts "GlowUser subreply content is #{$random_str2}"
  $user.delete_topic $user.topic_id
end

Given(/^I relaunch the app$/) do
  relaunch_app
end

