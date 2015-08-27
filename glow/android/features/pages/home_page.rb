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
      choose_spotting
      choose_sex
      choose_cm_check
      choose_cervical_position
      choose_bbt
    when "ttc", "ft"
      choose_spotting
      choose_ttc_sex
      choose_female_orgasm
      choose_cm_check
      choose_bbt
      choose_cervical_position
    end
    choose_ovulation
    choose_pregnancy
    choose_exercise
    choose_weight
    choose_physical_symptoms
    choose_sleep
    choose_smoke
    choose_alcohol
    choose_emotional
    choose_stress
    choose_medication_list
    save_daily_log
    close_invite_partner
  end

  def complete_ft_log
    sleep 1
    back_to_today
    touch "* id:'log_button_text' * marked:'Add fertility treatment log'"

    case $user.type
    when "ft"
      choose_blood_work
      choose_ultrasound
      choose_hcg_shot
      choose_insemination
      choose_medication_list
    end
  end

  def back_to_today
    if element_exists "* id:'left_back_to_today'"
      touch "* id:'left_back_to_today'"
    end
    if element_exists "* id:'right_back_to_today'"
      touch "* id:'right_back_to_today'"
    end
  end

  def choose_blood_work
    touch "* id:'blood_selector' * id:'yes_selector'"
    touch "* id:'estrogen_spinner'"
    enter_text "* id:'level'", "80"
    touch "* id:'button1'"
    touch "* id:'progesterone_spinner'"
    enter_text "* id:'level'", "80"
    touch "* id:'button1'"
    touch "* id:'lh_spinner'"
    enter_text "* id:'level'", "80"
    touch "* id:'button1'"
  end

  def choose_ultrasound
    scroll_down
    touch "* id:'ultrasound_selector' * id:'yes_selector'"
    scroll_to "* id:'title' * marked:'Was an hCG shot administered?'"
    touch "* id:'num_follicles_spinner'"
    flick "* id:'number_picker'", :up
    touch "* id:'button1'"
    touch "* id:'size_follicles_spinner'"
    touch "* id:'button1'"
    touch "* id:'thickness_spinner'"
    touch "* id:'button1'"
  end

  def choose_hcg_shot
    scroll_down
    touch "* id:'hcg_selector' * id:'yes_selector'"
    touch "* id:'hcg_input_when_spinner'"
    touch "* id:'button1'"
  end

  def choose_insemination
    scroll_down
    touch "* id:'insemination_selector' * id:'yes_selector'"
  end

  def choose_spotting
    touch "* id:'has_spot' * id:'yes_selector'"
    touch "* marked:'Light'"
  end

  def choose_ttc_sex
    touch "* id:'has_sex' * id:'yes_selector'"
    scroll_to("* id:'has_checked_cm'")
    touch "* marked:'In front'"
  end
  def choose_sex
    touch "* id:'has_sex' * id:'yes_selector'"
    scroll_to("* id:'has_checked_cm'")
    touch "* marked:'Condom'"
  end

  def choose_female_orgasm
    touch "* id:'has_orgasm' * id:'yes_selector'"
    scroll_to("* id:'temperature_text_view'")
  end

  def choose_cm_check
    scroll_to("* id:'temperature_text_view'")
    touch "* id:'has_checked_cm' * id:'yes_selector'"
    scroll_to("* id:'temperature_text_view'")
    touch "* marked:'Dry'"
    touch "* marked:'Light'"
  end

  def choose_bbt
    scroll_to("* id:'pregnancy_test_title'")
    touch("* id:'temperature_text_view'")
    enter_text "* id:'bbt_input'", 99
    touch("* id:'button1'")
  end
  def choose_cervical_position
    scroll_to("* id:'pregnancy_test_title'")
    touch "* id:'cervix_text_view'"
    touch("* id:'button1'")
  end

  def choose_ovulation
    scroll_to("* marked:'Did you exercise?'")
    touch "* id:'ovulation_input' * id:'pick_brand'"
    touch "* marked:'Others'"
    touch "* marked:'LH surge'"
  end

  def choose_pregnancy
    scroll_to("* marked:'Did you exercise?'")
    touch "* id:'pregnancy_test_input' * id:'pick_brand'"
    touch "* marked:'Others'"
    scroll_to("* marked:'Did you exercise?'")
    touch "* marked:'Pregnant'"
  end

  def choose_weight
    scroll_to("* marked:'How much sleep?'")
    touch "* id:'weight_text_view'"
    weight = 100 + (rand * 50).round(2)
    enter_text "* id:'weight_editor'", weight
    touch("* id:'button1'")
  end

  def choose_physical_symptoms
    touch "* id:'symptom_selector' * id:'yes_selector'"
    flick "* id:'intensity' index:0", :right
    flick "* id:'intensity' index:1", :right
    touch "* marked:'Done'"
  end

  def choose_sleep
    scroll_to("* marked:'Did you drink alcohol?'")
    touch "* id:'sleep_text_view'"
    touch "* id:'button1'"
  end

  def choose_exercise
    scroll_to("* marked:'How much sleep?'")
    touch "* id:'has_exercise' * id:'yes_selector'"
    scroll_to("* marked:'How much sleep?'")
    touch "* marked:'30–60 mins'"
  end

  def choose_emotional
    scroll_down
    touch "* id:'emotion_selector' * id:'yes_selector'"
    touch "* id:'yes_selector' index:0"
    touch "* id:'yes_selector' index:3"
    touch "* marked:'Done'"
  end

  def choose_smoke
    scroll_to "* marked:'Emotions?'"
    touch "* id:'has_smoked' * id:'yes_selector'"
    flick "* id:'cigarette_number'", :right
  end

  def choose_alcohol
    scroll_down
    touch "* id:'has_drank' * id:'yes_selector'"
    flick "* id:'glass_count'", :right
  end

  def choose_stress
    touch "* id:'is_stressed' * id:'yes_selector'"
    scroll_down
    flick "* id:'stress_level'", :right
  end

  def choose_medication_list
    scroll_down
    touch "* id:'daily_log_medication_list_title'"
    touch "* id:'NoResourceEntry-1'"
    enter_text "* id:'medicine_name'", "abc"
    touch "* id:'medicine_form'"
    touch "* marked:'Cream'"
    enter_text "* id:'medicine_quantity'", "123"
    touch "* id:'add_reminder'"
    touch "* id:'button1'"
    touch "* id:'action_save'"
    touch "* id:'medicine_selector' * id:'yes_selector'"
    touch "* id:'save_medical_list'"
  end

  def save_daily_log
    touch "* id:'save_daily_log'"
  end

  def close_invite_partner
    sleep 3
    if element_exists "* id:'invite_partner_dialog_title'"
      touch "* id:'button2'"
    end
  end

  def finish_tutorial
    touch "* id:'small_view'"
    touch "* marked:'Later'" unless $user.type == "ft"
  end
end