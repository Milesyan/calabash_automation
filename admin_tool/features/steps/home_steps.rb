Given(/^I search user "([^"]*)"$/) do |txt|
  home_page.search txt
  sleep 1
end