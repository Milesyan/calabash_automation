module Glow
  class User
    USER_TYPES = %w(non-ttc, ttc, ft)
    TREATMENT_TYPES = %w(prep, med, iui, ivf)

    attr_accessor :email, :password, :type, :partner_email, :treatment_type
    def initialize(args = {})
      @email = args[:email]
      @password = args[:password]
      @type = args[:type]
      @treatment_type = args[:treatment_type]
    end
  end
end