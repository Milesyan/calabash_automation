require 'calabash-android/abase'

class HomePage < Calabash::ABase
  def trait
    "*"
  end

  def scroll_to_summary
    sleep 1
    until_element_exists "* id:'summary'", action: lambda { scroll "android.support.v4.widget.NestedScrollView", :down } 
  end

  def add_born_baby(baby)
    touch "* marked:'Let\\'s get started'"
    touch "* marked:'Yes!'"
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

  def add_upcoming_baby(baby)
    touch "* marked:'Let\\'s get started'"
    touch "* marked:'No, baby\\'s coming.'"
    enter_text "* id:'name'", baby.first_name + " " + baby.last_name
    touch "* id:'due_day'"
    set_date "datePicker", date_str(baby.birth_due_date)
    touch "* marked:'Done'"
    touch "* id:'relationship'"
    touch "* marked:'#{$user.relation}'"
    touch "* id:'action_done'"
  end

  def add_diaper(args) 
    scroll_to_summary
    touch "* marked:'Diaper'"
    type = args[:type]
    start_time = args[:start_time].to_datetime
    
    touch "* id:'date'"
    set_date "datePicker", date_str(start_time)
    touch "* marked:'Done'"
    touch "* id:'time'"
    set_time "timePicker", time_str(start_time)
    touch "* marked:'Done'"

    case type.downcase
    when "poo"
      touch "* id:'poo'"
      colors = query "com.glow.android.baby.ui.dailyLog.PooColorPicker$Pigment"
      touch colors.sample
      textures = query "com.glow.android.baby.ui.dailyLog.PooTexturePicker$PooTextureView"
      touch textures.sample
    when "pee"
      touch "* id:'pee'"
    end
    touch "* id:'save'"
  end


end