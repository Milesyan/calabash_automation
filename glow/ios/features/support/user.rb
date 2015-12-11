require 'httparty'
require 'json'

PASSWORD = 'Glow12345'
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

    def female_non_ttc_signup
      @first_name = "gi" + Time.now.to_i.to_s
      @last_name = "Glow"
      @email = "#{@first_name}@g.com"

      data = {
        "onboardinginfo": {
          "gender": "F",
          "password": @password,
          "last_name": "Last",
          "birthday": 502788390.87319,
          "email": @email,
          "timezone": "Asia\/Shanghai",
          "settings": {
            "weight": 68.08422,
            "height": 182.88,
            "current_status": 1,
            "birth_control": 1,
            # "first_pb_date": "2015\/12\/01",
            "first_pb_date": (Time.now).strftime("%Y/%m/%d"),
            "addsflyer_install_data": {
              "appsflyer_uid": "1449524733000-6694994",
              "af_status": "Organic",
              "af_message": "organic install"
            },
            "period_cycle": 29,
            "period_length": 3
          },
          "first_name": @first_name
        }
      }.merge(common_data)

      res = HTTParty.post("#{BASE_URL}/api/v2/users/signup", :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts @email + " has been signed up"
      self
    end

    def female_ttc_signup(args = {age: 25})
      @first_name = "gi" + Time.now.to_i.to_s
      @last_name = "Glow"
      @email = "#{first_name}@g.com"

      data = {
        "onboardinginfo": {
          "gender": "F",
          "password": PASSWORD,
          "last_name": @last_name,
          "birthday": (Time.now - args[:age]*365.25*24*3600).to_f,
          "email": @email,
          "timezone": "Asia\/Shanghai",
          "settings": {
            "weight": 68.94604,
            "height": 175.26,
            "current_status": 0,  # TTC
            "addsflyer_install_data": {
              "appsflyer_uid": "1445424382000-995615",
              "af_message": "organic install",
              "af_status": "Organic"
            },
            # "first_pb_date": (Time.now - 14*24*3600).strftime("%Y/%m/%d"),
            "first_pb_date": (Time.now).strftime("%Y/%m/%d"),
            "ttc_start": 1431964800,
            "children_number": 3,
            "period_length": 3,
            "period_cycle": 28
          },
          "first_name": @first_name
        }
      }.merge(common_data)

      res = HTTParty.post("#{BASE_URL}/api/v2/users/signup", :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts @email + " has been signed up"
      self
    end

    def login
      login_data = {
        "userinfo": {
          "email": @email,
          "password": @password
        }
      }.merge(common_data)
      res = HTTParty.post("#{BASE_URL}/api/users/signin", :body => login_data.to_json,
        :headers => { 'Content-Type' => 'application/json' }).to_json

      json_res = JSON.parse(res)
      @ut = json_res["user"]["encrypted_token"]
      @user_id = json_res["user"]["id"]
      self
    end

    def complete_tutorial
      data = {
        "data": {
          "daily_data": [],
          "reminders": [],
          "last_sync_time": Time.now.to_i - 100,
          "daily_checks": [],
          "apns_device_token": "c51e6117d259fd10db680e040570d4f6994d5234d0da21fa543a2abff552aa6b",
          "medical_logs": [],
          "tutorial_completed": 1,
          "settings": {},
          "notifications": []
        },
        "ut": @ut
      }.merge(common_data)

      res = HTTParty.post("#{BASE_URL}/api/v2/users/push", :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      self
    end
  end
end