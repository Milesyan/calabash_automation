Then(/^I finish the tutorial$/) do
  home_page.finish_tutorial
end

Given(/^I complete my daily log$/) do
  home_page.complete_daily_log
end

Given(/^I complete my daily log for male$/) do
  home_page.complete_daily_log("male")
end