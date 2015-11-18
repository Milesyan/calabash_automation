Then(/^I logout$/) do
  tab_bar_page.open("Me")
  me_page.open_settings
  settings_page.logout
end

Then(/^I touch "(.*?)" button|link$/) do |text|
  wait_touch "* marked:'#{text}'"
end