Given(/^I am a "(.*?)" user$/) do |type|
  config = Hash[load_yamls]
  email, pwd = config["users"][GLOW_ENV.downcase][type.downcase].to_a.first
  puts email + '/' + pwd
  $user = User.new(email, pwd)
end

Given(/^I am a new "(.*?)" user$/) do |type|
  logout_if_already_logged_in

  email = get_email
  password = GLOW_PASSWORD

  type = type.downcase
  type = "ft" if type == "fertility treatment"
  if %w(prep med iui ivf).include?(type)
    treatment_type = type
    type = "ft"
  end

  gender = type == "single male" ? "male" : "female"

  $user = User.new(email: email, password: password, type: type, gender: gender, treatment_type: treatment_type)
  puts email + "/" + password + " #{type}"
end


Then(/^I am the female partner and my type is "(.*?)"$/) do |type|
  logout_if_already_logged_in

  email = $user.partner_email
  password = GLOW_PASSWORD

  type = type.downcase
  type = "ft" if type == "fertility treatment"
  if %w(prep med iui ivf).include?(type)
    treatment_type = type
    type = "ft"
  end

  gender = type == "single male" ? "male" : "female"

  $user = User.new(email: email, password: password, type: type, treatment_type: treatment_type, gender: gender)
  puts email + "/" + password + " #{type}"
end

Given(/^I register a new "(.*?)" user$/) do |type|
  logout_if_already_logged_in

  email = get_email
  password = GLOW_PASSWORD
  type = type.downcase
  type = "ft" if type == "fertility treatment"
  if %w(prep med iui ivf).include?(type)
    treatment_type = type
    type = "ft"
  end

  $user = User.new(email: email, password: password, type: type, treatment_type: treatment_type)
  puts email + "/" + password + " type: #{type}" + " treatment_type: #{treatment_type}"

  touch "* marked:'Sign up'"
  onboard_page.select_user_type

  case $user.type
  when "non-ttc"
    onboard_page.non_ttc_onboard_step1
    onboard_page.non_ttc_onboard_step2
    onboard_page.fill_in_email_password($user.email, $user.password)
    sleep 1
    touch "* id:'close'" if element_exists "* id:'close'"
  when "ttc"
    onboard_page.ttc_onboard_step1
    onboard_page.ttc_onboard_step2
    onboard_page.fill_in_email_password($user.email, $user.password)
    sleep 1
    touch "* id:'close'" if element_exists "* id:'close'"
  when "ft"
    onboard_page.ft_onboard_step1
    onboard_page.ft_onboard_step2
    #onboard_page.ft_onboard_step3
    onboard_page.fill_in_email_password($user.email, $user.password)
  end
  sleep 1
  home_page.finish_tutorial
end

Given(/^I login$/) do
  onboard_page.tap_login
  login_page.login
end