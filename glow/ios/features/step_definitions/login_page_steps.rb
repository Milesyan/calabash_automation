Then(/^I login as the new user or default user$/) do
	logout_if_already_logged_in
	if $user
		puts $user.email, $user.password 
	else 
		$user = User.new(email: 'miles@glowing.com', password: '111111')
	end
	onboard_page.login($user.email,$user.password)	
end



Then(/^I login as user2$/) do
	logout_if_already_logged_in
	puts "Log in as user2" + $user2.email, $user2.password 
	onboard_page.login($user2.email,$user2.password)	
end