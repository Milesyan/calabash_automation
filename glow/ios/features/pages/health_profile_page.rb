require 'calabash-cucumber/ibase'

class HealthProfilePage < Calabash::IBase
  def trait
    "*"
  end

  def complete_health_profile
    choose_cycle_regularity
    choose_birth_control
    choose_birth_control_start_date
    choose_relationship
    choose_consider_conceiving
    choose_health_conditions
    choose_pregnancy_history
    choose_occupation
    choose_insurance
    choose_physical_activity
    choose_ethnicity
    choose_birth_date
    choose_height
    swipe :down
    wait_for_none_animating
    wait_touch "* id:'back'"
  end

  def back_to_me_page
    wait_touch "* id:'back'"
    wait_for_none_animating
  end

  def choose_cycle_regularity
    wait_touch "* marked:'Cycle regularity'"
    sleep 1
    tap_mark "Regular (variation < 5 days)"
    wait_touch "* marked:'Done'"
  end

  def choose_birth_control
    wait_touch "* marked:'Birth control'"
    wait_touch "* marked:'Done'"
  end

  def choose_birth_control_start_date
    wait_touch "* marked:'Birth control start date'"
    wait_touch "* marked:'OK'"
  end

  def choose_bc_rate
    wait_touch "* marked:'Birth control start date'"
    wait_touch "* marked:'OK'"
  end

  def choose_relationship
    wait_touch "* marked:'Relationship status'"
    wait_touch "* marked:'Single'"
    wait_touch "* marked:'Done'"
  end

  def choose_consider_conceiving
    wait_touch "* marked:'Consider conceiving'"
    wait_touch "* marked:'In the next 12 months'"
    wait_touch "* marked:'Done'"
  end

  def choose_health_conditions
    sleep 1
    scroll_to_row_with_mark "Insurance"
    wait_for_none_animating
    wait_touch "* marked:'Health conditions'"
    wait_for_none_animating
    wait_touch "* marked:'Ovarian cyst(s)'"
    wait_touch "* marked:'PCOS'"
    wait_touch "* marked:'Health Profile'"
    wait_for_none_animating
  end

  def choose_pregnancy_history
    sleep 1
    scroll_to_row_with_mark "Insurance"
    wait_for_none_animating
    wait_touch "* marked:'History of previous pregnancies'"
    wait_for_none_animating
    wait_touch "* marked:'Live Birth'"
    wait_touch "* marked:'0'"
    wait_touch "* marked:'Done'"
    wait_touch "* marked:'Miscarriage'"
    wait_touch "* marked:'0'"
    wait_touch "* marked:'Done'"
    wait_touch "* marked:'Tubal / ectopic pregnancy'"
    wait_touch "* marked:'0'"
    wait_touch "* marked:'Done'"
    wait_touch "* marked:'Abortion'"
    wait_touch "* marked:'0'"
    wait_touch "* marked:'Done'"
    wait_touch "* marked:'Stillbirth'"
    wait_touch "* marked:'0'"
    wait_touch "* marked:'Done'"
    wait_touch "* marked:'Health Profile'"
    wait_for_none_animating
  end

  def choose_occupation
    sleep 1
    scroll_to_row_with_mark "Insurance"
    wait_for_none_animating
    wait_touch "* marked:'Occupation'"
    wait_touch "* marked:'Employed'"
    wait_touch "* marked:'Done'"
  end

  def choose_insurance
    sleep 1
    scroll_to_row_with_mark "Insurance"
    wait_for_none_animating
    wait_touch "* marked:'Insurance'"
    wait_touch "* marked:'HMO/EPO'"
    wait_touch "* marked:'Done'"
  end

  def choose_physical_activity
    sleep 1
    scroll_to_row_with_mark "Height"
    wait_for_none_animating
    wait_touch "* marked:'Physical activity'"
    wait_touch "* marked:'Done'"
  end

  def choose_ethnicity
    sleep 1
    scroll_to_row_with_mark "Height"
    wait_for_none_animating
    wait_touch "* marked:'Ethnicity'"
    wait_touch "* marked:'American Indian / Alaskan Native'"
    wait_touch "* marked:'Done'"
  end

  def choose_birth_date
    sleep 1
    scroll_to_row_with_mark "Height"
    wait_for_none_animating
    wait_touch "* marked:'Birth Date'"
    wait_touch "* marked:'OK'"
  end

  def choose_height
    sleep 1
    scroll_to_row_with_mark "Height"
    wait_for_none_animating
    wait_touch "* marked:'Height'"
    wait_touch "* marked:'Done'"
  end

end