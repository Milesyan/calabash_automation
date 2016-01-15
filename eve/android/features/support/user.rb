GROUP_ID = 5 # local group id 
#NOTE!!! The TARGET_GROUP_NAME must be corresponding to GROUP_ID
TARGET_GROUP_NAME = "High Risk Pregnancies"

# BASE_URL = "http://localhost:5010"
# FORUM_BASE_URL = "http://localhost:35010"

GLOW_ANDROID_BASE_URL = "http://titan-emma.glowing.com"
GLOW_ANDROID_BASE_FORUM_URL = "http://titan-forum.glowing.com/android/forum"  
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