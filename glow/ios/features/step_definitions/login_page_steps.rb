Then(/^I login as the new user "([^"]*)" created through www$/) do |user1_name|
	logout_if_already_logged_in
	puts "Log in using #{user1_name}'s email and password: #{$user.email}, #{$user.password}" 
	onboard_page.login($user.email,$user.password)	
end



Then(/^I login as user2$/) do
	logout_if_already_logged_in
	puts "Log in as user2" + $user2.email, $user2.password 
	onboard_page.login($user2.email,$user2.password)	
end