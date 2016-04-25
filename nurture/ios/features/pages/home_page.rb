require 'calabash-cucumber/ibase'

class HomePage < Calabash::IBase
  def trait
    "*"
  end

  def finish_tutorial
    #wait_for_elements_exist("all * marked:'Swipe left or right to navigate through days'", :timeout => 20)
    #wait_for_element_exists "all * marked:'Here\\'s how you use Glow Nurture!'", :time_out => 20
    #wait_for_elements_exist("all * { text BEGINSWITH 'Swipe left or'}", :timeout => 20)
    
    sleep 1
    #until_element_does_not_exist("all * marked:'Swipe left or right to navigate through days'", action: lambda {flick "UIScrollView", {x:50, y:0}; sleep 1})
    #flick "UIScrollView", {x:50, y:0}
    scroll "UIScrollView", :right
    sleep 0.5
    swipe :down
    wait_for_elements_exist "* marked:'TODAY'", :timeout => 10
    touch "* marked:'TODAY'"
    sleep 1
    wait_for_elements_exist "GLHomeDailyLogEntryCell", :timeout => 10
    sleep 1
    touch "GLHomeDailyLogEntryCell"
    wait_for_none_animating
    touch "* id:'back'"
    sleep 1
  end

  def close_insights_popup
    sleep 1
    wait_for(:timeout => 10, :retry_frequency => 1) do
      element_exists "* id:'icon-cancel-shadow'"
    end
    touch "* id:'icon-cancel-shadow'"
  end

  def keyboard_input(n)
    wait_touch "UIKBKeyView index:#{n}"
  end

  # Always asked
  def did_you_take_your_prenatal_vitamin
    wait_touch "* marked:'Did you take your prenatal vitamin?' sibling PillButton index:0"
  end

  def update_weight
    until_element_exists "* marked:'Update your weight'", action: lambda { swipe :up }
    swipe :up
    wait_touch "* marked:'Update your weight' sibling PillButton"
    wait_touch "* marked:'Done'"
  end

  def did_you_exercise
    until_element_exists "* marked:'Did you exercise?'", action: lambda { swipe :up }
    swipe :up
    wait_touch "* marked:'Did you exercise?' sibling PillButton index:0"
    wait_touch "* marked:'30-60 mins'"
  end

  def did_you_drink_water
    until_element_exists "* marked:'Did you drink water?'", action: lambda { swipe :up }
    swipe :up
    wait_touch "* marked:'Did you drink water?' sibling PillButton index:0"
    slider_set_value "UISlider", 5
    sleep 1
  end

  def did_you_do_kegels
    wait_touch "* marked:'Did you do kegels? (set of ten 3x a day)' sibling PillButton index:0"
    wait_touch "* marked:'2 sets'"
  end

  def sleep_duration
    until_element_exists "* marked:'Your sleep duration'", action: lambda { swipe :up }
    swipe :up
    wait_touch "* marked:'Your sleep duration' sibling PillButton index:0"
    wait_touch "* marked:'Done'"
  end

  def emotional_discomfort
    until_element_exists "* marked:'Emotional discomfort?'", :action => lambda {swipe :up}
    swipe :up
    wait_touch "* marked:'Emotional discomfort?' sibling PillButton index:0"
    wait_touch "PillButton index:0"
    wait_touch "PillButton index:1"
    wait_touch "* marked:'Done'"
  end

  # Week 1 - 4

  def did_you_have_sex
    until_element_exists "* marked:'Did you have sex?'", :action => lambda {swipe :up}
    swipe :up
    wait_touch "* marked:'Did you have sex?' sibling PillButton index:0"
  end

  def have_orgasm
    
  end

  def cm_check
    until_element_exists "* marked:'Performed CM check?'", :action => lambda {swipe :up}
    swipe :up
    wait_touch "* marked:'Performed CM check?' sibling PillButton index:0"
    wait_touch "* marked:'White & creamy'"
  end

  def cervical_position
    until_element_exists "* marked:'Cervical position'", :action => lambda {swipe :up}
    swipe :up
    wait_touch "* marked:'Cervical position' sibling PillButton index:0"
    wait_touch "* marked:'Done'"
  end

  def any_spotting
    until_element_exists "* marked:'Any spotting?'", :action => lambda {swipe :up}
    swipe :up
    wait_touch "* marked:'Any spotting?' sibling PillButton index:0"
    wait_touch "* marked:'Light'"
    wait_touch "* marked:'Pink'"
  end

  def physical_symptoms
    until_element_exists "* marked:'Physical symptoms?'", :action => lambda {swipe :up}
    swipe :up
    wait_touch "* marked:'Physical symptoms?' sibling PillButton index:0"
    wait_touch "UITableViewCellContentView index:0 UIButton index:0"
    wait_touch "UITableViewCellContentView index:1 UIButton index:0"
    wait_touch "* marked:'Done'"
  end

  def ovulation_test
    until_element_exists "* marked:'Ovulation test'", :action => lambda {swipe :up}
    2.times { swipe :up }
    wait_touch "* marked:'Ovulation test' sibling PillButton index:0"
    wait_touch "* marked:'Done'"
    wait_touch "* marked:'Peak  '"
  end

  def pregnancy_test
    until_element_exists "* marked:'Pregnancy test'", :action => lambda {swipe :up}
    swipe :up
    wait_touch "* marked:'Pregnancy test' sibling PillButton index:0"
    wait_touch "* marked:'Done'"
    wait_touch "* marked:'   Pregnant      '"
  end

  def did_you_drink_alcohol
    until_element_exists "* marked:'Did you drink alcohol?'", action: lambda { swipe :up }
    2.times { swipe :up }
    wait_touch "* marked:'Did you drink alcohol?' sibling PillButton index:0"
    slider_set_value "UISlider", 8
    sleep 1
  end

  def did_you_smoke
    until_element_exists "* marked:'Did you smoke?'", action: lambda { swipe :up }
    swipe :up
    wait_touch "* marked:'Did you smoke?'"
    wait_touch "* marked:'Did you smoke?' sibling PillButton index:0"
    slider_set_value "UISlider index:1", 3
    sleep 1
  end

  def choose_medication
    until_element_exists "* marked:'Add a new med \/ supplement'", action: lambda { swipe :up }
    swipe :up
    wait_touch "* marked:'Add a new med \/ supplement'"

    wait_touch "* marked:'Enter name'"
    keyboard_enter_text "coriander"
    wait_touch "label {text  ENDSWITH 'as a new entry'}"
    wait_touch "* marked:'Tablet'"
    wait_touch "* marked:'Done'"
    wait_for_none_animating

    until_element_exists("UIKBKeyView", :action => lambda { touch "UITextField index:1" })
    keyboard_input 5
    wait_touch "* marked:'Done'"
    wait_for_none_animating
    wait_touch "* marked:'Save'"
    wait_touch "* marked:'coriander' sibling PillButton index:0"
  end

  # 5 - 13

  def general_discomfort
    until_element_exists "* marked:'General symptoms?'", action: lambda { swipe :up }
    swipe :up
    wait_touch "* marked:'General symptoms?' sibling PillButton index:0"
    wait_touch "UITableViewCellContentView index:0 UIButton index:0"
    wait_touch "UITableViewCellContentView index:1 UIButton index:0"
    wait_touch "UITableViewCellContentView index:2 UIButton index:0"
    wait_touch "* marked:'Done'"
  end

  def gastrointestinal_discomfort
    until_element_exists "* marked:'Gastrointestinal symptoms?'", action: lambda { swipe :up }
    swipe :up
    wait_touch "* marked:'Gastrointestinal symptoms?' sibling PillButton index:0"
    wait_touch "UITableViewCellContentView index:0 UIButton index:0"
    wait_touch "UITableViewCellContentView index:1 UIButton index:0"
    wait_touch "* marked:'Done'"
  end

  def any_unusual_symptoms
    until_element_exists "* marked:'Any unusual symptoms?'", action: lambda { swipe :up }
    swipe :up
    wait_touch "* marked:'Any unusual symptoms?' sibling PillButton index:0"
    wait_touch "UITableViewCellContentView index:0 UIButton index:0"
    wait_touch "UITableViewCellContentView index:1 UIButton index:0"
    wait_touch "* marked:'Done'"
  end

  def do_you_have_cramps
    until_element_exists "* marked:'Do you have cramps?'", :action => lambda {swipe :up}
    2.times { swipe :up }
    wait_touch "* marked:'Do you have cramps?' sibling PillButton index:0"
    wait_touch "* marked:'Light & intermittent'"
  end

  def morning_sickness
    until_element_exists "* marked:'Morning sickness?'", :action => lambda {swipe :up}
    2.times { swipe :up }
    wait_touch "* marked:'Morning sickness?' sibling PillButton index:0"
    wait_touch "* marked:'Occasional nausea'"
  end

  def vaginal_discharge
    until_element_exists "* marked:'Vaginal discharge?'", :action => lambda {swipe :up}
    2.times { swipe :up }
    wait_touch "* marked:'Vaginal discharge?' sibling PillButton index:0"
    wait_touch "UITableViewCellContentView index:0 UIButton index:0"
    wait_touch "UITableViewCellContentView index:1 UIButton index:0"
    wait_touch "UITableViewCellContentView index:2 UIButton index:0"
    wait_touch "UITableViewCellContentView index:3 UIButton index:0"
    wait_touch "* marked:'Done'"
  end


  # 14 - 26

  def braxton_hicks_contractions
    until_element_exists "* marked:'Braxton hicks contractions?'", :action => lambda {swipe :up}
    2.times { swipe :up }
    wait_touch "* marked:'Braxton hicks contractions?' sibling PillButton index:0"
    wait_touch "* marked:'< 8 in an hour'"
  end

  def second_trimester_symptoms
    until_element_exists "* marked:'2nd trimester symptoms?'", :action => lambda {swipe :up}
    2.times { swipe :up }
    wait_touch "* marked:'2nd trimester symptoms?' sibling PillButton index:0"
    wait_touch "UITableViewCellContentView index:0 UIButton index:0"
    wait_touch "UITableViewCellContentView index:1 UIButton index:0"
    wait_touch "* marked:'Done'"
  end

  def third_trimester_symptoms
    until_element_exists "* marked:'3rd trimester symptoms?'", :action => lambda {swipe :up}
    2.times { swipe :up }
    wait_touch "* marked:'3rd trimester symptoms?' sibling PillButton index:0"
    wait_touch "UITableViewCellContentView index:0 UIButton index:0"
    wait_touch "UITableViewCellContentView index:1 UIButton index:0"
    wait_touch "* marked:'Done'"
  end

  def complete_daily_log_new
    wait_touch "* marked:'Complete log'"
    case $user.pregnancy_week.to_i
    when 1..4
      did_you_take_your_prenatal_vitamin
      did_you_do_kegels
      did_you_have_sex
      cm_check
      cervical_position
      any_spotting
      do_you_have_cramps
      morning_sickness
      ovulation_test
      pregnancy_test

      update_weight
      did_you_exercise
      did_you_drink_water
      sleep_duration
      physical_symptoms
      did_you_drink_alcohol
      did_you_smoke

      emotional_discomfort
      choose_medication
    when 5..13
      did_you_take_your_prenatal_vitamin
      did_you_do_kegels
      any_spotting
      do_you_have_cramps

      morning_sickness
      vaginal_discharge

      update_weight
      did_you_exercise
      did_you_drink_water
      sleep_duration
      general_discomfort
      gastrointestinal_discomfort
      any_unusual_symptoms

      did_you_drink_alcohol
      did_you_smoke

      emotional_discomfort
      choose_medication

    when 14..26
      did_you_take_your_prenatal_vitamin
      did_you_do_kegels
      any_spotting
      do_you_have_cramps
      braxton_hicks_contractions
      morning_sickness
      vaginal_discharge
      second_trimester_symptoms

      update_weight
      did_you_exercise
      did_you_drink_water
      sleep_duration
      general_discomfort
      gastrointestinal_discomfort
      any_unusual_symptoms

      emotional_discomfort
      choose_medication
    when 27..42
      did_you_take_your_prenatal_vitamin
      did_you_do_kegels
      any_spotting
      do_you_have_cramps
      braxton_hicks_contractions
      vaginal_discharge
      third_trimester_symptoms

      update_weight
      did_you_exercise
      did_you_drink_water
      sleep_duration
      general_discomfort
      gastrointestinal_discomfort
      any_unusual_symptoms

      emotional_discomfort
      choose_medication
    end

    touch "* marked:'Save all changes'"
    sleep 2
  end

  def complete_daily_log
    wait_touch "* marked:'Complete log'"
    did_you_take_your_prenatal_vitamin
    did_you_do_kegels
    any_spotting
    do_you_have_cramps

    morning_sickness
    vaginal_discharge
    update_weight

    did_you_exercise
    did_you_drink_water

    sleep_duration
    general_discomfort
    gastrointestinal_discomfort
    any_unusual_symptoms
    did_you_drink_alcohol
    did_you_smoke
    emotional_discomfort
    choose_medication

    touch "* marked:'Save all changes'"
    sleep 1
  end
end