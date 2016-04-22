require 'faker'

module BabyAndroid

  class User
    attr_accessor :email, :password, :first_name, :last_name, :gender, :birthday, :relation
    attr_accessor :partners
    attr_accessor :babies, :current_baby

    def initialize(args = {})
      @first_name = args[:first_name] || get_first_name
      @email = args[:email] || "#{@first_name}@g.com"
      @last_name = "Glow"
      @relation = args[:relation]
      @partners = []
      @password = args[:password] || PASSWORD
      @birthday = args[:birthday]
      @babies = []
    end

    def random_str(n)
      (10...36).map{ |i| i.to_s 36}.shuffle[0,n.to_i].join
    end

    def get_first_name
      "ba" + Time.now.to_i.to_s[2..-1] + random_str(2)
    end

  end
end