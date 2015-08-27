Then(/^I touch the "(.*?)" button$/) do |text|
  touch "* marked:'#{text}'"
end