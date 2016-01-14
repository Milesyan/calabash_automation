Given(/^I log a (poo|pee) with start time "([^"]*)"$/) do |type, start_time_str|
  start_time = eval(start_time_str)
  home_page.add_diaper(type: type, start_time: start_time)
end