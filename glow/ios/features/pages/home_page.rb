require 'calabash-cucumber/ibase'

class HomePage < Calabash::IBase
  def trait
    "*"
  end

  def finish_tutorial
    sleep 2
    wait_touch "NewDateButton index:2"
    swipe :left, :query => "NewDateButton index:2"
    wait_touch "NewDateButton index:1"
    sleep 1
    from = "NewDateButton index:2"
    to = "* marked:'Complete log!'"
    pan from, to, duration: 1
    from = "* marked:'WED'"
    to = "* marked:'Sex'" if $user.type == "ft"
    sleep 1
    pan from, to, duration: 1
    wait_touch "* marked:'Later'" unless $user.type == "ft"
  end

  def complete_daily_log(gender="female")
    sleep 1
    wait_touch "* marked:'Complete log!'"
    if gender == "female"
      case $user.type
      when "non-ttc"
        choose_have_sex
        choose_flow
      when "ttc", "ft"
        choose_flow
        choose_have_sex
        choose_female_orgasm
      end
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
    elsif gender == "male"
      case $user.type
      when "non-ttc", "ttc", "ft"
        choose_have_sex_for_male
        choose_erection
        choose_masturbate
        choose_exposed_to_heat_sources
        choose_have_fever
      end
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
    wait_touch "* marked:'Record your menstrual flow?' sibling PillButton index:0"
    if answer == "yes"
      wait_touch "* marked:'Record your menstrual flow?' sibling PillButton index:0"
      #wait_touch "* marked:'Heavy'"
    else
      wait_touch "* marked:'Record your menstrual flow?' sibling PillButton index:1"
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