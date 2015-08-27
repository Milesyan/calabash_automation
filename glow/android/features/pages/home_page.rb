require 'calabash-android/abase'

class HomePage < Calabash::ABase
  def trait
    # "* id:'insight_indicator_title'"
    "*"
  end

  def complete_daily_log
    sleep 1
    touch "* id:'log_button_text'"

    case $user.type
    when "non-ttc"
      # Any spotting?
      touch "* id:'has_spot' * id:'yes_selector'"
      # "* id:'has_spot' * id:'no_selector'"

      # Did you have sex?
      touch "* id:'has_sex' * id:'yes_selector'"
      # "* id:'has_sex' * id:'no_selector'"
      touch "* marked:'None'"

      # Performed CM check?
      touch "* id:'has_checked_cm' * id:'yes_selector'"
      # "* id:'has_checked_cm' * id:'no_selector'"
      touch "* marked:'Dry'"
      touch "* marked:'Heavy'"
      # Cervical position
      touch "* id:'cervix_text_view'"
      touch "* marked:'DONE'"
      # Today's BBT?
      touch "* id:'temperature_text_view'"
      enter_text "* id:'bbt_input'", (99 + rand.round(2)).to_s
      touch "* marked:'DONE'"
      # Ovulation test
      touch "* id:'pick_brand'"
      touch "* marked:'Clearblue Digital'"
      touch "* marked:'LOW'"
      # Pregnancy test
      touch "* id:'pregnancy_test_input' * id:'pick_brand'"
      touch "* marked:'Clearblue Digital'"
      touch "* marked:'Not pregnant'"
      # Did you exercise?
      # Today's weight
      # Physical symptoms?
      # How much sleep
      # Did you smoke?
      # Did you drink alcohol?
      # Emotions?
      # Feel stressed?
      # Medication list
      touch "* marked:'Save daily log'"
    end
  end

  def choose_spotting
    
  end

  def choose_weight
    touch "* id:'weight_text_view'"
    weight = 100 + (rand * 50).round(2)
    enter_text "* id:'weight_editor'", weight
    touch "* marked:'DONE'"
  end

  def choose_physical_symptoms
    touch "* id:'symptom_selector' * id:'yes_selector'"
    flick "* id:'intensity' index:0", :right
    flick "* id:'intensity' index:1", :right
    touch "* marked:'DONE'"
  end

  def choose_sleep
    touch "* id:'sleep_text_view'"
    touch "* marked:'DONE'"
  end

  def choose_physical
    touch "* id:'has_exercise' * id:'yes_selector'"
    touch "* marked:'30-60 mins'"
    choose_weight
  end

  def choose_emotional
    touch "* id:'emotion_selector' * id:'yes_selector'"
    touch "* id:'yes_selector' index:0"
    touch "* id:'yes_selector' index:3"
    touch "* marked:'Done'"
  end

  def finish_tutorial
    touch "* id:'small_view'"
    touch "* marked:'Later'" unless $user.type == "ft"
  end
end