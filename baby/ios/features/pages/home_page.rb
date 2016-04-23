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
    wait_touch "* marked:'No, not yet.'"
    wait_touch "* marked:'Choose' sibling UITableViewLabel"
    wait_touch "* marked:'#{$user.relation}'"
    wait_touch "* marked:'Done'"
    wait_touch "* marked:'Start using Glow Baby!'"
    sleep 1
    wait_for_none_animating
  end

  def add_upcoming_baby(baby)
    wait_touch "* marked:'Add my baby'"
    wait_touch "* marked:'No, not yet.'"
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
    wait_touch "* marked:'Today'"
    #wait_touch "* marked:'Choose date'"
    picker_set_date_time date
    wait_touch "* marked:'Done'"
  end

  def check_first_milestone(args = {})
    wait_touch "UILabel index:0"
    date = (args[:date] || Time.now).to_datetime
    wait_touch "* marked:'Today'"
    picker_set_date_time date
    wait_touch "* marked:'Done'"
  end

  def share_milestone_from_home_page (args = {})
    wait_touch "* marked:'Social milestone achieved'"
    wait_touch "* marked:'button-share'"
    wait_touch "* marked:'Share to community'"
    title = args[:title] || "Hello World!"
    touch "* marked:'Topic title'"
    keyboard_enter_text title
    wait_touch "* marked:'Next'"
    wait_touch "* marked:'Baby Pictures'"
    wait_touch "* marked:'Done!'"
    wait_touch "* marked:'icon close'"
  end

  def share_milestone_from_home_page_with_photo
    wait_touch "UILabel index:2"
    wait_touch "* marked:'button-share'"
    wait_touch "* marked:'Share to community'"
    wait_touch "* marked:'Share!'"
    wait_touch "* marked:'icon close'"
  end
    
  def add_picture_for_milestone
    wait_touch "* id:'icon-photo'"
    wait_touch "* marked:'Choose from library'"
    wait_touch "* marked:'Moments'"
    wait_touch "PUPhotosGridCell index:1"
    wait_touch "* marked:'Save'"
  end

  def skip_share_milestone
    wait_touch "* marked:'Skip'"
  end

  def share_milestone
    group = query "UITableViewLabel"
    touch group.sample
    wait_touch "* marked:'Share!'"
  end

  def save_milestone
    wait_touch "* marked:'Save'"
  end  

  def add_feed(args = {})
    logger.add event_name: "button_click_home_log_card_feed"
    wait_touch "* marked:'FEED' sibling UIImageView index:1"
    feed_type = args[:feed_type].downcase
    milk_type = args[:milk_type].downcase
    start_time = args[:start_time].to_datetime

    if feed_type == "breastfeeding"
      logger.add event_name: "button_click_feed_tab_breast"
      wait_touch "UISegmentLabel marked:'Breastfeeding'"
      logger.add event_name: "page_impression_feed_breast"

    elsif feed_type == "bottle"
      logger.add event_name: "button_click_feed_tab_bottle"
      wait_touch "UISegmentLabel marked:'Bottle'"
      logger.add event_name: "page_impression_feed_bottle"

      if milk_type == "breast"
        logger.add event_name: "button_click_feed_bottle_tab_breast_milk"
        wait_touch "UISegmentLabel marked:'Breast milk'"
      elsif milk_type == "formula"
        logger.add event_name: "button_click_feed_bottle_tab_formla"
        wait_touch "UISegmentLabel marked:'Formula'"
      end
    end
    wait_touch "UIButtonLabel marked:'Save'"
    picker_set_date_time start_time
    wait_touch "* marked:'Done'"
  end

  def add_sleep(args = {})
    logger.add event_name: "button_click_home_log_card_sleep"
    wait_touch "* marked:'SLEEP' sibling UIImageView index:1"
    logger.add event_name: "page_impression_sleep_log"
    log_type = args[:log_type] || "manual"
    start_time = args[:start_time].to_datetime
    end_time = args[:end_time].to_datetime
    if log_type.downcase == "manual"
       if view_with_mark_exists "Or enter manually"
          logger.add event_name: "button_click_sleep_mannual_to_sleep"
          wait_touch "* marked:'Or enter manually'"
        end
      logger.add event_name: "button_click_sleep_manual_begin"
      wait_touch "* marked:'Begin Time' sibling UIButton marked:'Enter'"
      picker_set_date_time start_time
      wait_touch "* marked:'Done'"
      logger.add event_name: "button_click_sleep_manual_end"
      wait_touch "* marked:'End Time' sibling UIButton marked:'Enter'"
      picker_set_date_time end_time
      wait_touch "* marked:'Done'"
    end
    logger.add event_name: "button_click_sleep_save"
    wait_touch "* marked:'Save'"
  end

  def add_diaper(args = {})
    until_element_exists "* marked: 'MORE'", action: lambda { scroll "scrollView index:0", :down }
    logger.add event_name: "button_click_home_log_card_diaper"
    touch "* marked:'DIAPER' sibling UIImageView index:1"
    logger.add event_name: "page_impression_diaper"
    type = args[:type]
    start_time = args[:start_time].to_datetime
    case type.downcase
    when "poo"
      logger.add event_name: "button_click_diaper_poo"
      wait_touch "Noah.Checkbox index:0"
      wait_for_none_animating
      colors = query "Noah.ScrollSelectionView index:0 Noah.ShapeView"
      textures = query "Noah.ScrollSelectionView index:1 Noah.ShapeView"
      logger.add event_name: "button_click_diaper_poo_color"
      touch colors.sample
      wait_for_none_animating
      logger.add event_name: "button_click_diaper_poo_texture"
      touch textures.sample
      wait_for_none_animating
    when "pee"
      logger.add event_name: "button_click_diaper_pee"
      wait_touch "Noah.Checkbox index:1"
    end
    logger.add event_name: "button_click_diaper_save"
    wait_touch "* marked:'Save'"
    picker_set_date_time start_time
    wait_touch "* marked:'Done'"
  end

  def scroll_to_growth_chart
    sleep 1
    wait_for_element_exists "* marked:'FEED'", time_out: 15
    until_element_exists "* marked: 'HEAD CIRC.'", action: lambda { scroll "scrollView index:0", :down }
  end

  def add_baby_birth_data
    sleep 1  # the first time when opening the growth chart
    unless $user.birth_data_added
      touch "* id:'gl-foundation-popup-close'"
      logger.add event_name: "page_impression_dialog_growth_birth_data"
      $user.birth_data_added = true
    end
  end

  def open_growth_chart
    logger.add event_name: "button_ckick_home_growth_chart_weight"
    wait_touch "* marked:'WEIGHT'"
    logger.add event_name: "page_impression_growth_chart"
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

    logger.add event_name: "button_click_growth_data_add"
    touch "* marked:'Weight' sibling UITableViewLabel"
    wait_for_none_animating
    touch "* marked:'#{unit.upcase}'"
    str = %Q[uia.selectPickerValues('#{weight}')]
    uia str
    wait_for_none_animating
    wait_touch "* marked:'Done'"
    logger.add event_name: "button_click_growth_data_save"
    wait_touch "* marked:'Save'"
    logger.add event_name: "page_impression_dialog_growth_data"
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

    logger.add event_name: "button_click_growth_data_add"
    touch "* marked:'Height' sibling UITableViewLabel"
    sleep 1
    touch "* marked:'#{unit.upcase}'"
    #height = %Q[{0 "#{h} #{unit.downcase}"}]
    height = %Q[{0 "#{h}"}]
    str = %Q[uia.selectPickerValues('#{height}')]
    uia str
    wait_for_none_animating
    wait_touch "* marked:'Done'"
    logger.add event_name: "button_click_growth_data_save"
    wait_touch "* marked:'Save'"
    logger.add event_name: "page_impression_dialog_growth_data"
    touch "* id:'icon-close'"
    sleep 1
  end

end