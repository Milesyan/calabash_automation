Given(/^I leave this baby$/) do
  me_page.leave_baby
end

Given(/^I add one (born|upcoming) (boy|girl) with (?:birthday "([^"]*)"|)(?: and |)(?:due date "([^"]*)"|) on me page$/) do |if_born, gender_str, birthday_str, due_date_str|
  gender = gender_str.include?("boy") ? "M" : "F"
  birthday = eval(birthday_str) unless birthday_str.nil?
  due_date = eval(due_date_str) unless due_date_str.nil?
  $baby = B.new gender: gender, birthday: birthday, birth_due_date: due_date
  me_page.method("add_#{if_born}_baby").call $baby
end