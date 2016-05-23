require 'httparty'
require 'json'
require 'securerandom'

module NurtureIOS
  NURTURE_PASSWORD = '111222'
  NURTURE_BASE_URL = "http://dragon-kaylee.glowing.com"

  def due_date_in_weeks(n = 40)
    Time.now.to_i + n.to_i*7*24*3600
  end

  def due_date_by_pregnancy_week(n)
    Time.now.to_i + (40 - n.to_i)*7*24*3600
  end

  class NurtureUser
    include HTTParty
    base_uri NURTURE_BASE_URL

    attr_accessor :email, :password, :ut, :res, :user_id, :preg_id
    attr_accessor :due_date, :due_in_weeks, :pregnancy_week
    attr_accessor :first_name, :last_name

    def initialize(args = {})
      @first_name = args[:first_name] || create_first_name
      @last_name = args[:last_name] || "Glow"
      @email = args[:email] || "#{@first_name}@g.com"
      @password = args[:password] || NURTURE_PASSWORD
      @due_in_weeks = args[:due_in_weeks]
      @due_date = args[:due_date]
      @pregnancy_week = args[:pregnancy_week]
    end

    def uuid
      SecureRandom.uuid
    end

    def random_str
      ('0'..'9').to_a.shuffle[0,9].join + "_" + Time.now.to_i.to_s
    end

    def date_str(n=0)
      (Time.now + n*24*3600).strftime("%Y/%m/%d")
    end

    def create_first_name
      "ni" + Time.now.to_i.to_s
    end

    def options(data)
      { :body => data.to_json, :headers => { 'Content-Type' => 'application/json' }}
    end

    def signup(args = {})
      data = {
        "app_version": "2.6.0",
        "locale": "en_GB",
        "model": "iPhone7,2",
        "device_id": "D2CB3A14-5FDA-46C6-9A85-C79C76147E1A",
        "onboardinginfo": {
          "pregnancy_number": 0,
          "appsflyer_install_data": {
            "af_message": "organic install",
            "af_status": "Organic"
          },
          "weight": 67.08639,
          "how": 0,
          "due_date": @due_date || Time.now.to_i + 265*24*3600
          #due_date_by_pregnancy_week(@pregnancy_week) 
        },
        "userinfo": {
          "height": 170,
          "password": NURTURE_PASSWORD,
          "tz": "Asia/Shanghai",
          "last_name": "G",
          "birthday": 566452800,
          "email": @email,
          "as_partner": false,
          "first_name": @first_name
        }
      }

      @res = self.class.post("/ios/users/signup", options(data))
      @ut = @res["data"]["encrypted_token"]
      @user_id = @res["data"]["id"]
      @preg_id = @res["data"]["pregnancies"].first["id"]
      puts "#{email} has signed up"
      self
    end

    def invite_partner(args = {})
      email = args[:email]
      name = args[:first_name] || "#{Nurture Glow}"
      data = {
        "locale": "zh-Hans_GB",
        "app_version": "2.7.0",
        "device_id": "B0738BFB-D31E-41FF-885C-E9C7F13EA7EA",
        "model": "iPhone7,2",
        "email": email,
        "ut": @ut,
        "name": name
      }

      @res = self.class.post "/ios/users/partner/email", options(data)
      self
    end

    def fill_baby_info
      data = {  
        "app_version":"2.7.0",
        "data":{  
          "breastfeeds": [],
          "miscarriages": [],
          "insights":[  
            {  
              "type": 5103
            },
            {  
              "type": 5111
            }
          ],
          "daily_tasks": [],
          "pregnancies":[  
            {  
              "baby_name": "Baby Glow",
              "id": 296
            }
          ],
          "checklist": [],
          "last_sync_time": 1453620355.18372,
          "notes":[  

          ],
          "health_profiles":[  
            {  
              "tag": 296,
              "babies_info": "[{\"baby_info_name\":\"Baby Glow\"}]"
            }
          ],
          "daily_data":[],
          "reminders":[],
          "custom_symptoms":[]
        },
        "locale":"zh-Hans_GB",
        "ut":"HMC8tVnA5NsVfWrDTe-wMG9NnuzYnHLfxRhdLoVayHh9HOZjrrpLdPt9PFjVSyGv",
        "device_id":"B0738BFB-D31E-41FF-885C-E9C7F13EA7EA",
        "model":"iPhone7,2"
      }
    end

    def login
      login_data = {
        app_version: "2.7.0",
        locale: "en_US",
        model: "x86_64",
        device_id: "C747A1F6-E63F-4D9D-8770-401E535FF3C6",
        userinfo: {
          email: @email,
          tz: "Asia/Shanghai",
          password: @password
        }
      }
      @res = self.class.post("/ios/users/signin", options(data))
      @ut = @res["data"]["encrypted_token"]
      @user_id = @res["data"]["id"]
      @gender = @res["data"]["gender"]
      @preg_id = @res["data"]["pregnancies"].first["id"]
      self
    end

    def answer_name_question(name="Noah")
      data = {
        "locale":"zh-Hans_GB",
        "app_version":"2.7.0",
        "answer": name,
        "option":"",
        "device_id":"525474F0-57E4-4EDD-BF2A-9A79C823A671",
        "model":"iPhone7,2",
        "ut": @ut,
        "question_id":1
      }

      @res = self.class.post("/ios/users/answer_question", options(data))
      self
    end

    def name_baby(baby_name="Noah")
      data = {
        "app_version":"2.7.0",
        "data":{
          "pregnancies":[
            {
              "baby_name": baby_name,
              "id": @preg_id
            }
          ],

          "last_sync_time":1450776899.375457,
          # [{"tag":197,"babies_info":"[{\"baby_info_name\":\"Jjjjack\"}]"}]
          "health_profiles":[
            {
              "tag": @preg_id,
              "babies_info": [{ "baby_info_name": baby_name}]
            }
          ],
        },
        "locale":"zh-Hans_GB",
        "ut": @ut,
        "device_id":"525474F0-57E4-4EDD-BF2A-9A79C823A671",
        "model":"iPhone7,2"
      }
      @res = self.class.post("/ios/users/push", options(data))
      self
    end
  end
end