require 'httparty'
require 'faker'
require 'json'
require 'securerandom'
require 'active_support/all'
require_relative 'nurture_test_helper'

module NurtureIOS
  PASSWORD = '111222'
  BASE_URL = "http://dragon-kaylee.glowing.com"

  class NurtureUser
    include NurtureTestHelper
    include HTTParty

    base_uri BASE_URL

    attr_accessor :email, :password, :ut, :res, :user_id, :preg_id
    attr_accessor :due_date, :due_in_weeks, :pregnancy_week
    attr_accessor :insights

    def initialize(args = {})
      @first_name = args[:first_name] || get_first_name
      @last_name = args[:last_name] || "Glow"
      @email = args[:email] || "#{@first_name}@g.com"
      @password = args[:password] || PASSWORD
      @due_in_weeks = args[:due_in_weeks]
      @due_date = args[:due_date].to_i if args[:due_date]
      @pregnancy_week = args[:pregnancy_week]
      @insights = []
    end

    def uuid
      SecureRandom.uuid
    end

    def random_str
      ('0'..'9').to_a.shuffle[0,9].join + "_" + Time.now.to_i.to_s
    end

    def today
      date_str Time.now
    end

    def due_date_in_weeks(n = 40)
      Time.now.to_i + n.to_i*7*24*3600
    end

    def due_date_by_pregnancy_week(n)
      Time.now.to_i + (40 - n.to_i)*7*24*3600
    end

    def common_data
      {
        "app_version": "3.0.0",
        "locale": "en_GB",
        "model": "iPhone7,2",
        "device_id": "D2CB3A14-5FDA-46C6-9A85-C79C76147E1A"
      }
    end

    def auth_common_data
      {
        "app_version": "3.0.0",
        "locale": "en_GB",
        "model": "iPhone7,2",
        "device_id": "D2CB3A14-5FDA-46C6-9A85-C79C76147E1A",
        "ut": @ut
      }
    end

    def options(data)
      { :body => data.to_json, :headers => { 'Content-Type' => 'application/json' }}
    end

    def auth_options(data)
      { :body => data.to_json, :headers => { 'Authorization' => @ut, 'Content-Type' => 'application/json' }}
    end

    def get_first_name
      "ni" + Time.now.to_i.to_s
    end

    def signup(args = {})
      data = {
        "onboardinginfo": {
          "pregnancy_number": 0,
          "appsflyer_install_data": {
            "af_message": "organic install",
            "af_status": "Organic"
          },
          "weight": 67.08639,
          "how": 0,
          "due_date": @due_date || due_date_by_pregnancy_week(@pregnancy_week) || Time.now.to_i + 265*24*3600
        },
        "userinfo": {
          "height": 170,
          "password": @password,
          "tz": "Asia\/Shanghai",
          "last_name": @last_name,
          "birthday": 566452800,
          "email": @email,
          "as_partner": false,
          "first_name": @first_name
        }
      }.merge(common_data)

      @res = self.class.post "/ios/users/signup", options(data)
      if @res["rc"] == 0
        @ut = @res["data"]["encrypted_token"]
        @user_id = @res["data"]["id"]
        @preg_id = @res["data"]["pregnancies"].first["id"]
        puts "#{email} has signed up"
      end
      self
    end

    def signup_partner
      
    end

    def login
      data = {
        userinfo: {
          email: @email,
          tz: "Asia\/Shanghai",
          password: @password
        }
      }.merge(common_data)

      @res = self.class.post "/ios/users/signin", options(data)
      if @res["rc"] == 0
        @ut = @res["data"]["encrypted_token"]
        @user_id = @res["data"]["id"]
        @gender = @res["data"]["gender"]
        @preg_id = @res["data"]["pregnancies"].first["id"]
      end
      self
    end

    def complete_daily_log(args = {})
      date = date_str(args[:date] || Time.now)
      data = {  
       "data":{  
          "breastfeeds":[],
          "miscarriages":[],
          "insights":[  
             {  
                "type":5111
             },
             {  
                "type":5103
             }
          ],
          "checklist":[],
          "pregnancies":[],
          "daily_tasks":[],
          "last_sync_time":1450774113.389712,
          "notes":[  

          ],
          "health_profiles":[  

          ],
          "meds": {
            "Coriander": {
              "id": uuid,
              "form": "Cream",
              "perDosage": 0,
              "name": "Coriander",
              "total": 100,
              "reminderId": uuid
            }
          },
          "daily_data":[  
             {  
                "date": date,
                "val_float":0,
                "user_id": @user_id,
                "val_int":2,
                "val_str":"",
                "data_key":"intercourse"
             },
             {  
                "date": date,
                "val_float":0,
                "user_id": @user_id,
                "val_int":10,
                "val_str":"",
                "data_key":"cm"
             },
             {  
                "val_int":7,
                "date": date,
                "data_key":"alcohol",
                "user_id": @user_id,
                "val_float":0,
                "data_source":"GLHKObjectSourceKaylee",
                "val_str":""
             },
             {  
                "date":date,
                "val_float":0,
                "user_id": @user_id,
                "val_int":1,
                "val_str":"",
                "data_key":"cervixPosition"
             },
             {  
                "val_int":10,
                "date": date,
                "data_key":"exercise",
                "user_id": @user_id,
                "val_float":0,
                "data_source":"GLHKObjectSourceKaylee",
                "val_str":""
             },
             {  
                "val_int":0,
                "date": date,
                "data_key":"weight",
                "user_id": @user_id,
                "val_float":67.08639,
                "data_source":"GLHKObjectSourceKaylee",
                "val_str":""
             },
             {  
                "val_int":2,
                "date": date,
                "data_key":"physicalDiscomfort",
                "user_id": @user_id,
                "val_float":0,
                "data_source":"GLHKObjectSourceKaylee",
                "val_str":"{\"4\":2,\"128\":2,\"16\":2}"
             },
             {  
                "val_int":2,
                "date": date,
                "data_key":"emotionalDiscomfort",
                "user_id": @user_id,
                "val_float":0,
                "data_source":"GLHKObjectSourceKaylee",
                "val_str":"{\"512\":2,\"16\":2,\"256\":2,\"32\":2,\"128\":2}"
             },
             {  
                "val_int":1,
                "date": date,
                "data_key":"pregnancyTest",
                "user_id": @user_id,
                "val_float":0,
                "data_source":"GLHKObjectSourceKaylee",
                "val_str":"Clearblue Digital"
             },
             {  
                "date": date,
                "val_float":0,
                "user_id": @user_id,
                "val_int":6,
                "val_str":"",
                "data_key":"spot"
             },
             {  
                "date": date,
                "val_float":0,
                "user_id": @user_id,
                "val_int":6,
                "val_str":"",
                "data_key":"cramp"
             },
             {  
                "val_int":8,
                "date": date,
                "data_key":"sleep",
                "user_id": @user_id,
                "val_float":0,
                "data_source":"GLHKObjectSourceKaylee",
                "val_str":""
             },
             {  
                "date": date,
                "val_float":0,
                "user_id": @user_id,
                "val_int":3,
                "val_str":"Clearblue Digital",
                "data_key":"ovulationTest"
             },
             {  
                "date": date,
                "val_float":0,
                "user_id": @user_id,
                "val_int":6,
                "val_str":"",
                "data_key":"morningSickness"
             },
             {  
                "val_int":8,
                "date": date,
                "data_key":"water",
                "user_id": @user_id,
                "val_float":0,
                "data_source":"GLHKObjectSourceKaylee",
                "val_str":""
             },
             {  
                "date": date,
                "val_float":0,
                "user_id": @user_id,
                "val_int":10,
                "val_str":"",
                "data_key":"kegel"
             },
             {  
                "val_int":13,
                "date": date,
                "data_key":"smoke",
                "user_id": @user_id,
                "val_float":0,
                "data_source":"GLHKObjectSourceKaylee",
                "val_str":""
             },
             {  
                "date": date,
                "val_float":0,
                "user_id": @user_id,
                "val_int":2,
                "val_str":"",
                "data_key":"vitamin"
             },
             {
                "val_float":0,
                "user_id":2483,
                "val_int":2,
                "data_key":"Coriander",
                "date": date
              }
          ],
          "reminders":[  
             {  
                "uuid": uuid,
                "med_per_take":1,
                "start_date":1450774208,
                "note":"Reminder test ",
                "repeat":1,
                "on":1,
                "user_id": @user_id,
                "title":"Take Coriander",
                "med_per_take_unit":"application",
                "alert":1,
                "frequency":1,
                "is_appt":0
             }
          ],
          "custom_symptoms":[  

          ]
       }
      }.merge(auth_common_data)

      @res = self.class.post "/ios/users/push", options(data)
      if @res["rc"] == 0
        @insights = @res["data"]["insights"]
      end
      self
    end

    def add_vitamin(args)
      date = date_str(args[:date]) || today
      data = {  
        "data":{  
          "last_sync_time": 0,
          "daily_data":[  
            {  
              "val_int":2,
              "date": date,
              "data_key":"vitamin",
              "user_id": @user_id,
              "val_float":0,
              "data_source":"GLHKObjectSourceKaylee",
              "val_str":""
            }
          ]
        }
      }.merge(auth_common_data)

      @res = self.class.post "/ios/users/push", options(data)
      self
    end

    def add_medical_log(args = {})
      date = date_str(args[:date] || Time.now)
      data = {
        "data":{
          "breastfeeds":[

          ],
          "miscarriages":[

          ],
          "insights":[
            {
              "type":701
            },
            {
              "type":802
            },
            {
              "type":630
            }
          ],
          "daily_tasks":[

          ],
          "pregnancies":[

          ],
          "checklist":[

          ],
          "last_sync_time":1450775818.964473,
          "notes":[

          ],
          "health_profiles":[

          ],
          "daily_data":[
            {
              "val_int":6,
              "date": date,
              "data_key":"cervixState",
              "user_id": @user_id,
              "val_float":0,
              "data_source":"GLHKObjectSourceKaylee",
              "val_str":""
            },
            {
              "val_int":2,
              "date": date,
              "data_key":"abdomen",
              "user_id": @user_id,
              "val_float":0,
              "data_source":"GLHKObjectSourceKaylee",
              "val_str":""
            },
            {
              "val_int":0,
              "date": date,
              "data_key":"medicalWeight",
              "user_id": @user_id,
              "val_float":66.6328,
              "data_source":"GLHKObjectSourceKaylee",
              "val_str":""
            },
            {
              "val_int":140,
              "date": date,
              "data_key":"babiesHeartRate",
              "user_id": @user_id,
              "val_float":0,
              "data_source":"GLHKObjectSourceKaylee",
              "val_str":""
            },
            {
              "val_int":80,
              "date": date,
              "data_key":"bloodPressure",
              "user_id": @user_id,
              "val_float":0,
              "data_source":"GLHKObjectSourceKaylee",
              "val_str":"120"
            },
            {
              "val_int":90,
              "date": date,
              "data_key":"heartRate",
              "user_id": @user_id,
              "val_float":0,
              "data_source":"GLHKObjectSourceKaylee",
              "val_str":""
            }
          ],
          "reminders":[

          ],
          "custom_symptoms":[

          ]
        }
      }.merge(auth_common_data)

      @res = self.class.post "/ios/users/push", options(data)
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

      @res = HTTParty.post("#{BASE_URL}/ios/users/answer_question", :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      self
    end

    def name_baby(baby_name="Noah")
      data = {
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
          ]
        }
      }.merge(auth_common_data)

      @res = self.class.post "/ios/users/push", options(data)
      self
    end

    def create_topic
      data = {
        "group_id": 72057594037927937,
        "content": "#{Time.now.to_s}",
        "title": "#{Time.now.to_i}",
        "anonymous": 0
      }.merge(auth_common_data)

      @res =  self.class.post "/ios/forum/topic/create", options(data)
      self
    end

    def reply_to_topic(topic_id)
      data = {
        "topic_id": topic_id,
        "content": "Reply to topic #{Time.now}",
        "anonymous": 0,
        "reply_to": 0
      }.merge(auth_common_data)

      @res =  self.class.post "/ios/forum/create_reply", options(data)
      self
    end
  end
end




