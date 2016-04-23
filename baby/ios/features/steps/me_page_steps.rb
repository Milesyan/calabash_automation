Given(/^I edit my baby's profile$/) do
  wait_touch "* marked:'Edit profile'"
end

Given(/^I leave this baby$/) do
  me_page.leave_baby
end

Given(/^I close baby profile page$/) do
  me_page.close_baby_profile
end
