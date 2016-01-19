def new_ttc_user
  GlowUser.new(type: "ttc").ttc_signup.login.complete_tutorial
end
  
def new_non_ttc_user
  GlowUser.new(type: "non-ttc").non_ttc_signup.login.complete_tutorial
end

def new_ft_user(args = {})
  GlowUser.new(type: args[:type]).ft_signup(args).login.complete_tutorial
end

Given(/^I create a new "(.*?)" glow user$/) do |type|
  case type.downcase
  when "non-ttc"
    $user = new_non_ttc_user.complete_tutorial
  when "ttc"
    $user = new_ttc_user.complete_tutorial
  when "prep", "med", "iui", "ivf"
    $user = new_ft_user(type: type).complete_tutorial
  when "single male"
    $user = GlowUser.new(gender: "male").male_signup.complete_tutorial
  end
end

Given(/^I create a new "([^"]*)" user with cycle length (\d+) days and period start date "([^"]*)"$/) do |type, cycle_length, first_pb|
  $user = GlowUser.new(type: type, cycle_length: cycle_length.to_i, first_pb: eval(first_pb)).method("#{type.downcase}_signup").call.login.complete_tutorial
end

Given(/^I create a new "(.*?)" "(.*?)" glow partner user$/) do |type, gender|
  case type.downcase
  when "non-ttc"
    u = new_non_ttc_user.invite_partner
    if gender.downcase == "male"
      $user = GlowUser.new(gender: "male", email: u.partner_email, first_name: u.partner_first_name).male_signup.complete_tutorial
    elsif gender.downcase == "female"
      $user = GlowUser.new(gender: "female", type: "female-partner", email: u.partner_email, first_name: u.partner_first_name).ttc_signup.login.complete_tutorial
      # secondary user should follow the primary user's status
    end
  when "ttc"
    u = new_ttc_user.invite_partner
    if gender.downcase == "male"
      $user = GlowUser.new(gender: "male", email: u.partner_email, first_name: u.partner_first_name).male_signup.complete_tutorial
    elsif gender.downcase == "female"
      $user = GlowUser.new(gender: "female", type: "female-partner", email: u.partner_email, first_name: u.partner_first_name).non_ttc_signup.login.complete_tutorial
      # secondary user should follow the primary user's status
    end
  when "prep", "med", "iui", "ivf"
    u = new_ft_user(type: type.downcase).invite_partner
    if gender.downcase == "male"
      $user = GlowUser.new(gender: "male", email: u.partner_email, first_name: u.partner_first_name).male_signup.complete_tutorial
    elsif gender.downcase == "female"
      $user = GlowUser.new(gender: "female", type: "female-partner", email: u.partner_email, first_name: u.partner_first_name).non_ttc_signup.login.complete_tutorial
      # secondary user should follow the primary user's status
    end
  end
end

Given(/^I complete my health profile via www$/) do
  $user.female_complete_health_profile($user.type)
end
