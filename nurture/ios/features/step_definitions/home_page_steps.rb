Then(/^I close the insights popup$/) do
  home_page.close_insights_popup
end

Then(/^I finish the tutorial$/) do
  home_page.finish_tutorial
end

Given(/^I complete the daily log$/) do
  home_page.complete_daily_log_new
  home_page.close_insights_popup
end