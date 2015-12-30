Then(/^I login as the new user "([^"]*)" created through www$/) do |user1_name|
	logout_if_already_logged_in
	onboard_page.tap_login
	puts "Log in using #{user1_name}'s email and password: #{$user.email}, #{$user.password}" 
	login_page.login_with $user.email,$user.password
end



Then(/^I login as "([^"]*)"$/) do |arg1|
	logout_if_already_logged_in
	puts "Log in as #{arg1}" + $user2.email, $user2.password 
	onboard_page.tap_login
	forum_page.login_with $user2.email,$user2.password
end