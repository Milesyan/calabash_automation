GROUP_ID = 3 # local group id 
TARGET_GROUP_NAME = "1st Child"

module Glow
  class User
    USER_TYPES = %w(non-ttc, ttc, ft)
    TREATMENT_TYPES = %w(prep, med, iui, ivf)

    attr_accessor :email, :password, :type, :partner_email, :treatment_type, :gender
    def initialize(args = {})
      @email = args[:email]
      @password = args[:password]
      @type = args[:type]
      @gender = args[:gender]
      @treatment_type = args[:treatment_type]
    end
  end
end