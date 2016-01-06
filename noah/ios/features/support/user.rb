require 'httparty'
require 'json'
PASSWORD = 'Glow12345'

GROUP_ID = 5 # local group id 
#NOTE!!! The TARGET_GROUP_NAME must be corresponding to GROUP_ID
TARGET_GROUP_NAME = "High Risk Pregnancies"

module Glow
  class User
    attr_accessor :email, :password, :type, :partner_email, :treatment_type, :first_name, :last_name, :gender
    attr_accessor :ut, :user_id, :topic_id, :group_id, :reply_id, :reply_content
    attr_accessor :topic_title

    def initialize(args = {})
      @email = args[:email]
      @password = args[:password] || PASSWORD
      @type = args[:type]
      @gender = args[:gender]
      @treatment_type = args[:treatment_type]
      @first_name = args[:first_name]
      @last_name = args[:last_name]
    end

    def random_str
      ('0'..'9').to_a.shuffle[0,9].join + "_" + Time.now.to_i.to_s
    end

    def common_data
      {
        "app_version" => "5.3.0",
        "locale" => "en_US",
        "device_id" => "139E7990-DB88-4D11-9D6B-290BA690C71C",
        "model" => "iPhone7,2",
        "random" => random_str
      }
    end
  end
end

