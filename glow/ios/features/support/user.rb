require 'httparty'
require 'json'

PASSWORD = '111222'
GROUP_ID = 72057594037927939  # sandbox0 Health & Lifestyle
SUBSCRIBE_GROUP_ID = 72057594037927938 # sandbox0 Sex & Relationships

BASE_URL = "http://dragon-emma.glowing.com"
FORUM_BASE_URL = "http://dragon-forum.glowing.com"

module Glow
  class User
    USER_TYPES = %w(non-ttc, ttc, ft)
    TREATMENT_TYPES = %w(prep, med, iui, ivf)

    attr_accessor :email, :password, :type, :partner_email, :treatment_type, :first_name, :last_name, :gender
    attr_accessor :ut, :user_id, :topoc_id
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