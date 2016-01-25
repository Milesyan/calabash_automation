require 'calabash-cucumber/ibase'

class HomePage < Calabash::IBase
  def trait
    "*"
  end

  def add_born_baby(baby)
    wait_touch "* marked:'Add my baby'"
    wait_touch "* marked:'Yes!'"
    wait_touch "* marked:'Enter name'"
    keyboard_enter_text baby.first_name + " " + baby.last_name
    wait_touch "* marked:'Sex' sibling UITableViewLabel"
    gender = baby.gender == "M" ? "Boy" : "Girl"
    wait_touch "* marked:'#{gender}'"
    wait_touch "* marked:'Done'"
    wait_touch "* marked:'Birthday' sibling UITableViewLabel"
    picker_set_date_time baby.birthday.to_datetime
    wait_touch "* marked:'Done'"
    wait_touch "* marked:'Due date' sibling UITableViewLabel"
    picker_set_date_time baby.birth_due_date.to_datetime
    wait_touch "* marked:'Done'"
    wait_touch "* marked:'Choose' sibling UITableViewLabel"
    wait_touch "* marked:'#{$user.relation}'"
    wait_touch "* marked:'Done'"
    wait_touch "* marked:'Start using Glow Baby!'"
    sleep 1
    wait_for_none_animating
  end

  def add_upcoming_nurture_baby
    wait_touch "* marked:'Add my baby'"
    wait_touch "* marked:'No, no baby yet.'"
    wait_touch "* marked:'Choose' sibling UITableViewLabel"
    wait_touch "* marked:'#{$user.relation}'"
    wait_touch "* marked:'Done'"
    wait_touch "* marked:'Start using Glow Baby!'"
    sleep 1
    wait_for_none_animating
  end

  def add_upcoming_baby(baby)
    wait_touch "* marked:'Add my baby'"
    wait_touch "* marked:'No, no baby yet.'"
    wait_touch "* marked:'Enter name'"
    keyboard_enter_text baby.first_name + " " + baby.last_name
    wait_touch "* marked:'Due date' sibling UITableViewLabel"
    picker_set_date_time baby.birth_due_date.to_datetime
    wait_touch "* marked:'Done'"
    wait_touch "* marked:'Choose' sibling UITableViewLabel"
    wait_touch "* marked:'#{$user.relation}'"
    wait_touch "* marked:'Done'"
    wait_touch "* marked:'Start using Glow Baby!'"
    sleep 1
    wait_for_none_animating
  end

  def open_milestones
    sleep 1
    wait_touch "* marked:'Add moments'"
  end

  def close_milestones
    wait_touch "* id:'icon-close'"
  end

  def check_milestones
    get_all_milestones.each do |m|
      log_msg m
    end
  end

  def get_all_milestones
    milestones = []
    num_of_milestones = query("NoahFoundation.CheckButton").size
    puts "size: #{num_of_milestones}"
    (0...num_of_milestones).each do |i|
      milestones << query("NoahFoundation.CheckButton index:#{i} sibling UILabel index:0", :text).first
    end
    milestones
  end

  def create_milestone(args = {})
    date = (args[:date] || Time.now).to_datetime
    title = args[:title] || "Hello World!"
    wait_touch "* marked:'Create your own'"

    touch "UITextView"
    keyboard_enter_text title
    wait_touch "* marked:'Choose date'"
    picker_set_date_time date
    wait_touch "* marked:'Done'"

    touch "* marked:'Save'"
  end

  def add_feed(args = {})
    wait_touch "* marked:'FEED' sibling UIImageView index:1"
    feed_type = args[:feed_type].downcase
    milk_type = args[:milk_type].downcase
    start_time = args[:start_time].to_datetime

    if feed_type == "breastfeeding"
      wait_touch "UISegmentLabel marked:'Breastfeeding'"

    elsif feed_type == "bottle"
      wait_touch "UISegmentLabel marked:'Bottle'"

      if milk_type == "breast"
        wait_touch "UISegmentLabel marked:'Breast milk'"
      elsif milk_type == "formula"
        wait_touch "UISegmentLabel marked:'Formula'"
      end
    end

    wait_touch "UIButtonLabel marked:'Save'"
    picker_set_date_time start_time
    wait_touch "* marked:'Done'"
  end

  def add_sleep(args = {})
    wait_touch "* marked:'SLEEP' sibling UIImageView index:1"
    log_type = args[:log_type] || "manual"
    start_time = args[:start_time].to_datetime
    end_time = args[:end_time].to_datetime
    if log_type.downcase == "manual"
      wait_touch "* marked:'Or enter manually'" if view_with_mark_exists "Or enter manually"
      wait_touch "* marked:'Begin Time' sibling UIButton marked:'Enter'"
      picker_set_date_time start_time
      wait_touch "* marked:'Done'"
      wait_touch "* marked:'End Time' sibling UIButton marked:'Enter'"
      picker_set_date_time end_time
      wait_touch "* marked:'Done'"
    end

    wait_touch "* marked:'Save'"
  end

  def add_diaper(args = {})
    until_element_exists "* marked: 'MORE'", action: lambda { scroll "scrollView index:0", :down }
    touch "* marked:'DIAPER' sibling UIImageView index:1"
    type = args[:type]
    start_time = args[:start_time].to_datetime
    case type.downcase
    when "poo"
      wait_touch "Noah.Checkbox index:0"
      wait_for_none_animating
      colors = query "Noah.ScrollSelectionView index:0 Noah.ShapeView"
      textures = query "Noah.ScrollSelectionView index:1 Noah.ShapeView"
      touch colors.sample
      wait_for_none_animating
      touch textures.sample
      wait_for_none_animating
    when "pee"
      wait_touch "Noah.Checkbox index:1"
    end

    wait_touch "* marked:'Save'"
    picker_set_date_time start_time
    wait_touch "* marked:'Done'"
  end

  def scroll_to_growth_chart
    sleep 1
    wait_for_element_exists "* marked:'FEED'", time_out: 15
    until_element_exists "* marked: 'Growth Chart'", action: lambda { scroll "scrollView index:0", :down }
  end

  def add_baby_birth_data
    sleep 1  # the first time when opening the growth chart
    unless $user.birth_data_added
      touch "* id:'gl-foundation-popup-close'"
      $user.birth_data_added = true
    end
  end

  def open_growth_chart
    wait_touch "* marked:'WEIGHT'"
    wait_for_none_animating
    add_baby_birth_data
  end

  def add_weight(args = {})
    open_growth_chart
    date = args[:date].to_datetime
    i, d, unit = args[:weight].split(/^(\d+)(.\d+)/)[1..-1]
    weight = %Q[{0 "#{i}" 1 "#{d}"}]

    wait_touch "* id:'button-plus'"
    touch "* marked:'Date' sibling UITableViewLabel"
    sleep 1
    picker_set_date_time date
    wait_touch "* marked:'Done'"

    touch "* marked:'Weight' sibling UITableViewLabel"
    wait_for_none_animating
    touch "* marked:'#{unit.upcase}'"
    str = %Q[uia.selectPickerValues('#{weight}')]
    uia str
    wait_for_none_animating
    wait_touch "* marked:'Done'"
    wait_touch "* marked:'Save'"
    touch "* id:'icon-close'"
    sleep 1
  end

  def add_height(args)
    open_growth_chart
    date = args[:date].to_datetime
    h, unit = args[:height].split(/^(\d+)/)[1..-1]
    unit.strip!

    wait_touch "* id:'button-plus'"
    touch "* marked:'Date' sibling UITableViewLabel"
    sleep 1
    picker_set_date_time date
    wait_touch "* marked:'Done'"

    touch "* marked:'Height' sibling UITableViewLabel"
    sleep 1
    touch "* marked:'#{unit.upcase}'"
    height = %Q[{0 "#{h} #{unit.downcase}"}]
    str = %Q[uia.selectPickerValues('#{height}')]
    uia str
    wait_for_none_animating
    wait_touch "* marked:'Done'"
    wait_touch "* marked:'Save'"
    touch "* id:'icon-close'"
    sleep 1
  end

end