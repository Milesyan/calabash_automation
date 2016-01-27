Given(/^I touch "([^"]*)" button$/) do |text|
  touch "* marked:'#{text}'"
end

Given(/^I login(| as partner)$/) do |role|
  logout_if_already_logged_in
  if role.include? "partner"
    onboard_page.login($partner.email, $partner.password)
  else
    onboard_page.login($user.email, $user.password)
  end
end

And(/^I logout$/) do
  nav_page.open("more")
  me_page.logout
end