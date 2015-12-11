Given(/^I invite my partner$/) do
  me_page.invite_partner
end

Then(/^I invite my male partner$/) do
  me_page.invite_partner
end

Then(/^I invite my female partner$/) do
  me_page.invite_partner("female")
end