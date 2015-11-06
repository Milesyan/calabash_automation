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
  community_page.fill_in_topic(arg1) 			
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
  if arg1 == 'short'
    enter_text "* id:'title_editor'","abc"
  elsif arg1 == 'long'
    enter_text "* id:'title_editor'","abcdefg_auto"
  else
    clear_text_in "* id:'title_editor'"
    enter_text "* id:'title_editor'",arg1
  end
end

Then(/^I fill in a "(.*?)" content$/) do |arg1|
  if arg1 == 'short'
    enter_text "* id:'content_editor'","abc"
  elsif arg1 == 'long'
    enter_text "* id:'content_editor'","abcdefg_auto"
  else
    clear_text_in "* id:'content_editor'"
    enter_text "* id:'content_editor'",arg1
  end
end

Then(/^I fill in a "(.*?)" answer$/) do |arg1|
  if arg1 == 'short'
    enter_text "* id:'text' index:0","Ans"
    enter_text "* id:'text' index:1","Ans"
  elsif arg1 == 'long'
    enter_text "* id:'text' index:0","answer 1"
    enter_text "* id:'text' index:1","answer 2"
  elsif 
    enter_text "* id:'text' index:0",arg1 
    enter_text "* id:'text' index:1",arg1 
  end
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
  touch "* id:'topic_menu'"
end

Then(/^I touch the "(.*?)" I created$/) do |arg1|
  sleep 1
  if arg1 == "Post"
    touch "* text:'posttest' index:0"
  elsif arg1 == "Poll"
    touch "* text:'polltest' index:0"
  elsif arg1 == "Link"
    touch "* text:'linktest' index:0"
  elsif arg1 == "Photo"
    touch "* text:'phototest' index:0"
  end
end

Then(/^I touch Edit this post tab$/) do
  tap_when_element_exists "* text:'Edit this post'"
end

