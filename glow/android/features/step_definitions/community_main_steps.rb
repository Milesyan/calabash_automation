Given(/^I log in as "(.*?)"$/) do |arg1|
	onboard_page.tap_login
	enter_text "* id:'email'", "miles@glowing.com"
  enter_text "* id:'password'", "111111"
  touch "* id:'sign_in_button'"
end

Then(/^a go to community page$/) do
  touch "* id:'nav_community'"
end

Then(/^I touch "(.*?)"$/) do |arg1|
  touch "* id:'create_poll_btn'"
end

Then(/^I fill in the contents in Poll page$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I choose the group$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I see "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end