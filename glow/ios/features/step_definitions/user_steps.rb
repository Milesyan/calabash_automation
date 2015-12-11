Given(/^I am an existing "(.*?)" user$/) do |type|
  config = Hash[load_yamls]
  case type.downcase
  when "ttc"
    email, password = config["users"]["sandbox"]["ttc"].to_a.first
    puts email + '/' + password
  end
end

Given(/^I am a new "(.*?)" user "(.*?)"$/) do |type, who|

  logout_if_already_logged_in
  email = get_email
  password = GLOW_PASSWORD

  type = type.downcase
  type = "ft" if type == "fertility treatment"
  if %w(prep med iui ivf).include?(type)
    treatment_type = type
    type = "ft"
  end

  if who == "A"
    first_name, last_name = "Alpha A".split " "
    $user_a = User.new(email: email, password: password, first_name: first_name, last_name: last_name, type: type, treatment_type: treatment_type)
    $user = $user_a
  elsif who == "B"
    first_name, last_name = "Beta B".split " "
    $user_b = User.new(email: email, password: password, first_name: first_name, last_name: last_name, type: type, treatment_type: treatment_type)
    $user = $user_b
  end
  
  user_name = "#{first_name}_#{Time.now.to_i} #{last_name}"
  
  puts email + "/" + password + " type: #{type}" + " treatment_type: #{treatment_type}"

  wait_touch "* marked:'Get Started!'"
  onboard_page.select_user_type
  case $user.type
  when "non-ttc"
    onboard_page.complete_non_ttc_step1
    onboard_page.complete_non_ttc_step2
  when "ttc"
    onboard_page.complete_ttc_step1
    onboard_page.complete_ttc_step2
  when "ft"
    onboard_page.complete_ft_step1
    onboard_page.complete_ft_step2
    onboard_page.complete_ft_step3
  end

  onboard_page.input_email_password($user.email, $user.password, user_name)
  home_page.finish_tutorial

end

Given(/^I create a new "(.*?)" user$/) do |type|
  case type.downcase
  when "non-ttc"
    $user = User.new(type: "non-ttc").female_non_ttc_signup.login.complete_tutorial
  when "ttc"
    $user = User.new(type: "ttc").female_ttc_signup.login.complete_tutorial
  end
  logout_if_already_logged_in
end

Given(/^I register a new "(.*?)" user$/) do |type|

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

  wait_touch "* marked:'Get Started!'"
  onboard_page.select_user_type

  case $user.type
  when "non-ttc"
    onboard_page.complete_non_ttc_step1
    onboard_page.complete_non_ttc_step2
  when "ttc"
    onboard_page.complete_ttc_step1
    onboard_page.complete_ttc_step2
  when "ft"
    onboard_page.complete_ft_step1
    onboard_page.complete_ft_step2
    onboard_page.complete_ft_step3
  end

  onboard_page.input_email_password($user.email, $user.password)
  home_page.finish_tutorial
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

  $user = User.new(email: email, password: password, type: type, gender: gender)
  puts email + "/" + password + " #{type}"
end

Given(/^I login$/) do
  onboard_page.login($user.email, $user.password)
end