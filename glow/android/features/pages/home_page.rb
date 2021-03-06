require 'calabash-android/abase'

class HomePage < Calabash::ABase
  def trait
    # "* id:'insight_indicator_title'"
    "*"
  end

  def complete_daily_log(gender = "female")
    sleep 1
    wait_for_elements_exist( "* id:'log_button_text'", :timeout => 10)
    scroll_to "* id:'log_button_text' marked:'Complete log'"
    touch "* id:'log_button_text' marked:'Complete log'"
    if gender.downcase == "female"
      case $user.type.downcase
      when "non-ttc"
        choose_spotting
        choose_sex
        choose_cm_check
        choose_cervical_position
        choose_bbt

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
      when "ttc", "ft", "prep", "med", "iui", "ivf"
        choose_spotting
        choose_ttc_sex
        choose_female_orgasm
        choose_cm_check
        choose_bbt
        choose_cervical_position

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
      when "female-partner"
        choose_exercise
        choose_weight
        choose_physical_symptoms
        choose_sleep
        choose_smoke
        choose_alcohol
        choose_emotional
        choose_stress
        choose_medication_list
      end


      save_daily_log
      close_invite_partner
    elsif gender.downcase == "male"
      choose_sex_for_male
      choose_erection_for_male
      choose_masturbation_for_male
      choose_heat_sources_for_male
      choose_ferver_for_male
      choose_exercise
      choose_weight
      choose_sleep
      choose_smoke
      choose_alcohol
      choose_physical_symptoms
      #choose_emotional
      #choose_stress
      choose_medication_list
      save_daily_log
    end
  end

  def complete_ft_log
    sleep 2
    back_to_today
    wait_for_elements_exist "* id:'log_button_text' * marked:'Add fertility treatment log'"
    touch "* id:'log_button_text' * marked:'Add fertility treatment log'"

    choose_blood_work
    choose_ultrasound
    choose_hcg_shot
    case $user.type
    when "iui"
      choose_insemination
    when 'ivf'
      choose_egg
      choose_frozen_embryos
      choose_transfer_embryo
    end
    choose_medication_list
    save_fertility_treatment_log
  end

  def save_fertility_treatment_log
    touch "* id:'save_medical_log'"
  end

  def back_to_today
    if element_exists "* id:'left_back_to_today'"
      touch "* id:'left_back_to_today'"
    end
    if element_exists "* id:'right_back_to_today'"
      touch "* id:'right_back_to_today'"
    end
  end

  def choose_egg
    touch "* id:'egg_selector' * id:'yes_selector'"
    scroll_to "* marked:'Have you frozen any embryos?'"
    touch "* id:'number_spinner'"
    flick "* id:'number_picker'", :up
    touch "* id:'button1'"
    touch "* id:'plan_selector' * id:'yes_selector'"
  end

  def choose_frozen_embryos
    scroll_down
    touch "* id:'embryos_number'"
    flick "* id:'number_picker'", :up
    touch "* id:'button1'"
  end

  def choose_transfer_embryo
    touch "* id:'transfer_selector' * id:'yes_selector'"
    scroll_down
    touch "* id:'number_spinner'"
    flick "* id:'number_picker'", :up
    touch "* id:'button1'"
    touch "* id:'type_spinner'"
    touch "* marked:'Fresh'"
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
    sleep 1
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

  def choose_sex_for_male
    touch "* id:'has_sex' * id:'yes_selector'"
    touch "* marked:'None'"
  end

  def choose_erection_for_male
    touch "* id:'erection_trouble_input' * id:'no_selector'"
  end

  def choose_masturbation_for_male
    scroll_to "* marked:'Did you masturbate?'"
    touch "* id:'masturbation_input' * id:'no_selector'"
    scroll_down
  end

  def choose_heat_sources_for_male
    scroll_to "* marked:'Direct heat sources?'"
    touch "* id:'heat_sources_input' * id:'yes_selector'"
    touch "* marked:'Saunas'"
  end

  def choose_ferver_for_male
    scroll_to "* marked:'Do you have a fever?'"
    scroll_down
    touch "* id:'fever_input' * id:'yes_selector'"
    touch "* marked:'2 days'"
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
    wait_for(:timeout => 10, :retry_frequency => 2) do
      element_exists "* id:'small_view'"
    end
    touch "* id:'small_view'"
    touch "* marked:'Later'" unless is_ft_user? $user.type
  end
end