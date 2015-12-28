Then(/^I logout$/) do
  nav_page.open("Me")
  me_page.logout
end

Given(/^I invite a partner$/) do
  me_page.open_settings
  me_page.invite_partner
  puts "partner #{$user.partner_email} has been invited"
end