Then(/^I finish the tutorial$/) do
  wait_touch "* id:'sk-cross-close'"
  home_page.finish_tutorial
end

Given(/^I close the premium popup$/) do
  wait_touch "* id:'sk-cross-close'"
end

Given(/^I complete my daily log$/) do
  home_page.complete_daily_log
  home_page.close_insights_popup
end

Given(/^I complete my daily log for male$/) do
  home_page.complete_daily_log("male")
end

Given(/^I complete daily log for female partner$/) do
  home_page.complete_daily_log
  home_page.close_insights_popup
end

Given(/^I complete my ft log$/) do
  home_page.complete_ft_log
  home_page.close_insights_popup
end

Given(/^I finish the tutorial via www$/) do
  home_page.finish_tutorial_via_www
end

Given(/^I finish the tutorial for partner via www$/) do
  home_page.finish_tutorial_for_partner_via_www
end

Given(/^I confirm the period with "([^"]*)"$/) do |choice|
  home_page.confirm_period(choice)
end