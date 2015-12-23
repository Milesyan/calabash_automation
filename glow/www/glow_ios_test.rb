require 'httparty'
require 'json'
require 'securerandom'

module GlowIOS

  PASSWORD = 'Glow12345'
  NEW_PASSWORD = 'Glow1234'
  TREATMENT_TYPES = {"med": 1, "iui": 2, "ivf": 3, "prep": 4}

  # GROUP_ID = 72057594037927939  # sandbox0 Health & Lifestyle
  # SUBSCRIBE_GROUP_ID = 72057594037927938 # sandbox0 Sex & Relationships

  # BASE_URL = "http://dragon-emma.glowing.com"
  # FORUM_BASE_URL = "http://dragon-forum.glowing.com"
  
  GROUP_ID = 4 # local group id 
  SUBSCRIBE_GROUP_ID = 4 # local group id

  BASE_URL = "http://localhost:5010"
  FORUM_BASE_URL = "http://localhost:35010"

  class GlowUser

    attr_accessor :email, :password, :ut, :user_id, :topic_id, :reply_id, :topic_title, :reply_content,:group_id
    attr_accessor :first_name, :last_name, :type, :partner_email, :partner_first_name
    attr_accessor :res
    attr_accessor :gender

    def initialize(args = {})  
      @first_name = args[:first_name] || "gi" + Time.now.to_i.to_s
      @email = args[:email] || "#{@first_name}@g.com"
      @last_name = "Glow"
      @password = args[:password] || PASSWORD
      @partner_email = "p#{@email}"
      @partner_first_name = "p#{@first_name}"
      @gender = args[:gender] || "female"
      @type = args[:type]
    end

    def random_str
      ('0'..'9').to_a.shuffle[0,9].join + "_" + Time.now.to_i.to_s
    end

    def uuid
      SecureRandom.uuid
    end

    def common_data
      {
        "app_version" => "5.3.0",
        "locale" => "en_US",
        "device_id" => "139E7990-DB88-4D11-9D6B-290BA690C71C",
        "model" => "iPhone7,1",
        "random" => random_str,
      }
    end

    def live_periods(n = 3, period_length = 5, cycle_length = 30, day_offset = -25)
      last_pb = (Time.now + day_offset*24*3600)
      periods = []
      n.times do |i|
        pb = last_pb - cycle_length*24*3600*i
        pe = pb + period_length*24*3600
        periods << {"pb": pb.strftime("%Y/%m/%d"), "pe": pe.strftime("%Y/%m/%d"), "flag": 1}
      end
      periods
    end

    def get_daily_content
      data = {
        "force_regenerate": false,
        "date": Time.now.strftime("%Y/%m/%d"),
        "ut": @ut,
        "model": "x86_64"
      }.merge(common_data)

      @res = HTTParty.post("#{BASE_URL}/api/users/daily_content", :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      self
    end

    def ttc_signup(args = {})
      age = args[:age] || 25
      data = {
        "onboardinginfo": {
          "gender": "F",
          "password": @password,
          "last_name": "Glow",
          "birthday": (Time.now - age*365.25*24*3600).to_f,
          "email": @email,
          "timezone": "Asia\/Shanghai",
          "settings": {
            "weight": 68.94604,
            "height": 175.26,
            "current_status": 0,
            "addsflyer_install_data": {
              "appsflyer_uid": "1445424382000-995615",
              "af_message": "organic install",
              "af_status": "Organic"
            },
            "first_pb_date": (Time.now - 14*24*3600).strftime("%Y/%m/%d"),
            "ttc_start": 1431964800,
            "children_number": 3,
            "period_length": 3,
            "period_cycle": 28
          },
          "first_name": @first_name
        }
      }.merge(common_data)

      @res = HTTParty.post("#{BASE_URL}/api/v2/users/signup", :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts email + " has been signed up"
      self
    end

    def non_ttc_signup
      data = {
        "onboardinginfo": {
          "gender": "F",
          "password": @password,
          "last_name": @last_name,
          "birthday": 502788390.87319,
          "email": @email,
          "timezone": "Asia\/Shanghai",
          "settings": {
            "weight": 68.08422,
            "height": 182.88,
            "current_status": 1,
            "birth_control": 1,
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

      @res = HTTParty.post("#{BASE_URL}/api/v2/users/signup", :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts @email + " has been signed up"
      self
    end

    def ft_signup(args = {})
      treatment_type = TREATMENT_TYPES[(args[:type]).downcase.to_sym]

      data = {
        "onboardinginfo": {
          "gender": "F",
          "password": @password,
          "last_name": @last_name,
          "birthday": 502822983.903198,
          "email": @email,
          "timezone": "Asia\/Shanghai",
          "settings": {
            "current_status": 4, # ft
            "treatment_startdate": Time.now.strftime("%Y/%m/%d"),
            "first_pb_date": Time.now.strftime("%Y/%m/%d"),
            "treatment_enddate": (Time.now + 30*24*3600).strftime("%Y/%m/%d"),
            "addsflyer_install_data": {
              "appsflyer_uid": "1449530832000-1814215",
              "af_status": "Organic",
              "af_message": "organic install"
            },
            "ttc_start": 1433692800,
            "children_number": 3,
            "period_length": 3,
            "fertility_treatment": treatment_type,
            "period_cycle": 28
          },
          "first_name": @first_name
        }
      }.merge(common_data)

      @res = HTTParty.post("#{BASE_URL}/api/v2/users/signup", :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts "ft user #{@email} has been signed up"
      self
    end

    def male_signup
      data = {
        "onboardinginfo": {
          "gender": "M",
          "password": @password || PASSWORD,
          "last_name": @last_name || "Glow",
          "birthday": 502820779.817736,
          "email": @email,
          "timezone": "Asia\/Shanghai",
          "settings": {
            "weight": 68.94604,
            "addsflyer_install_data": {
              "appsflyer_uid": "1449530832000-1814215",
              "af_status": "Organic",
              "af_message": "organic install"
            },
            "height": 185.42
          },
          "first_name": @first_name
        }
      }.merge(common_data)

      @res = HTTParty.post("#{BASE_URL}/api/v2/users/signup", :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @ut = @res["user"]["encrypted_token"]
      puts "Male user #{@email} has been signed up"
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

      @res = HTTParty.post("#{BASE_URL}/api/v2/users/push", :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      self
    end

    def male_complete_tutorial
      data = {
        "data": {
          "reminders": [],
          "daily_data": [{
            "user_id": @user_id,
            "period": 0,
            "meds": "",
            "date": "2013\/04\/01"
          }],
          "last_sync_time": 1449529353,
          "daily_checks": [],
          "medical_logs": [],
          "tutorial_completed": 1,
          "settings": {},
          "notifications": []
        },
        "ut": @ut
      }.merge(common_data)

      @res = HTTParty.post("#{BASE_URL}/api/v2/users/push", :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      self
    end

    def login(email = nil, password = nil)
      # the response of login doesn't return the rc code
      login_data = {
        "userinfo": {
          "email": email || @email,
          "password": password || @password
        }
      }.merge(common_data)

      res = HTTParty.post("#{BASE_URL}/api/users/signin", :body => login_data.to_json,
        :headers => { 'Content-Type' => 'application/json' }).to_json

      @res = JSON.parse(res)
      @ut = @res["user"]["encrypted_token"]
      @user_id = @res["user"]["id"]
      self
    end

    def logout
      @ut = nil
    end

    def forgot_password(email)
      data = {
        "userinfo": {
          "email": email
        }
      }.merge(common_data)
      @res = HTTParty.post("#{BASE_URL}/api/users/recover_password", :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' }).to_json
      self
    end

    def complete_daily_log
      daily_data = {
        "data": {
          "reminders": [],
          "last_sync_time": 1447923899,
          "daily_data": [{
            "meds": "{\"Cyanocobalamin Co 57 Schilling Test Kit\":1}",
            "physical_symptom_1": 153722867280912930,
            "weight": 67.58527,
            "intercourse": 274,
            "temperature": 36.44444,
            "alcohol": 8,
            "stress_level": 59,
            "smoke": 13,
            "user_id": @user_id,
            "emotional_symptom_1": 153722867280912930,
            "cervical_mucus": 23130,
            "exercise": 10,
            "ovulation_test": 13,
            "cervical": 4368,
            "date": "2015\/11\/18",
            "period_flow": 130,
            "physical_discomfort": 2,
            "sleep": 28800,
            "physical_symptom_2": 2236962,
            "emotional_symptom_2": 8738,
            "moods": 2,
            "pregnancy_test": 12
          }],
          "daily_checks": [],
          "medical_logs": [],
          "settings": {
            "meds": {
              "Cyanocobalamin Co 57 Schilling Test Kit": {
                "perDosage": 0,
                "id": "C00A9C77-BE00-440E-89FD-DAC8EC9F4896",
                "reminderId": "846c82e7-ab86-4a45-b4f5-4f02e12d792e",
                "total": 100,
                "sourceType": 0,
                "name": "Cyanocobalamin Co 57 Schilling Test Kit",
                "form": "Other"
              }
            }
          },
          "notifications": []
        },
        "ut": @ut
      }.merge(common_data)

      res = HTTParty.post("#{BASE_URL}/api/v2/users/push", :body => daily_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts "#{@email} has completed daily log"
      self
    end

    def ft_complete_daily_log
      log_date  = Time.now.strftime("%Y/%m/%d")
      data = {
        "data": {
          "reminders": [],
          "last_sync_time": 1449532566,
          "daily_data": [],
          "daily_checks": [],
          "medical_logs": [{
            "user_id": @user_id,
            "data_value": "1",
            "data_key": "Medication:Clomiphene citrate (Clomid; Serophene)",
            "date": log_date
          }, {
            "user_id": @user_id,
            "data_value": "15",
            "data_key": "progesteroneLevel",
            "date": log_date
          }, {
            "user_id": @user_id,
            "data_value": "3",
            "data_key": "folliclesSize",
            "date": log_date
          }, {
            "user_id": @user_id,
            "data_value": "15",
            "data_key": "luteinizingHormoneLevel",
            "date": log_date
          }, {
            "user_id": @user_id,
            "data_value": "3",
            "data_key": "folliclesNumber",
            "date": log_date
          }, {
            "user_id": @user_id,
            "data_value": "3",
            "data_key": "uterineLiningThickness",
            "date": log_date
          }, {
            "user_id": @user_id,
            "data_value": "1",
            "data_key": "bloodWork",
            "date": log_date
          }, {
            "user_id": @user_id,
            "data_value": "15",
            "data_key": "estrogenLevel",
            "date": log_date
          }, {
            "user_id": @user_id,
            "data_value": "2",
            "data_key": "hCGTriggerShot",
            "date": log_date
          }, {
            "user_id": @user_id,
            "data_value": "1",
            "data_key": "ultrasound",
            "date": log_date
          }],
          "settings": {},
          "notifications": []
        },
        "ut": @ut
      }.merge(common_data)

      res = HTTParty.post("#{BASE_URL}/api/v2/users/push", :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      self
    end

    def pull_content
      todos = "3985177229087007215"
      activity_rules = "4394188183635176431"
      clinics = "771039131751357848"
      drugs = "5594482260161071637"
      fertile_score = "1915309563115276298"
      predict_rules = "3037978852677495799"
      health_rules = "3809831023003012200"

      params = "&ut=#{@ut.gsub("=","%3D")}"
      common_data.each do |key, value|
        params += "&"
        params += key 
        params += "="
        params += value
      end
      params.gsub(",", "%2C")

      url = "#{BASE_URL}/api/v2/users/pull?rs=&ts=0&sign=todos%3A-#{todos}%7Cactivity_rules%3A-#{activity_rules}%7Cclinics%3A#{clinics}%7Cdrugs%3A#{drugs}%7Cfertile_score%3A-#{fertile_score}%7Cpredict_rules%3A-#{predict_rules}%7Chealth_rules%3A#{health_rules}&#{params}"
      @res = HTTParty.get url
    end

    def sync_empty_periods
      data = {
        "locale": "zh-Hans_GB",
        "app_version": "5.2.1",
        "random": random_str,
        "data": {
          "reminders": [],
          "daily_data": [],
          "last_sync_time": 1440000000,
          "periods": {
            "alive": [],
            "archived": []
          },
          "daily_checks": [],
          "medical_logs": [],
          "settings": {},
          "notifications": []
        },
        "device_id": "139E7990-DB88-4D11-9D6B-290BA690C71C",
        "model": "iPhone7,2",
        "ut": @ut
      }

      res = HTTParty.post("#{BASE_URL}/api/v2/users/push", :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts res
    end

    def add_periods(number_of_cyles = 3)
      data = {
        "data": {
          "reminders": [],
          "daily_data": [],
          "last_sync_time": 1448432172,
          "periods": {
            "alive": live_periods(number_of_cyles),
            "archived": []
          },
          "daily_checks": [],
          "medical_logs": [],
          "settings": {},
          "notifications": []
        },
        "ut": @ut
      }.merge(common_data)

      @res = HTTParty.post("#{BASE_URL}/api/v2/users/push", :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      self
    end

    def upsert_reminder
      # daily reminder
      data = {
        "ut": @ut,
        "reminder": {
          "repeat": 1,
          "frequency": 1,
          "note": "daily reminder",
          "on": 1,
          "title": "Take Lidocaine",
          "uuid": "",
          "med_per_take": 1,
          "med_per_take_unit": "patch",
          "type": 21,
          "start_date0": "2015-12-08-10-45-28"
        }
      }.merge(common_data)

      res =  HTTParty.post("#{BASE_URL}/api/v2/users/upsert_reminder", :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts "#{@email} has set up a reminder"
      self
    end

    def ttc_male_complete_daily_log
      data = {
        "data": {
          "reminders": [],
          "last_sync_time": 1449527955,
          "daily_data": [{
            "intercourse": 2097154,
            "erection": 2,
            "emotional_symptom_1": 153722867280912930,
            "physical_discomfort": 2,
            "emotional_symptom_2": 8738,
            "exercise": 10,
            "fever": 34,
            "physical_symptom_2": 570434050,
            "weight": 68.94604,
            "heat_source": 18,
            "user_id": @user_id,
            "alcohol": 8,
            "stress_level": 54,
            "date": Time.now.strftime("%Y/%m/%d"),
            "meds": "{\"Lidocaine\":1}",
            "moods": 2,
            "physical_symptom_1": 598280388084226,
            "masturbation": 34,
            "sleep": 28800,
            "smoke": 12
          }],
          "daily_checks": [],
          "medical_logs": [],
          "settings": {
            "meds": {
              "Lidocaine": {
                "perDosage": 0,
                "id": uuid,
                "reminderId": uuid,
                "total": 100,
                "sourceType": 0,
                "name": "Lidocaine",
                "form": "Patches"
              }
            }
          },
          "notifications": []
        },
        "ut": @ut
      }.merge(common_data)

      res =  HTTParty.post("#{BASE_URL}/api/v2/users/push", :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts "#{@email} has completed daily log for male"
      self
    end

    ######## Community

    def create_topic(args = {})
      topic_data = {
        "code_name": "emma",
        "content": "#{Time.now.strftime "%D %T"}",
        "title": args[:title] || "#{@email} #{Time.now}",
        "anonymous": 0,
        "ut": @ut
      }.merge(common_data)  # random_str isn't needed
      @group_id = args[:group_id] || GROUP_ID
      @res =  HTTParty.post("#{FORUM_BASE_URL}/ios/forum/group/#{GROUP_ID}/create_topic", :body => topic_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @topic_id = @res["topic"]["id"]
      @group_id = @res["topic"]["group_id"]
      title = @res["topic"]["title"]
      @topic_title = title
      puts "topic >>>>>'#{title}'<<<<< created，topic id is #{topic_id}"
      self
    end

    def create_poll(args = {})
      topic_data = {
        "code_name": "emma",
        "content": "HELLO 123123",
        "anonymous": 0,
        "title": "test aaaaaaaaa",#args[:title] || #{}"#{@email} #{Time.now}",
        "options": ["Field1","Field2","Field3"].to_s,
        "ut": @ut
      }.merge(common_data)

      @res =  HTTParty.post("#{FORUM_BASE_URL}/ios/forum/group/#{GROUP_ID}/create_poll", :body => topic_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      #@topic_id = @res["result"]["id"]
      #title = @res["result"]["title"]
      #puts "topic #{title} created, topic id is #{topic_id}"
      puts @ut
      puts @res
      self
    end

    def vote_poll(args = {})
      vote_data = {
        "code_name": "emma",
        "vote_index": 2,
        "ut": @ut
      }.merge(common_data)
      topic_id = args[:topic_id]
      @res = HTTParty.post("#{FORUM_BASE_URL}/ios/forum/topic/#{topic_id}/vote", :body => vote_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts "Topic #{topic_id} is voted"
      self
    end 


    def reply_to_topic(topic_id, args = {})
      reply_data = {
        "code_name": "emma",
        "content": "Reply to topic #{topic_id} and time is #{Time.now.to_i}",
        "anonymous": 0,
        "reply_to": 0,
        "ut": @ut
      }.merge(common_data)

      @res =  HTTParty.post("#{FORUM_BASE_URL}/ios/forum/topic/#{topic_id}/create_reply", :body => reply_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @reply_id = @res["result"]["id"] 
      self
    end

    def reply_to_comment(topic_id,reply_id)
      reply_data = {
        "code_name": "emma",
        "content": "Reply to topic #{topic_id} and reply #{reply_id}",
        "anonymous": 0,
        "reply_to": reply_id,
        "ut": @ut
      }.merge(common_data)

      @res =  HTTParty.post("#{FORUM_BASE_URL}/ios/forum/topic/#{topic_id}/create_reply", :body => reply_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @reply_id = @res["result"]["id"] 
      self
    end


    def join_group
      data = {
        "code_name": "emma",
        "ut": @ut
      }.merge(common_data)

      @res =  HTTParty.post("#{FORUM_BASE_URL}/ios/forum/group/#{SUBSCRIBE_GROUP_ID}/subscribe", :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts "     -----Join group #{SUBSCRIBE_GROUP_ID}-----    "
      self
    end



    def leave_group(leave_group_id)
      data = {
        "code_name": "emma",
        "ut": @ut
      }.merge(common_data)
      unsubscribe_groupid = leave_group_id || SUBSCRIBE_GROUP_ID
      @res =  HTTParty.post("#{FORUM_BASE_URL}/ios/forum/group/#{unsubscribe_groupid}/unsubscribe", :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts "Leave group #{unsubscribe_groupid}"
      self
    end

    def vote_poll(args = {})
      vote_data = {
        "code_name": "emma",
        "vote_index": 2,
        "ut": @ut
      }.merge(common_data)
      topic_id = args[:topic_id]
      @res = HTTParty.post("#{FORUM_BASE_URL}/ios/forum/topic/#{topic_id}/vote", :body => vote_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts "Topic #{topic_id} is voted"
      self
    end 

    def delete_topic(topic_id)
      reply_data = {
        "code_name": "emma",
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{FORUM_BASE_URL}/ios/forum/topic/#{topic_id}/remove", :body => reply_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      self
      puts "#{topic_id} deleted"
    end


    ###### Me #####

    def change_status(status)
      ttc_to_preg_data = {
        "data": {
          "reminders": [],
          "daily_data": [],
          "last_sync_time": 1447934411,
          "periods": {
            "alive": [{
              "pb": "2015\/11\/05",
              "pe": "2015\/11\/09",
              "flag": 2
            }],
            "archived": []
          },
          "status_history": [],
          "daily_checks": [],
          "medical_logs": [],
          "settings": {
            "current_status": 2,
            "prediction_switch": 0,
            "previous_status": 0,
            "last_pregnant_date": "2015\/11\/19"
          },
          "notifications": []
        },
        "ut": @ut
      }.merge(common_data)

      preg_to_none_ttc_data = {
        "data": {
          "reminders": [],
          "daily_data": [],
          "last_sync_time": 1447935312,
          "status_history": [],
          "daily_checks": [],
          "medical_logs": [],
          "settings": {
            "previous_status": 2,
            "current_status": 3,
            "birth_control": 1
          },
          "notifications": []
        },
        "ut": @ut
      }.merge(common_data)

      case status.downcase
      when "pregnant"
        ttc_to_preg_data[:data][:settings][:current_status] = 2 
      when "ttc"
      when "non-ttc"
      end

      @res = HTTParty.post("http://dragon-emma.glowing.com/api/v2/users/push", :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      self
    end

    def change_password
      data = {
        "userinfo": {
          "user_id": @user_id,
          "password": NEW_PASSWORD
        }
      }.merge(common_data)
      @res = HTTParty.post("http://dragon-emma.glowing.com/api/users/update_password", :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      self
    end

    def invite_partner
      data = {
        "is_mom": 0,
        "email": @partner_email,
        "ut": @ut,
        "name": @partner_first_name
      }.merge(common_data)

      @res = HTTParty.post("#{BASE_URL}/api/users/partner/email", :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts "partner #{@partner_email} has been invited"
      self
    end

    def remove_partner
      data = {
        "ut": @ut
      }.merge(common_data)
      @res = HTTParty.post("#{BASE_URL}/api/users/remove_partner", :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      # if a user is signed up as a partner, then remove 'p' from the email
      if @partner_email.match /^pp/
        puts "partner #{@partner_email.sub('pp','')} has been disconnected"
      else
        puts "partner #{@partner_email} has been disconnected"
      end
      
      self
    end

    def turn_off_period_prediction
      data = {
        "data": {
          "reminders": [],
          "daily_data": [],
          "last_sync_time": 1449635974,
          "periods": {
            "alive": live_periods,
            "archived": []
          },
          "daily_checks": [],
          "medical_logs": [],
          "settings": {
            "prediction_switch": 0
          },
          "notifications": []
        },
        "ut": @ut
      }.merge(common_data)

      @res =  HTTParty.post("#{BASE_URL}/api/v2/users/push", :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      self
    end

    def add_fertility_tests
      today = Time.now.strftime("%Y/%m/%d")
      data = {
        "data": [{
          "test_val": 4,
          "test_key": "fertility_clinic"
        }, {
          "test_val": "Doctor Wu",
          "test_key": "doctor_name"
        }, {
          "test_val": "Nurse Wang",
          "test_key": "nurse_name"
        }, {
          "test_val": today,
          "test_key": "cycle_day_three_blood_work"
        }, {
          "test_val": 15,
          "test_key": "cycle_day_three_blood_work_e2"
        }, {
          "test_val": 15,
          "test_key": "cycle_day_three_blood_work_fsh"
        }, {
          "test_val": 15,
          "test_key": "cycle_day_three_blood_work_lh"
        }, {
          "test_val": 15,
          "test_key": "cycle_day_three_blood_work_prl"
        }, {
          "test_val": 15,
          "test_key": "cycle_day_three_blood_work_tsh"
        }, {
          "test_val": today,
          "test_key": "other_blood_tests"
        }, {
          "test_val": 15,
          "test_key": "other_blood_tests_amh"
        }, {
          "test_val": 1,
          "test_key": "other_blood_tests_infectious_disease"
        }, {
          "test_val": today,
          "test_key": "vaginal_ultrasound"
        }, {
          "test_val": 15,
          "test_key": "vaginal_ultrasound_antral_follicle_count"
        }, {
          "test_val": 15,
          "test_key": "vaginal_ultrasound_lining"
        }, {
          "test_val": today,
          "test_key": "hysterosalpingogram"
        }, {
          "test_val": 1,
          "test_key": "hysterosalpingogram_result"
        }, {
          "test_val": today,
          "test_key": "genetic_screening"
        }, {
          "test_val": 1,
          "test_key": "genetic_screening_result"
        }, {
          "test_val": today,
          "test_key": "saline_sonogram"
        }, {
          "test_val": 1,
          "test_key": "saline_sonogram_result"
        }, {
          "test_val": today,
          "test_key": "ovarian_reserve_testing"
        }, {
          "test_val": 1,
          "test_key": "ovarian_reserve_testing_result"
        }, {
          "test_val": today,
          "test_key": "mammogram"
        }, {
          "test_val": 1,
          "test_key": "mammogram_result"
        }, {
          "test_val": today,
          "test_key": "papsmear"
        }, {
          "test_val": 1,
          "test_key": "papsmear_result"
        }, {
          "test_val": today,
          "test_key": "partner_semen_analysis"
        }, {
          "test_val": 15,
          "test_key": "partner_semen_analysis_volume"
        }, {
          "test_val": 15,
          "test_key": "partner_semen_analysis_concentration"
        }, {
          "test_val": 1515,
          "test_key": "partner_semen_analysis_motility"
        }, {
          "test_val": 1,
          "test_key": "partner_semen_analysis_morphology"
        }, {
          "test_val": today,
          "test_key": "partner_infectious_disease_blood_test"
        }, {
          "test_val": 1,
          "test_key": "partner_infectious_disease_blood_test_result"
        }, {
          "test_val": today,
          "test_key": "partner_genetic_screening"
        }, {
          "test_val": 1,
          "test_key": "partner_genetic_screening_result"
        }],
        "ut": @ut
      }.merge(common_data)

      @res =  HTTParty.post("#{BASE_URL}/api/v2/users/push/fertility_tests", :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      self
    end

    def export_pdf
      pdf_data = {
        "unit": "",
        "email": "linus@glowing.com",
        "ut": @ut
      }.merge(common_data)

      @res =  HTTParty.post("#{BASE_URL}/api/users/export", :body => pdf_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      self
    end

    def female_complete_health_profile(type)
      data = {
        "data": {
          "reminders": [],
          "last_sync_time": 1449574337,
          "daily_data": [],
          "daily_checks": [],
          "medical_logs": [],
          "settings": {
            "miscarriage_number": 1,
            "partner_erection": 1,
            "cycle_regularity": 1,
            "live_birth_number": 1,
            "diagnosed_conditions": 14,
            "relationship_status": 2,
            "insurance": 1,
            "ethnicity": 2,
            "occupation": "Employed",
            "exercise": 8,
            "stillbirth_number": 1,
            "abortion_number": 1,
            "tubal_pregnancy_number": 1,
            "considering": (1 if type.downcase == "non-ttc"),
            "birth_control_start": (Time.now.to_i if type.downcase == "non-ttc"),
            "infertility_diagnosis": (30 if ["iui", "ivf", "med", "prep", "ft"].include?(type.downcase)),
            "height": (170 if ["iui", "ivf", "med", "prep", "ft"].include?(type.downcase))
          },
          "notifications": []
        },
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{BASE_URL}/api/v2/users/push", :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      self
    end
  end
end

# include GlowIOS
# GlowUser.new(email: "1221001@g.com", password: "Glow12345").login.complete_tutorial


