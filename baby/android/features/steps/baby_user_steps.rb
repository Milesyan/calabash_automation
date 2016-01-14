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