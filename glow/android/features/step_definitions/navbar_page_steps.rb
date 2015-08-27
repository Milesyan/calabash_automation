Given(/^I open "(.*?)" page$/) do |page|
  navbar_page.open(page.downcase)
end