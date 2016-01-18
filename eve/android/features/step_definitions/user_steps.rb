
Given(/^I am a new "(.*?)" user$/) do |type|
  logout_if_already_logged_in

  email = get_email
  password = GLOW_PASSWORD
  type = type.downcase
  gender = type == "single male" ? "male" : "female"

  $user = User.new(email: email, password: password, type: type, gender: gender)
  puts email + "/" + password + " #{type}"
end

Given(/^I login$/) do
  logout_if_already_logged_in
  login_page.tap_login
  login_page.login
end