Given(/^I scroll to growth chart$/) do
  home_page.scroll_to_growth_chart
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