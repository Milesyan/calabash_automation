Given(/^I logout$/) do
	navbar_page.open "me"
  toolbar_page.logout
end
