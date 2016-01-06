require 'calabash-cucumber/ibase'

class HomePage < Calabash::IBase
  def trait
    "*"
  end

  def touch_later_link
    begin
      when_element_exists("* marked:'Later'", :timeout => 3)
    rescue Calabash::Cucumber::WaitHelpers::WaitError
    end
  end

  def finish_tutorial
    when_element_exists("NewDateButton index:2", :timeout => 10)
    wait_for_none_animating
    until_element_does_not_exist("* id:'tutorial-arrow-right'", :action => lambda {swipe :left, :query => "NewDateButton index:2"})
    wait_for_none_animating
    #wait_touch "NewDateButton index:1"
    wait_touch "* marked:'Today'"
    wait_for_none_animating
    from = "NewDateButton index:2"
    to = "* marked:'Complete log!'"
    until_element_does_not_exist("* marked:'Pull down to see the full calendar view'", :action => lambda { pan from, to, duration: 1 } )  
    wait_for_none_animating

    from = "* marked:'WED'"
    to = "* marked:'Sex'" #if ["iui", "ivf", "med", "prep"].include? $user.type
    until_element_does_not_exist("* marked:'Pull down to see the small calendar view'", :action => lambda { pan from, to, duration: 1 })
    wait_for_none_animating
    
    touch_later_link
    wait_for_none_animating
  end

  def finish_tutorial_via_www
    sleep 2
    GlowUser.new(email: $user.email, password: $user.password).logintouch
  end

  def finish_tutorial_for_partner_via_www
    sleep 2
    GlowUser.new(email: $user.partner_email, password: $user.password).logintouch
  end

  def complete_daily_log(gender="female")
    until_element_exists("* marked:'Complete log!'", :action => lambda { swipe :up })
    swipe :up
    wait_for_none_animating
    wait_touch "* marked:'Complete log!'"
    if gender == "female"
      case $user.type.downcase
      when "non-ttc"
        choose_have_sex
        choose_flow

        choose_cm_check
        choose_bbt
        choose_ovulation_test
        choose_pregnancy_test
        choose_cervical_position
        choose_exercise
        choose_weight
        choose_sleep_duration
        choose_smoke
        choose_drink
        choose_physical_symptoms
        choose_stressed
        choose_your_mood

      when "ttc", "ft", "prep", "med", "iui", "ivf"
        choose_flow
        choose_have_sex
        choose_female_orgasm

        choose_cm_check
        choose_bbt
        choose_ovulation_test
        choose_pregnancy_test
        choose_cervical_position
        choose_exercise
        choose_weight
        choose_sleep_duration
        choose_smoke
        choose_drink
        choose_physical_symptoms
        choose_stressed
        choose_your_mood
      when "female-partner"
        choose_flow
        choose_have_sex
        choose_cm_check
        choose_bbt
        choose_ovulation_test
        choose_pregnancy_test

        choose_exercise
        choose_weight
        choose_sleep_duration
        choose_smoke
        choose_drink
        choose_physical_symptoms
        choose_stressed
        choose_your_mood
      end
    elsif gender == "male"
      choose_have_sex_for_male
      choose_erection
      choose_masturbate
      choose_exposed_to_heat_sources
      choose_have_fever

      choose_exercise
      choose_weight
      choose_sleep_duration
      choose_smoke
      choose_drink
      choose_physical_symptoms("male")
      choose_stressed
      choose_your_mood
    end

    wait_for_none_animating
    wait_touch "* marked:'Save all changes'"
    sleep 1
  end

  def keyboard_input(n)
    wait_touch "UIKBKeyView index:#{n}"
  end

  def complete_ft_log
    wait_for_none_animating
    wait_touch "* marked:'Add fertility treatment log'"
    scroll_to_row "UITableView", 0
    wait_touch "* marked:'Did you have blood work done?' sibling GLPillButton index:0"
    wait_touch "* marked:'Estrogen level' sibling GLPillButton index:0"
    keyboard_input 5
    wait_touch "* marked:'Progesterone level' sibling GLPillButton index:0"
    keyboard_input 5
    wait_touch "* marked:'LH level' sibling GLPillButton index:0"
    keyboard_input 5
    wait_touch "* marked:'Done'"
    wait_for_none_animating

    scroll_to_row "UITableView", 1
    wait_for_none_animating

    wait_touch "* marked:'Did you have an ultrasound?' sibling GLPillButton index:0"
    wait_touch "* marked:'# of developed follicles' sibling GLPillButton index:0"
    wait_touch "* marked:'2'"
    wait_touch "* marked:'Done'"
    wait_for_none_animating

    wait_touch "* marked:'Leading follicle size' sibling GLPillButton index:0"
    wait_touch "* marked:'2 mm'"
    wait_touch "* marked:'Done'"
    wait_for_none_animating

    until_element_exists("* marked:'Was an hCG shot administered?'", :action => lambda { swipe :up })
    
    wait_touch "* marked:'Thickness of endometrial lining' sibling GLPillButton index:0"
    wait_touch "* marked:'2 mm'"
    wait_touch "* marked:'Done'"
    wait_for_none_animating

    until_element_exists("* marked:'Medication list'", :action => lambda { swipe :up })
    wait_touch "* marked:'Was an hCG shot administered?' sibling GLPillButton index:0"
    until_element_exists("* marked:'Medication list'", :action => lambda { swipe :up })
    wait_for_none_animating
    wait_touch "* marked:'When' sibling GLPillButton index:0"
    wait_touch "* marked:'Done'"
    until_element_exists("* marked:'Medication list'", :action => lambda { swipe :up })
    wait_for_none_animating

    case $user.type.downcase
    when "iui"
      wait_touch "* marked:'Was your insemination today?' sibling GLPillButton index:0"
    when "ivf"
      wait_touch "* marked:'Was your egg retrieval today?' sibling GLPillButton index:0"
      wait_touch "* marked:'How many?' sibling GLPillButton index:0"
      wait_touch "* marked:'2'"
      wait_touch "* marked:'Done'"
      swipe :up
      wait_for_none_animating
      wait_touch "* marked:'Planning on freezing any embryos for future cycles?' sibling GLPillButton index:0"
      swipe :up
      wait_for_none_animating
      wait_touch "* marked:'Have you frozen any embryos?' sibling GLPillButton index:0"
      wait_touch "* marked:'2'"
      wait_touch "* marked:'Done'"
      wait_for_none_animating
      swipe :up
      wait_touch "* marked:'Was your embryo transfer today?' sibling GLPillButton index:0"
      swipe :up
      wait_touch "* marked:'How many embryos did you transfer?' sibling GLPillButton index:0"
      wait_touch "* marked:'2'"
      wait_touch "* marked:'Done'"
      wait_for_none_animating
      wait_touch "* marked:'Did you use fresh or frozen embryos?' sibling GLPillButton index:0"
      wait_touch "* marked:'Done'"
      wait_for_none_animating
    end

    # Medicatioin list
    until_element_exists("* marked:'Medication list'", :action => lambda { swipe :up })
    swipe :up

    wait_touch "* marked:'Medication list'"
    wait_touch "* marked:'Clomiphene citrate (Clomid; Serophene)' sibling GLPillButton index:0"

    wait_touch "* marked:'Add a new med / supplement'"

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

    wait_touch "* marked:'coriander' sibling GLPillButton index:0"

    wait_touch "UINavigationItemButtonView" # back button

    wait_touch "* marked:'Save all changes'"
    wait_for_none_animating
  end

  def close_insights_popup
    wait_for_none_animating
    begin
      when_element_exists("* id:'icon-cancel-shadow'", :timeout => 5)
    rescue Calabash::Cucumber::WaitHelpers::WaitError
      puts "no popup"
    end
  end

  def choose_have_sex(answer = "yes")
    if answer == "yes"
      wait_touch "* marked:'Did you have sex?' sibling PillButton index:0"
      wait_touch "* marked:'Condom'" if $user.type == "non-ttc"
      wait_touch "* marked:'On top'" if $user.type == "ttc"
    else
      wait_touch "* marked:'Did you have sex?' sibling PillButton index:1"
    end
  end

  def choose_flow(answer = "yes")
    begin
      when_element_exists "* marked:'Record your menstrual flow?' sibling PillButton index:0", :timeout => 2
      wait_touch "* marked:'Heavy'"
    rescue Calabash::Cucumber::WaitHelpers::WaitError
      wait_touch "* marked:'Any spotting?' sibling PillButton index:0"
      wait_touch "* marked:'Light'"
    end
  end

  def choose_cm_check(answer = "no")
    wait_for_none_animating
    # currently default answer is no
    scroll_to_row_with_mark 'Performed CM check?'
    sleep 1
    wait_touch "* marked:'Performed CM check?' sibling PillButton index:0"
  end

  def choose_bbt
    scroll_to_row_with_mark "Update BBT"
    wait_for_none_animating
  end

  def choose_ovulation_test
    #wait_touch "* marked:'Ovulation test' sibling GLPillButton index:0"
    wait_touch "label text:'Pick brand' index:0"
    #wait_touch "* marked:'Clearblue Digital'"
    wait_touch "* marked:'Done'"
    #wait_touch "* marked:'Peak  '"
    wait_touch "* marked:'Low   '"
  end

  def choose_pregnancy_test
    wait_for_none_animating
    scroll_to_row_with_mark "Pregnancy test"
    wait_for_none_animating
    wait_touch "* marked:'Pregnancy test' sibling * marked:'Pick brand'"
    wait_touch "* marked:'Done'"
    wait_touch "* marked:'Not pregnant  '"
  end

  def choose_cervical_position
    wait_touch "* marked:'Cervical position' sibling * marked:'Choose'"
    wait_touch "* marked:'Done'"
    wait_for_none_animating
  end

  def choose_exercise(answer = "yes")
    sleep 1
    scroll_to_row_with_mark "Did you exercise?"
    wait_for_none_animating
    if answer == "yes"
      wait_touch "* marked:'Did you exercise?' sibling PillButton index:0"
      wait_touch "* marked:'30-60 mins'"
    end
  end

  def choose_weight

  end

  def choose_sleep_duration
    scroll_to_row_with_mark "Sleep duration"
    wait_for_none_animating
    wait_touch "* marked:'Sleep duration' sibling * marked:'Choose'"
    wait_touch "* marked:'Done'"
  end

  def choose_smoke
    wait_touch "* marked:'Did you smoke?' sibling PillButton index:0"
  end

  def choose_drink
    wait_for_none_animating
    scroll_to_row_with_mark "Did you drink alcohol?"
    wait_for_none_animating
    wait_touch "* marked:'Did you drink alcohol?' sibling PillButton index:0"
  end

  def choose_physical_symptoms(gendar="female")
    # doc for reference: https://docs.google.com/spreadsheets/d/1vCaaUrlVvfpynhVTU3k8p18tD8YjgW1S-7bLIh8IQ_c/edit#gid=235599258
    scroll_to_row_with_mark "Physical symptoms?"
    wait_for_none_animating
    wait_touch "* marked:'Physical symptoms?' sibling PillButton index:0"
    if gendar == "male"
      sleep 1
      symptoms = (query "all UITableViewCellContentView label", :text).uniq
      scroll_to_row_with_mark "Sick"
      sleep 1
      symptoms += (query "all UITableViewCellContentView label", :text).uniq
      symptoms.uniq!
      # make sure the invisible labels can be queried
      symptoms -= ["Button", "Symptoms", "Mild   Moderate  Severe", nil]
      log_msg "Actual Symptoms: "
      log_msg symptoms
      expected_symptoms = ["Acne", "Backache", "Constipation", "Diarrhea", "Fatigue", "Headache", "Indigestion", "Injury to groin area", "Insomnia", "Pain during sex", "Premature ejaculation", "Sex drive", "Sick"]
      log_msg "Expected Symptoms: "
      log_msg expected_symptoms
      log_error (symptoms - expected_symptoms)
      log_error (expected_symptoms - symptoms)
    end
    wait_touch "* marked:'Done'"
    wait_for_none_animating
  end

  def choose_stressed
    wait_for_none_animating
    scroll_to_row_with_mark 'Feel stressed?'
    wait_for_none_animating
    wait_touch "* marked:'Feel stressed?' sibling PillButton index:0"
  end

  def choose_your_mood
    scroll_to_row_with_mark "Record your mood?"
    wait_for_none_animating
    wait_touch "* marked:'Record your mood?' sibling PillButton index:0"
    wait_touch "* marked:'Angry' sibling PillButton index:0"
    wait_touch "* marked:'Anxious' sibling PillButton index:0"
    wait_touch "* marked:'Done'"
  end

  # for TTC
  def choose_female_orgasm
    # wait_touch "* marked:'Female orgasm?' sibling PillButton index:0"
  end

  def choose_have_sex_for_male(answer="yes")
    if answer == "yes"
      sleep 1
      wait_touch "* marked:'Did you have sex?' sibling PillButton index:0"
      wait_touch "* marked:'Silicon-based'"
    end
  end

  def choose_erection
    wait_touch "* marked:'Did you have trouble maintaining erection?' sibling PillButton index:0"
  end

  def choose_masturbate
    wait_touch "* marked:'Did you masturbate?' sibling PillButton index:0"
    wait_touch "* marked:'2'"
  end

  def choose_exposed_to_heat_sources
    sleep 1
    scroll_to_row_with_mark "Were you exposed to any direct heat sources?"
    wait_for_none_animating
    wait_touch "* marked:'Were you exposed to any direct heat sources?' sibling PillButton index:0"
    wait_touch "* marked:'Saunas'"
  end

  def choose_have_fever
    scroll_to_row_with_mark "Do you have a fever?"
    wait_for_none_animating
    wait_touch "* marked:'Do you have a fever?' sibling PillButton index:0"
    wait_touch "* marked:'2 days'"
  end
end