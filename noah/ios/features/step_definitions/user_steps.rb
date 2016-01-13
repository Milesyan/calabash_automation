
Given(/^I am a new "(.*?)" user$/) do |type|
  logout_if_already_logged_in

  email = get_email
  password = GLOW_PASSWORD

  type = type.downcase
  gender = type == "single male" ? "male" : "fgit emale"

  $user = User.new(email: email, password: password, type: type, gender: gender)
  puts email + "/" + password + " #{type}"
end


Given(/^I login$/) do
  if element_exists " * marked:'Swipe left or right to see different days'"
    home_page.finish_tutorial
  end
  logout_if_already_logged_in
  onboard_page.login($user.email, $user.password)
end


Given(/^I relaunch the app$/) do
  relaunch_app
end

