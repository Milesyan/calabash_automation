require 'calabash-android/abase'

class HomePage < Calabash::ABase
  def trait
    "*"
  end

  def open_milestones
    wait_for_element_exists "* id:'add_milestone'", time_out: 15
    sleep 1
    touch "* marked:'Add moments'"
  end

  def open_more_logs
    sleep 2
    until_element_exists "* id:'summary'", action: lambda { scroll "android.support.v4.widget.NestedScrollView", :down }
    sleep 1
    touch "* id:'more'"
    sleep 1
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
    touch "* marked:'OK'"

    touch "* id:'save'"
  end

  def check_first_milestone(args = {})
    touch "android.support.v7.widget.AppCompatTextView index:7"
    date = (args[:date] || Time.now).to_datetime
    touch "* marked:'Today'"
    set_date "datePicker", date_str(date)
    touch "* marked:'OK'"
    touch "* id:'save'"
  end


  def get_all_milestones
    milestones = []
    milestones = query("* id:'milestone_content'", :text)
    milestones
  end

  def scroll_to_summary
    wait_for_element_exists "* id:'sleep'", time_out: 15
    sleep 1
    until_element_exists "* id:'summary'", action: lambda { scroll "android.support.v4.widget.NestedScrollView", :down } 
  end

  def scroll_to_growth_chart
    #wait_for_element_exists "* id:'feed'", time_out: 15
    sleep 1
    until_element_exists "* id:'head_circumference_chart'", action: lambda { scroll "android.support.v4.widget.NestedScrollView", :down }
  end

  def add_born_baby(baby)
    wait_for_element_exists "* marked:'Add my baby'", time_out: 20
    sleep 1
    touch "* marked:'Add my baby'"
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

  def add_upcoming_baby(baby)
    wait_for_element_exists "* marked:'Add my baby'", time_out: 20
    sleep 1
    touch "* marked:'Add my baby'"
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

  def add_feed(args)
    #scroll_to_summary
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
      touch "* marked:'OK'"

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

    #scroll_to_summary
    touch "* marked:'Sleep'"
    sleep 1
    if log_type == "manual"
      touch "* marked:'Or enter manually'" if view_with_mark_exists "Or enter manually"
      touch "* id:'begin_date'"
      set_date "datePicker", date_str(start_time)
      touch "* marked:'Done'"
      touch "* id:'begin_time'"
      set_time "timePicker", time_str(start_time)
      touch "* marked:'OK'"

      touch "* id:'end_date'"
      set_date "datePicker", date_str(end_time)
      touch "* marked:'Done'"
      touch "* id:'end_time'"
      set_time "timePicker", time_str(end_time)
      touch "* marked:'OK'"

      touch "* id:'save'"
    end
  end

  def add_diaper(args) 
    #scroll_to_summary
    touch "* marked:'Diaper'"
    type = args[:type]
    start_time = args[:start_time].to_datetime
    
    touch "* id:'date'"
    set_date "datePicker", date_str(start_time)
    touch "* marked:'Done'"
    touch "* id:'time'"
    set_time "timePicker", time_str(start_time)
    touch "* marked:'OK'"

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
    scroll_to_growth_chart
    sleep 2
    touch "* id:'weight_chart'"
    i, d, unit = args[:weight].split(/^(\d+)(.\d+)/)[1..-1]
    date = args[:date].to_datetime
    touch "* id:'add_button'"
    touch "* id:'date_input'"
    set_date "datePicker", date_str(date)
    touch "* marked:'OK'"

    touch "* id:'weight_unit'"
    sleep 0.5
    if unit.match /lb/
      touch "* marked:'lb oz'"
      touch "* id:'weight_input_lb'"
      enter_text "* id:'weight_input_lb'", i
      enter_text "* id:'weight_input_oz'", i
    else
      touch "* marked:'kg'"
      touch "* id:'weight_input'"
      enter_text "* id:'weight_input'", i + d
    end

    touch "* marked:'Save'"
    touch "* contentDescription:'Navigate up'" # back button
  end

  def add_height(args = {})
    scroll_to_growth_chart
    sleep 2
    touch "* id:'height_chart'"
    date = args[:date].to_datetime
    h, unit = args[:height].split(/^(\d+)/)[1..-1]

    touch "* id:'add_button'"
    touch "* id:'date_input'"
    set_date "datePicker", date_str(date)
    touch "* marked:'OK'"
    touch "* id:'height_input'"
    enter_text "* id:'height_input'", h
    touch "* id:'height_unit'"
    sleep 0.5
    touch "* marked:'#{unit.strip.downcase}'"
    touch "* marked:'Save'"
    touch "* contentDescription:'Navigate up'" # back button
  end

  def add_headcirc(args = {})
    scroll_to_growth_chart
    sleep 2
    touch "* id:'head_circumference_chart'"
    date = args[:date].to_datetime
    headcirc, unit = args[:headcirc].split(/^(\d+)/)[1..-1]

    touch "* id:'add_button'"
    touch "* id:'date_input'"
    set_date "datePicker", date_str(date)
    touch "* marked:'OK'"

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
    touch "* id:'weight_unit'"
    touch "* marked:'lb oz'"

    enter_text "* id:'weight_input_lb'", "8"
    enter_text "* id:'weight_input_oz'", "5"
    touch "* id:'height_unit'"
    sleep 1
    touch "* marked:'in'"
    enter_text "* id:'height_input'", "20"
    touch "* id:'head_unit'"
    sleep 1
    touch "* marked:'cm'"
    enter_text "* id:'head_input'", "32"
    touch "* marked:'SAVE'"
    touch "* contentDescription:'Navigate up'"
  end

  def log_symptom(text)
    touch "* marked:'Symptoms'"
    case text
    when "No negative symptoms", "General fussiness", "Rash", "Runny nose"
      touch "android.support.v7.widget.AppCompatTextView marked:'#{text}'"
    when "Fever"
      #pan "android.widget.LinearLayout index:2", :left
      sleep 0.5
      touch "android.support.v7.widget.AppCompatTextView marked:'#{text}'"
      # touch "* id:'temperature'"
      # enter_text "* id:'input'", "102.4"
      # touch "* marked:'Set'"
    when "Funny breathing", "Low energy", "No appetite"
      flick "android.widget.LinearLayout index:2", :left
      sleep 0.5
      touch "android.support.v7.widget.AppCompatTextView marked:'#{text}'"
    end
    touch "* id:'save'"
    touch "* marked:'OK'"
  end

  def add_notes
    touch "* marked:'Note'"
    touch "* id:'note'"
    enter_text "* id:'note'", "Hello Baby"
    touch "* id:'action_save'"
  end

  def add_med
    touch "* marked:'Medicine'"
    touch "* marked:'Amoxicillin'"
    touch "* marked:'OK'"
  end

  def save_more_logs
    touch "* id:'save'"
  end

  def add_upcoming_nurture_baby
    touch "* marked:'Add my baby'"
    touch "* marked:'No, not yet.'"
    touch "* marked:'Choose' sibling UITableViewLabel"
    touch "* marked:'#{$user.relation}'"
    touch "* marked:'Done'"
    touch "* marked:'Start using Glow Baby!'"
    sleep 1
    #wait_for_none_animating
  end

end