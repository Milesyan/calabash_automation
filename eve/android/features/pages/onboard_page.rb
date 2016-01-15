require 'calabash-android/abase'
class OnboardPage < Calabash::ABase

  def trait
    #"* id:'partner_sign_up'"
    "*" 
  end

  def tap_login
    puts "TOUCH LOGIN HERE "
    touch "* id:'log_in'"
  end

  def select_user_type(user_type = "")
    case $user.type
    when "non-ttc"
      touch "* id:'nonttc_text'" 
    when "ttc"
      touch "* id:'ttc_text'"
    when "ft", "prep", "med", "iui", "ivf"
      touch "* id:'treatment_text'"
    end
  end

  def sign_up_partner(gender="Male")
    touch "* marked:'Sign up'"
    touch "* id:'male_user'"
    select_bmi
    touch "* marked:'Next'"
    sleep 1
    fill_in_email_password($user.partner_email, GLOW_PASSWORD, full_name="Partner")
  end

  def sign_up_single_male
    touch "* marked:'Sign up'"
    touch "* id:'male_user'"
    select_bmi
    touch "* marked:'Next'"
    sleep 1
    fill_in_email_password($user.email, GLOW_PASSWORD, full_name="Partner")
  end

  def non_ttc_onboard_step1
    select_bmi
    select_birth_control
    touch "* marked:'Next'"
  end

  def non_ttc_onboard_step2
    select_average_cycle_length
    select_last_period
    touch "* id:'next_action'"
  end

  def ttc_onboard_step1
    select_children_number
    fill_in_try_to_conceive_time
    select_bmi
    touch "* marked:'Next'"
  end

  def ttc_onboard_step2
    select_average_cycle_length
    select_last_period
    touch "* id:'next_action'"
  end

  def ft_onboard_step1
    answer_ft_questions
    touch "* marked:'Next'"
  end

  # def ft_onboard_step2
  #   # the questions to answer for fertility test (removed since 3.7)
  #   # touch "* id:'result_spinner' index:0"
  #   # touch "* marked:'Normal'"
  #   # touch "* id:'next_action'"
  # end

  def ft_onboard_step2
    select_average_cycle_length
    select_last_period
    touch "* id:'next_action'"
  end

  def select_bmi
    touch "* id:'bmi_calculator'"
    enter_text "* id:'lb_editor'", "144"
    touch "* id:'ft_spinner'"
    touch "* marked:'5 FT'"
    touch "* id:'in_spinner'"
    touch "* marked:'6 IN'"
    touch "* marked:'Set'"
  end

  def select_birth_control
    touch "* id:'birth_control_selector'"
    touch "* marked:'Condom'"
  end

  def select_last_period
    touch "* id:'first_pb'"
    touch "* id:'month_day'"
    touch "* id:'next_action'" # DONE button
  end

  def select_average_cycle_length
    touch "* id:'cycle_length'"
    touch "* marked:'30 days'"
  end

  def fill_in_email_password(email, pwd, full_name="Glow Test")
    enter_text "* id:'email'", email
    enter_text "* id:'full_name'", full_name
    enter_text "* id:'password'", pwd
    touch "* id:'birthday'"
    #touch "* marked:'Done'"
    touch "* id:'button1'"
    touch "* id:'next_action'" # DONE button
    sleep 2
    wait_for_elements_do_not_exist("* id:'progress'", :timeout => 20)
    sleep 2
    wait_for_elements_do_not_exist("* id:'loading_view'", :timeout => 30)
  end

  def fill_in_try_to_conceive_time
    touch "* id:'ttc_length_text_view'"
    touch "* marked:'Set'"
  end

  def answer_ft_questions
    select_clinic
    #select_test_done #removed in 3.7
    select_ft_type
    select_ft_start_date
    select_ft_end_date
    select_ttc_length
    select_children_number
  end

  def select_clinic(name = 'Boston IVF')
    touch "* id:'clinic'"
    touch "* marked:'#{name}'"
  end

  def select_test_done(yes_or_no = "YES")
    touch "* id:'radio_#{yes_or_no.downcase}'"
  end

  def select_ft_type_old(treatment_type="Preparing for treatment")
    touch "* id:'ft_type'"
    touch "* marked:'#{treatment_type}'"
  end

  def select_ft_type
    unless $user.type.nil?
      case $user.type.downcase
      when "prep"  
        treatment_type = "Preparing for treatment"
      when "med"
        treatment_type = "Intercourse with fertility medication"
      when "iui"
        treatment_type = "Intrauterine Insemination (IUI)"
      when "ivf"
        treatment_type = "In Vitro Fertilization (IVF)"
      end
    end

    touch "* id:'ft_type'"
    touch "* marked:'#{treatment_type}'"
  end

  def select_ft_start_date
    touch "* id:'ft_start_date'"
    #touch "* marked:'Done'"
    touch "* id:'button1'" # Done button
  end

  def select_ft_end_date
    touch "* id:'ft_end_date'"
    #touch "* marked:'Done'"
    touch "* id:'button1'" # Done button
  end

  def select_ttc_length
    touch "* id:'ttc_length_text_view'"
    touch "* marked:'Set'"
  end

  def select_children_number(text = "1")
    touch "* id:'children_count_picker'"
    touch "* marked:'#{text}'"
  end

end