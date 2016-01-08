require 'calabash-cucumber/ibase'

class OnboardPage < Calabash::IBase
  def trait
    "*"
  end

  def login(email, password)
    open_login_link
    wait_touch "* marked:'Email'"
    keyboard_enter_text email
    wait_touch "* marked:'Password'"
    keyboard_enter_text password
    touch "* marked:'Next'"
    sleep 2
  end

  def dismiss_install_message
    if element_exists "* {text CONTAINS 'Congrats'}"
      puts "Add dismiss install"
    end
  end 

  def open_login_link
    wait_touch "* marked:'Log in'"
  end

  def open_forgot_password
    wait_touch "* marked:'Forgot password'"
  end

  def complete_non_ttc_step1
    input_birth_control
    choose_weight
    choose_height
    wait_touch "button marked:'Next'"
  end

  def complete_non_ttc_step2
    choose_average_cycle_length
    choose_last_period
    wait_for_none_animating
    wait_touch "* marked:'Next'"
  end

  def complete_ttc_step1
    choose_ttc_time
    choose_children_number
    choose_weight
    choose_height
    wait_touch "button marked:'Next'"
  end

  def complete_ttc_step2
    choose_average_cycle_length
    choose_last_period
    sleep 1
    wait_touch "* marked:'Next'"
  end

  def complete_ft_step1(treatment_type="")
    choose_fertility_treatment_clinic
    #choose_fertility_testing (removed since Glow 5.2)
    choose_ft_type(treatment_type)
    choose_ft_start_date
    choose_ft_end_date
    choose_ttc_time
    choose_children_number
    wait_touch "* marked:'Next'"
  end

  def complete_ft_step2
    wait_touch "* marked:'Next'"
  end

  def complete_ft_step3
    choose_average_cycle_length
    choose_last_period
    sleep 1
    wait_touch "* marked:'Next'"
  end

  def select_user_type(user = nil)
    wait_for_none_animating
    case $user.type
    when "non-ttc"
      wait_touch "button index:0"
    when "ttc"
      wait_touch "button index:1"
    when "prep", "med", "iui", "ivf"
      wait_touch "button index:2"
    end
  end

  def input_birth_control
    wait_touch "button index:0"
    wait_touch "* marked:'Condom'"
    wait_touch "* marked:'Done'"
  end

  def choose_weight
    wait_touch "button marked:'Weight'"
    wait_touch "* marked:'150'"
    wait_touch "* marked:'Done'"
  end

  def choose_height
    wait_touch "button marked:'Height'"
    wait_touch "* marked:'6 ft'"
    wait_touch "* marked:'0 in'"
    wait_touch "* marked:'Done'"
  end

  def choose_average_cycle_length
    wait_touch "button marked:'-- days'"
    wait_touch "* marked:'30'"
    wait_touch "button marked:'OK'"
  end

  def questions
    wait_for_none_animating
    query "all UILinkLabel", :text
  end

  def choose_ttc_time
    wait_for_none_animating
    q = "How long have you been trying to conceive?"
    scroll_to_row_with_mark q
    sleep 1
    #i = questions.find_index q # find the index of the question
    #wait_touch "PillButton index:#{i}"

    wait_touch "* marked:'How long have you been trying to conceive?' sibling PillButton index:0"
    wait_touch "* marked:'6'"
    wait_touch "button marked:'OK'"
  end

  def choose_children_number
    wait_for_none_animating
    q = "How many children do you have?"
    scroll_to_row_with_mark q
    i = questions.find_index q
    wait_touch "all PillButton index:#{i}"
    wait_touch "* marked:'0'"
    wait_touch "button marked:'OK'"
  end

  def choose_last_period
    wait_touch "button marked:'M/D/Y'"
    #wait_touch "* marked:'#{(Time.now - 3600*48).strftime("%d")}'"
    wait_touch "* marked:'Today'"
    wait_touch "button marked:'Done'"
    wait_for_none_animating
  end

  def choose_fertility_treatment_clinic(name='No one')
    wait_touch "PillButton index:0"
    wait_touch "* marked:'#{name}'"
    wait_touch "* marked:'Done'"
  end

  def choose_fertility_testing
    wait_touch "PillButton index:1"
    tap_mark "Yes"
    wait_touch "* marked:'Done'"
  end

  def choose_ft_type(treatment_type="")
    sleep 1
    wait_touch "PillButton index:1"
    tap_mark("Intrauterine Insemination (IUI)") # in order to let all options be visible
    sleep 1 # necessary, otherwise a wrong option will be selected

    case $user.type.downcase
    when "prep"  
      treatment_type = "Preparing for treatment"
    when "med"
      treatment_type = "Intercourse with fertility med"
    when "iui"
      treatment_type = "Intrauterine Insemination (IUI)"
    when "ivf"
      treatment_type = "In Vitro Fertilization (IVF)"
    end

    wait_touch "* marked:'#{treatment_type}'"
    wait_touch "* marked:'Done'"
  end

  def choose_ft_start_date
    wait_touch "PillButton index:2"
    wait_touch "button marked:'OK'"
  end

  def choose_ft_end_date
    wait_touch "PillButton index:3"
    wait_touch "* marked:'#{(Time.now + 30*24*3600).strftime("%B")}'"
    wait_touch "button marked:'OK'"
  end

  def input_email_password(email, password, full_name = "Glow iOS", is_partner = false)
    wait_touch "* marked:'First & Last name'"
    keyboard_enter_text full_name
    #unless is_partner
      wait_touch "UITextField index:1"
      #set_text "UITextField index:1", email
      keyboard_enter_text email
    #end

    wait_touch "UITextField index:2"
    keyboard_enter_text password
    wait_touch "UITextField index:3"
    wait_touch "* marked:'OK'"

    wait_touch "* marked:'Next'"
    wait_touch "label {text BEGINSWITH 'Yes'}"
    sleep 2
    wait_for_elements_do_not_exist("NetworkLoadingView", :timeout => 60)
  end

  def input_wrong_email_password
    wait_touch "label text:'Email'"
    keyboard_enter_text "doesnotexist@glowtest.com"
    wait_touch "label text:'Password'"
    keyboard_enter_text "123456"
    wait_touch "* marked:'Next'"
    wait_for_elements_do_not_exist("NetworkLoadingView", :timeout => 60)
  end

  def sign_up_partner(gender="Male")

    wait_touch "* marked:'Get Started!'"
    wait_touch "* marked:'Male user? This way'"
    # removed since 5.2
    # verify_partner_email
    # input_partner_info(gender)
    choose_weight
    choose_height
    wait_touch "* marked:'Next'"
    input_email_password($user.partner_email, GLOW_PASSWORD, "Male Partner")
  end

  def sign_up_single_male
    wait_touch "* marked:'Male user? This way'"
    choose_weight
    choose_height
    wait_touch "button marked:'Next'"
    input_email_password($user.email, GLOW_PASSWORD, "Male Partner")
  end

  def verify_partner_email
    wait_touch "UITextFieldLabel"
    keyboard_enter_text $user.partner_email
    wait_touch "* marked:'Next'"
    sleep 1 # verify the email 
  end

  def input_partner_info(gender)
    sleep 1.5
    wait_touch "button index:0"
    wait_touch "* marked:'#{gender}'"
    wait_touch "button marked:'Done'"
  end
end