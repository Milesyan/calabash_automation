Given(/^I create a nurture user in pregnancy week (\d+)$/) do |n|
  $user = NurtureUser.new(pregnancy_week: n).signup
end