Then(/^I logout$/) do
  tab_bar_page.open("Me")
  me_page.open_settings
  sleep 10
  settings_page.logout
end

Then(/^I touch "(.*?)" button|link$/) do |text|
  wait_touch "* marked:'#{text}'"
end

Then(/^I wait until I see "(.*?)"$/) do |text|
  wait_for(:timeout => 45, :retry_frequency => 2) do
    element_exists "* marked:'#{text}'"
  end
end


