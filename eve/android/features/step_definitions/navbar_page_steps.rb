Given(/^I open "(.*?)" page$/) do |page|
  navbar_page.open(page.downcase)
  sleep 1
end