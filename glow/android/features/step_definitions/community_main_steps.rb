Given(/^I log in as "(.*?)"$/) do |arg1|
	if not already_logged_in?
		$user = User.new(email: "miles@glowing.com", password: "111111")
		onboard_page.tap_login
		login_page.login
	end	
end

Then(/^a go to community page$/) do
  tap_when_element_exists "* id:'nav_community'"

end

Then(/^I touch "(.*?)"$/) do |arg1|
  community_page.touch_topictype(arg1)
end

#Then(/^I fill in the contents in Poll page$/) do
#	community_page.fill_in_poll
#end

Given(/^I post a "(.*?)" topic$/) do |arg1|
  case arg1.downcase
  when 'poll'
    community_page.fill_in_poll
  when 'post'     
    community_page.fill_in_post
  when 'photo'
    community_page.fill_in_photo
  when 'link'
    community_page.fill_in_link
  end      
end

Then(/^I choose the group$/) do
	community_page.choose_group
end

Then(/^I see "(.*?)" button is not enable$/) do |arg1|
  wait_for_elements_exist(["* text:'Done',enable:'false'"])
end

Then(/^I touch glow done$/) do
  community_page.touch_done
end

Then(/^I fill in a "(.*?)" title$/) do |arg1|
  community_page.fill_in_title(arg1)
end

Then(/^I fill in a "(.*?)" content$/) do |arg1|
  community_page.fill_in_content(arg1)
end

Then(/^I fill in a "(.*?)" answer$/) do |arg1|
  community_page.fill_in_pollanswer()
end


Then(/^I select the "(.*?)" group$/) do |arg1|
 # if arg1 == "4"
  sleep 0.5
  touch "textview index:4"
  #elsif 
  #  touch "textview index:3"   
  #end 
end

Then(/^I touch topic menu button$/) do
  sleep 5
  tap_when_element_exists "* id:'topic_menu'"
end

Then(/^I touch the "(.*?)" I created$/) do |arg1|
  sleep 1
  community_page.touch_created_topic(arg1)
end

Then(/^I touch Edit this post tab$/) do
  tap_when_element_exists "* text:'Edit this post'"
end

