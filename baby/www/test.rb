require_relative 'noah_ios_test'
include BabyIOS
u = BabyUser.new
u.signup
baby = u.new_born_baby birthday: u.date_str(29.days.ago), birth_due_date: u.date_str(29.days.ago)
u.add_born_baby baby
u.add_weight weight: 5.8, date: "2016/01/23"
