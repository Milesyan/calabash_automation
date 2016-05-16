Given(/^I invite my partner$/) do
  me_page.invite_partner
end

Then(/^I invite my male partner$/) do
  me_page.invite_partner
end

Then(/^I invite my female partner$/) do
  me_page.invite_partner("female")
end

Given(/^my health profile should be "(.*?)"$/) do |percentage|
  sleep 1
  assert_equal percentage, query("* id:'health_profile_completion_rate'", :text).first
end

Given(/^I open and check my health profile$/) do
  me_page.open_health_profile
  me_page.check_my_health_profile
  me_page.back_from_health_profile
end

Given(/^I open and check my fertility testing and workup$/) do
  me_page.open_fertility_tests
  me_page.check_my_fertility_tests
  me_page.save_fertility_tests
end