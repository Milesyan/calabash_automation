Given(/^I choose the baby to continue$/) do
  wait_touch "* id:'icon-arrow'"
end

Given(/^I add a baby with nurture pre\-filled data$/) do
  home_page.add_upcoming_nurture_baby
end

# Milestones

Given(/^I open all moments$/) do
  home_page.open_milestones
end

Given(/^I close moments page$/) do
  home_page.close_milestones
end

Given(/^I add a milestone$/) do
  home_page.open_milestones
end

Given(/^I check milestones$/) do
  home_page.check_milestones
end

Given(/^I create a milestone with date "([^"]*)" and title "([^"]*)"$/) do |date, title|
  home_page.create_milestone(date: eval(date), title: title)
end

# Daily log
Given(/^I log a bottle feeding with (breast|formula) milk with start time "([^"]*)"$/) do |milk_type, start_time_str|
  start_time = eval(start_time_str)
  home_page.add_feed feed_type: "bottle", milk_type: milk_type, start_time: start_time
end

Given(/^I log a sleep with start time "([^"]*)" and end time "([^"]*)"$/) do |start_time_str, end_time_str|
  start_time = eval(start_time_str)
  end_time = eval(end_time_str)
  home_page.add_sleep start_time: start_time, end_time: end_time
end

Given(/^I log a (poo|pee) with start time "([^"]*)"$/) do |type, start_time_str|
  start_time = eval(start_time_str)
  home_page.add_diaper(type: type, start_time: start_time)
end

# Growth Chart
Given(/^I scroll to growth chart$/) do
  home_page.scroll_to_growth_chart
end

Given(/^I log weight "([^"]*)" on "([^"]*)"$/) do |weight, date_str|
  date = eval(date_str)
  home_page.add_weight(date: date, weight: weight)
end

Given(/^I log height "([^"]*)" on "([^"]*)"$/) do |height, date_str|
  date = eval(date_str)
  home_page.add_height(date: date, height: height)
  #close_popup_if_needed
end

Given(/^I close the insight popup$/) do
  close_popup_if_needed
end

Then(/^I should not see the percentile until 40 weeks reached$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

