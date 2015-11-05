Given(/^I log in as "(.*?)"$/) do |arg1|
	if not already_logged_in?
		$user = User.new(email: "miles@glowing.com", password: "111111")
		onboard_page.tap_login
		login_page.login
	end	
	/onboard_page.tap_login
	enter_text "* id:'email'", "miles@glowing.com"
  enter_text "* id:'password'", "111111"
  touch "* id:'sign_in_button'"/
end

Then(/^a go to community page$/) do
  tap_when_element_exists "* id:'nav_community'"
end

Then(/^I touch "(.*?)"$/) do |arg1|
	if arg1 == 'Poll'
 		touch "* id:'create_poll_btn'"
 	elsif arg1 == "Post"
 		touch "* id:'create_topic_btn'"
 	elsif arg1 == "Photo"
 		touch "* id:'create_photo_btn'"
 	elsif arg1 == "Link"
 		touch "* id:'create_url_btn'"
 	end
end

#Then(/^I fill in the contents in Poll page$/) do
#	community_page.fill_in_poll
#end

Then(/^I fill in the contents in "(.*?)" page$/) do |arg1|
  if arg1 == 'Poll'
  	community_page.fill_in_poll
  elsif arg1 == 'Post'
  	community_page.fill_in_post
  elsif arg1 == 'Photo'
  	community_page.fill_in_photo
  elsif arg1 == 'Link'
  	community_page.fill_in_link
  end
  			
end

Then(/^I choose the group$/) do
	community_page.choose_group
end
