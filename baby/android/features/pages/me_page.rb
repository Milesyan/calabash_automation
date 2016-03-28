require 'calabash-android/abase'

class MePage < Calabash::ABase
  def trait
    "*"
  end

  def logout
    sleep 2
    nav_page.open "more options"
    touch "* marked:'Log out'"
  end

  def leave_baby
    until_element_exists "* id:'disconnect'", action: lambda { scroll "android.widget.ScrollView", :down }
    touch "* id:'disconnect'"
    touch "* marked:'Yes'"
    sleep 3
  end

  def add_born_baby(baby)
    touch "* id:'add_baby'"
    touch "* marked:'Yes!'"
    sleep 1
    until_element_exists "* id:'name'", action: lambda { touch "* marked:'Yes!'" }, retry_frequency: 1
    enter_text "* id:'name'", baby.first_name + " " + baby.last_name
    touch "* id:'gender'"
    gender = baby.gender == "M" ? "Boy" : "Girl"
    touch "* marked:'#{gender}'"
    touch "* id:'birthday'"
    set_date "datePicker", date_str(baby.birthday)
    touch "* marked:'Done'"
    touch "* id:'due_day'"
    set_date "datePicker", date_str(baby.birth_due_date)
    touch "* marked:'Done!'"
    touch "* id:'relationship'"
    touch "* marked:'#{$user.relation}'"
    touch "* id:'action_done'"
  end

  def add_upcomming_baby(baby)
    touch "* id:'add_baby'"

    touch "* marked:'No, not yet.'"
    sleep 1
    until_element_exists "* id:'name'", action: lambda { touch "* marked:'No, not yet.'" }, retry_frequency: 1
    enter_text "* id:'name'", baby.first_name + " " + baby.last_name
    touch "* id:'due_day'"
    set_date "datePicker", date_str(baby.birth_due_date)
    touch "* marked:'Done'"
    touch "* id:'relationship'"
    touch "* marked:'#{$user.relation}'"
    touch "* id:'action_done'"
  end
end