module Glow
  class User
    USER_TYPES = %w(non-ttc, ttc, ft)
    TREATMENT_TYPES = %w(prep, med, iui, ivf)

    attr_accessor :email, :password, :type, :partner_email, :treatment_type, :first_name, :last_name, :gender
    attr_accessor :topic_title
    def initialize(args = {})
      @email = args[:email]
      @password = args[:password]
      @type = args[:type]
      @gender = args[:gender]
      @treatment_type = args[:treatment_type]
      @first_name = args[:first_name]
      @last_name = args[:last_name]
    end
  end
end