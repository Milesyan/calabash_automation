Given(/^I open "(.*?)" page$/) do |page|
	sleep 0.5
  navbar_page.open(page.downcase)
  sleep 1
end