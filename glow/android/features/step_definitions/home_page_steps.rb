Given(/^I finish the tutorial$/) do
  home_page.finish_tutorial
end

Given(/^I complete daily log$/) do
  home_page.complete_daily_log
end

Given(/^I complate my daily log for male$/) do
  home_page.complete_daily_log "male"
end

Given(/^I complete ft log$/) do
  home_page.complete_ft_log
end
