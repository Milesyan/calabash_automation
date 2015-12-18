Then(/^I login as the new user or default user$/) do
	logout_if_already_logged_in
	if $user
		puts $user.email, $user.password 
	else 
		$user = User.new(email: 'miles@glowing.com', password: '111111')
	end
	onboard_page.login($user.email,$user.password)	
end