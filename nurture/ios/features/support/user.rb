module Nurture
  class User
    attr_accessor :email, :password, :first_name, :type, :partner_name, :partner_email
    def initialize(args = {})
      @email = args[:email]
      @password = args[:password]
      @first_name = args[:first_name]
      @partner_name = args[:partner_name]
      @partner_email = args[:partner_email]
    end
  end

  def fetch_user_by_email(email)
    $user = User.new(email: email, password: PASSWORD)
  end

  def create_user
    email = get_email
    first_name = email.split("@").first
    partner_name = "p#{first_name}"
    partner_email = "#{partner_name}@g.com"
    password = PASSWORD
    $user = User.new(email: email, password: password, first_name: first_name,
                    partner_name: partner_name, partner_email: partner_email)
    puts "User #{$user.email} is created"
  end

  def sign_up_user
    onboard_page.get_started
    onboard_page.step1
    onboard_page.step2
    onboard_page.step3
    sleep 3
  end
end