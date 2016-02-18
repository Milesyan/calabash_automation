Given(/^I choose the baby to continue$/) do
  sleep 2
  touch "* marked:'name'"
end

Given(/^I scroll to growth chart$/) do
  home_page.scroll_to_growth_chart
end

# Milestones
Given(/^I open all moments$/) do
  home_page.open_milestones
end

Given(/^I check milestones$/) do
  home_page.check_milestones
end

Then(/^I close moments page$/) do
  home_page.close_milestones
end

Given(/^I create a milestone with date "([^"]*)" and title "([^"]*)"$/) do |date, title|
  home_page.create_milestone(date: eval(date), title: title)
  #home_page.close_milestones
end

# Daily log
Given(/^I log a bottle feeding with (breast|formula) milk with start time "([^"]*)"$/) do |milk_type, start_time_str|
  start_time = eval(start_time_str)
  home_page.add_feed feed_type: "bottle", milk_type: milk_type, start_time: start_time
  #close_popup_if_needed
end

Given(/^I log a sleep with start time "([^"]*)" and end time "([^"]*)"$/) do |start_time_str, end_time_str|
  start_time = eval(start_time_str)
  end_time = eval(end_time_str)
  home_page.add_sleep start_time: start_time, end_time: end_time
  #close_popup_if_needed
end

Given(/^I close the inisght popup$/) do
  home_page.close_insight_popup
end

Given(/^I log a (poo|pee) with start time "([^"]*)"$/) do |type, start_time_str|
  start_time = eval(start_time_str)
  home_page.add_diaper(type: type, start_time: start_time)
end

Given(/^I log weight "([^"]*)" on "([^"]*)"$/) do |weight, date_str|
  date = eval(date_str)
  home_page.add_weight(date: date, weight: weight)
end

Given(/^I log height "([^"]*)" on "([^"]*)"$/) do |height, date_str|
  date = eval(date_str)
  home_page.add_height(date: date, height: height)
end

Given(/^I log headcirc "([^"]*)" on "([^"]*)"$/) do |headcirc, date_str|
  date = eval(date_str)
  home_page.add_headcirc(date: date, headcirc: headcirc)
end

Given(/^I add birth data$/) do
  home_page.add_birth_data
end

