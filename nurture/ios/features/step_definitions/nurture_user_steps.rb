Given(/^I create a nurture user in pregnancy week (\d+)$/) do |n|
  $user = NurtureUser.new(pregnancy_week: n).signup
end

Given(/^I create a new user$/) do
  $user = NurtureUser.new(due_date: 250.days.since).signup
end