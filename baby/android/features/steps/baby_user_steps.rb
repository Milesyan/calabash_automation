require 'calabash-android/calabash_steps'


Given(/^I sign up a new (mother|father) with birthday "([^"]*)"$/) do |relation, birthday_str|
  logout_if_already_logged_in
  gender = relation.include?("father") ? "M" : "F"
  birthday = eval(birthday_str) unless birthday_str.nil?
  $user = User.new relation: relation.capitalize, gender: gender, birthday: birthday
  onboard_page.signup
end

Given(/^I add one (born|upcoming) (boy|girl) with (?:birthday "([^"]*)"|)(?: and |)(?:due date "([^"]*)"|)$/) do |if_born, gender_str, birthday_str, due_date_str|
  gender = gender_str.include?("boy") ? "M" : "F"
  birthday = eval(birthday_str) unless birthday_str.nil?
  due_date = eval(due_date_str) unless due_date_str.nil?
  $baby = B.new gender: gender, birthday: birthday, birth_due_date: due_date
  home_page.method("add_#{if_born}_baby").call $baby
end

Given(/^I create a new (mother|father) with birthday "([^"]*)"$/) do |relation, birthday_str|
  gender = relation.include?("father") ? "M" : "F"
  birthday = eval(birthday_str) unless birthday_str.nil?
  $user = BabyUser.new(relation: relation.capitalize, gender: gender, birthday: eval(birthday_str).to_i).signup
end

Given(/^I create a new (mother|father) with (\d+) (born|upcoming) (boys?|girls?|baby|babies)(?: whose birthday is "([^"]*)"|)/) do |relation, baby_num, if_born, gender_str, birthday_str|
  gender = gender_str.include?("boy") ? "M" : "F"
  birthday = date_str(eval(birthday_str)) unless birthday_str.nil?
  $user = BabyUser.new.signup
  baby = $user.method("new_#{if_born}_baby").call relation: relation.capitalize, gender: gender, birthday: birthday
  $user.method("add_#{if_born}_baby").call baby
end

Given(/^I create and invite a partner as (father|mother)$/) do |role|
  relation = role.capitalize
  $partner = BabyUser.new
  $user.invite_family partner: $partner, relation: relation
end

Given(/^I signup as partner$/) do
  logout_if_already_logged_in
  $user = $partner
  $user.birthday = Time.at($user.birthday)
  onboard_page.signup
end

Given(/^I create and invite a partner as (Father|Mother|Family Member)$/) do |role|
  relation = role
  $partner = BabyUser.new
  $user.invite_family partner: $partner, relation: relation
end

Given(/^I create a Nurture user with due date "([^"]*)"$/) do |due_date_str|
  due_date = eval(due_date_str).to_i
  #$user = NurtureUser.new(due_date: due_date).signup
  $nu = NurtureUser.new(due_date: due_date).signup
  name = Faker::Name.name
  log_msg "Baby name: #{name}"
  $nu.name_baby name
  $user = BabyUser.new email: $nu.email, first_name: $nu.first_name, last_name: $nu.last_name
  $user.signup
end

Given(/^I invite my partner$/) do
  partner = NurtureUser.new
  $nu.invite_partner email: partner.email, first_name: partner.first_name
  partner.signup
  $user = BabyUser.new email: partner.email, first_name: partner.first_name
  $user.signup
end

