require 'calabash-android/abase'

class HomePage < Calabash::ABase
  def trait
    "*"
  end

  def open_milestones
    wait_for_element_exists "* id:'fab_expand_menu_button'", time_out: 15
    sleep 1
    touch "* id:'fab_expand_menu_button'"
    touch "* marked:'Moment'"
  end

  def close_milestones
    touch "android.widget.ImageButton contentDescription:'Navigate up'"
  end

  def close_insight_popup
    # sleep 1
    # touch "* id:'close_button'"
    wait_for_element_exists "* id:'title'"
    sleep 1
    press_back_button
  end

  def check_milestones
    get_all_milestones.each do |m|
      puts m
    end
  end

  def create_milestone(args)
    date = (args[:date] || Time.now).to_datetime
    title = args[:title] || "Hello World!"
    touch "* id:'action_add_milestone'"

    enter_text "* id:'title_editor'", title
    touch "* marked:'Today'"
    set_date "datePicker", date_str(date)
    touch "* marked:'Done'"

    touch "* id:'save'"
  end

  def get_all_milestones
    milestones = []
    milestones = query("* id:'milestone_content'", :text)
    milestones
  end

  def scroll_to_summary
    wait_for_element_exists "* id:'feed'", time_out: 15
    sleep 1
    until_element_exists "* id:'summary'", action: lambda { scroll "android.support.v4.widget.NestedScrollView", :down } 
  end

  def scroll_to_growth_chart
    wait_for_element_exists "* id:'feed'", time_out: 15
    sleep 1
    until_element_exists "* id:'head_circumference_chart'", action: lambda { scroll "android.support.v4.widget.NestedScrollView", :down }
  end

  def add_born_baby(baby)
    wait_for_element_exists "* marked:'Let\\'s get started'", time_out: 20
    sleep 1
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
    wait_for_element_exists "* marked:'Let\\'s get started'", time_out: 20
    sleep 1
    touch "* marked:'Let\\'s get started'"
    sleep 1
    touch "* marked:'No, not yet.'"
    enter_text "* id:'name'", baby.first_name + " " + baby.last_name
    touch "* id:'due_day'"
    set_date "datePicker", date_str(baby.birth_due_date)
    touch "* marked:'Done'"
    touch "* id:'relationship'"
    touch "* marked:'#{$user.relation}'"
    touch "* id:'action_done'"
  end

  def add_feed(args)
    scroll_to_summary
    touch "* marked:'Feed'"
    feed_type = args[:feed_type].downcase
    milk_type = args[:milk_type].downcase
    start_time = args[:start_time].to_datetime

    if feed_type == "breastfeeding"
      touch "* marked:'Breast'"

    elsif feed_type == "bottle"
      touch "* marked:'Bottle'"

      touch "* id:'start_date'"
      set_date "datePicker", date_str(start_time)
      touch "* marked:'Done'"
      touch "* id:'start_time'"
      set_time "timePicker", time_str(start_time)
      touch "* marked:'Done'"

      if milk_type == "breast"
        touch "* marked:'Breast milk'"
      elsif milk_type == "formula"
        touch "* marked:'Formula'"
      end
    end

    touch "* id:'save'"
  end

  def add_sleep(args)
    log_type = args[:log_type] || "manual"
    start_time = args[:start_time].to_datetime
    end_time = args[:end_time].to_datetime

    scroll_to_summary
    touch "* marked:'Sleep'"
    sleep 1
    if log_type == "manual"
      touch "* marked:'Or enter manually'" if view_with_mark_exists "Or enter manually"
      touch "* id:'begin_date'"
      set_date "datePicker", date_str(start_time)
      touch "* marked:'Done'"
      touch "* id:'begin_time'"
      set_time "timePicker", time_str(start_time)
      touch "* marked:'Done'"

      touch "* id:'end_date'"
      set_date "datePicker", date_str(end_time)
      touch "* marked:'Done'"
      touch "* id:'end_time'"
      set_time "timePicker", time_str(end_time)
      touch "* marked:'Done'"

      touch "* id:'save'"
    end
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

  def add_weight(args = {})
    touch "* id:'weight_chart'"
    
    i, d, unit = args[:weight].split(/^(\d+)(.\d+)/)[1..-1]
    date = args[:date].to_datetime
    touch "* id:'add_button'"
    touch "* id:'date_input'"
    set_date "datePicker", date_str(date)
    touch "* marked:'Done'"

    touch "* id:'weight_input'"
    enter_text "* id:'weight_input'", i + d
    touch "* id:'weight_unit'"
    sleep 0.5
    touch "* marked:'#{unit.strip.downcase}'"
    touch "* marked:'Save'"
    touch "* contentDescription:'Navigate up'" # back button
  end

  def add_height(args = {})
    touch "* id:'height_chart'"
    date = args[:date].to_datetime
    h, unit = args[:height].split(/^(\d+)/)[1..-1]

    touch "* id:'add_button'"
    touch "* id:'date_input'"
    set_date "datePicker", date_str(date)
    touch "* marked:'Done'"
    touch "* id:'height_input'"
    enter_text "* id:'height_input'", h
    touch "* id:'height_unit'"
    sleep 0.5
    touch "* marked:'#{unit.strip.downcase}'"
    touch "* marked:'Save'"
    touch "* contentDescription:'Navigate up'" # back button
  end

  def add_headcirc(args = {})
    touch "* id:'head_circumference_chart'"
    date = args[:date].to_datetime
    headcirc, unit = args[:headcirc].split(/^(\d+)/)[1..-1]

    touch "* id:'add_button'"
    touch "* id:'date_input'"
    set_date "datePicker", date_str(date)
    touch "* marked:'Done'"

    touch "* id:'head_input'"
    enter_text "* id:'head_input'", headcirc
    touch "* id:'head_unit'"
    sleep 0.5
    touch "* marked:'#{unit.strip.downcase}'"
    touch "* marked:'Save'"
    touch "* contentDescription:'Navigate up'" # back button
  end

  def add_birth_data
    touch "* id:'weight_chart'"
    enter_text "* id:'weight_input'", "8.88"
    enter_text "* id:'height_input'", "15"
    enter_text "* id:'head_input'", "30"
    touch "* marked:'SAVE'"
    touch "* contentDescription:'Navigate up'"
  end

end