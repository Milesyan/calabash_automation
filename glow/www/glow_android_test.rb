require 'httparty'
require 'json'
require 'net/http'
# require_relative 'test_miles'

module GlowAndroid

  PASSWORD = 'Glow12345'
  TREATMENT_TYPES = {"med": 1, "iui": 2, "ivf": 3, "prep": 4}
  GROUP_ID = 5
  GLOW_ANDROID_BASE_URL = "http://titan-emma.glowing.com"
  GLOW_ANDROID_BASE_FORUM_URL = "http://titan-forum.glowing.com/android/forum"  
  # GLOW_ANDROID_BASE_URL = "http://192.168.1.39:5010"
  # GLOW_ANDROID_BASE_FORUM_URL = "http://192.168.1.39:35010/android/forum"
 
   
  #GLOW_ANDROID_BASE_URL = "https://www.glowing.com"
  #FORUM_BASE_URL = "http://titan-forum.glowing.com"

  class GlowUser
    attr_accessor :email, :password, :ut, :user_id, :topic_id, :reply_id, :topic_title, :reply_content,:group_id,:all_group_ids
    attr_accessor :first_name, :last_name, :type, :partner_email, :partner_first_name
    attr_accessor :res
    attr_accessor :gender

    def initialize(args = {})  
      @first_name = (args[:first_name] || "ga") + ('0'..'3').to_a.shuffle[0,3].join + Time.now.to_i.to_s[-4..-1]
      @email = args[:email] || "#{@first_name}@g.com"
      @last_name = "Glow"
      @password = args[:password] || PASSWORD
      @partner_email = "p#{@email}"
      @partner_first_name = "p#{@first_name}"
      @gender = args[:gender] || "female"
      @type = args[:type]
      @forum_hl = "en_US"
      @forum_fc = 1
      @forum_random = random_str
      @forum_device_id = "be3ca737160d" + ('0'..'9').to_a.shuffle[0,4].join
      @forum_android_version = "3.8.0-play-beta"
      @forum_vc = 376
      @forum_time_zone = "America%2FNew_York"
      @forum_code_name = "emma"
    end

    def random_str
      Time.now.to_i.to_s + ('0'..'9').to_a.shuffle[0,4].join
    end

    def assert_rc(res)
      assert_equal 0, res["rc"]
    end

    def date_str(n=0)
      (Time.now + n*24*3600).strftime("%Y/%m/%d")
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

    def additional_post_data
      {
        "code_name": "emma",
        "time_zone": "Asia Shanghai",
        "vc": 380,
        "android_version": "3.8.0-play-beta",
        "device_id": "be3ca737160d9da3",
        "random": random_str,
        "fc": 1,
        "hl": "en_US"
      }
    end

    def ttc_signup(args = {})
      age = args[:age] || 25
      data = {
        "user": {
          "android_version": "3.8.0-play-beta",
          "birthday": (Time.now.to_i - age*365*24*3600),
          "first_name": @first_name,
          "timezone": "China Standard Time",
          "email": @email,
          "settings": {
            "time_zone": 8,
            "height": 185.4199981689453,
            "weight": 68.03880310058594,
            "first_pb_date": (Time.now - 14*24*3600).strftime("%Y/%m/%d"),
            "ttc_start": 1433853037,
            "period_cycle": 28,
            "period_length": 3,
            "current_status": 0,
            "children_number": 2
          },
          "last_name": "Glow",
          "gender": "F",
          "password": @password,
          "notifications_read": false
        }
      }

      @res = HTTParty.post("#{GLOW_ANDROID_BASE_URL}/a/v2/users/signup", :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @ut = @res["user"]["encrypted_token"]
      @user_id = @res["user"]["id"]
      puts email + " has been signed up"
      puts "User id is #{@user_id}"
      self
    end

    def non_ttc_signup
      data = {
        "user": {
          "android_version": "3.8.0-play-beta",
          "birthday": 427048062,
          "first_name": @first_name,
          "timezone": "China Standard Time",
          "email": @email,
          "settings": {
            "time_zone": 8,
            "birth_control": 1,
            "height": 198.1199951171875,
            "weight": 65.31724548339844,
            "first_pb_date": (Time.now).strftime("%Y/%m/%d"),
            "ttc_start": 0,
            "period_cycle": 29,
            "period_length": 4,
            "current_status": 3
          },
          "last_name": "Glow",
          "gender": "F",
          "password": @password,
          "notifications_read": false
        }
      }

      @res = HTTParty.post("#{GLOW_ANDROID_BASE_URL}/a/v2/users/signup", :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      # json_res = eval(res.to_s)
      @ut = @res["user"]["encrypted_token"]
      @user_id = @res["user"]["id"]
      puts @email + " has been signed up"
      self
    end

    def ft_signup(args = {})
      treatment_type = TREATMENT_TYPES[(args[:type]).downcase.to_sym]
      treatment_startdate = first_pb_date = date_str(-20) # the treatment cycle started 20 days ago
      treatment_enddate = date_str(10)
      data = {
        "user": {
          "notifications_read": false,
          "settings": {
            "first_pb_date": first_pb_date, 
            "period_cycle": 30,
            "period_length": 4,
            "children_number": 2,
            "ttc_start": 1433849314,
            "current_status": 4,
            "fertility_treatment": treatment_type,
            "treatment_startdate": treatment_startdate,
            "treatment_enddate": treatment_enddate,
            "time_zone": 8
          },
          "first_name": @first_name,
          "last_name": "Glow",
          "gender": "F",
          "birthday": 427116514,
          "email": @email,
          "password": @password,
          "timezone": "China Standard Time",
          "android_version": "3.8.0-play-beta",
          "fertility_test": {
            "fertility_clinic": 4
          }
        }
      }

      @res = HTTParty.post("#{GLOW_ANDROID_BASE_URL}/a/v2/users/signup", :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @ut = @res["user"]["encrypted_token"]
      @user_id = @res["user"]["id"]
      puts @email + " has been signed up"
      self
    end

    def male_signup
      data = {
        "user": {
          "notifications_read": false,
          "settings": {
            "ttc_start": 0,
            "weight": 70.3067626953125,
            "height": 185.4199981689453,
            "time_zone": 8
          },
          "first_name": @first_name,
          "last_name": "Glow",
          "gender": "M",
          "birthday": 427117497,
          "email": @email,
          "password": @password,
          "timezone": "China Standard Time",
          "android_version": "3.8.0-play-beta"
        }
      }

      @res = HTTParty.post("#{GLOW_ANDROID_BASE_URL}/a/v2/users/signup", :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @ut = @res["user"]["encrypted_token"]
      @user_id = @res["user"]["id"]
      puts @email + " has been signed up"
      self
    end

    def complete_tutorial
      data = {
        "data": {
          "reminders": [],
          "last_sync_time": 0,
          "tutorial_completed": 1,
          "settings": {
            "time_zone": 8
          },
          "notifications_read": false
        }
      }

      @res = HTTParty.post("#{GLOW_ANDROID_BASE_URL}/a/v2/users/push", :body => data.to_json,
        :headers => { "Authorization" => @ut, 'Content-Type' => 'application/json' })
      self
    end

    def login(email = nil, password = nil)
      data = {
        "email": email || @email,
        "password": password || @password
      }.merge(additional_post_data)

      # puts "debug #{data}"
      # puts "#{@res} res"
      @res = HTTParty.post("#{GLOW_ANDROID_BASE_URL}/a/users/signin", :body => data.to_json,
        :headers => {'Content-Type' => 'application/json' })
      @ut = @res["user"]["encrypted_token"] if @res["rc"] == 0
      self
    end

    def logout
      # @ut = nil
      # self
      data = additional_post_data
      @res = HTTParty.post("#{GLOW_ANDROID_BASE_URL}/a/users/logout", :body => data.to_json,
        :headers => { "Authorization" => @ut, 'Content-Type' => 'application/json' })
      self
    end

    def forgot_password(email)
      data = {
        "email": email
      }.merge(additional_post_data)

      @res = HTTParty.post("#{GLOW_ANDROID_BASE_URL}/a/users/recover_password", :body => data.to_json,
        :headers => {'Content-Type' => 'application/json' })
      self
    end

    def pull_content
      todos = "3985177229087007215"
      activity_rules = "4394188183635176431"
      clinics = "771039131751357848"
      drugs = "5594482260161071637"
      fertile_score_coef = "7468128932913297878"
      fertile_score = "1915309563115276298"
      predict_rules = "3037978852677495799"
      health_rules = "3809831023003012200"
      ts = Time.now.to_i.to_s

      params = "&ut=#{@ut.gsub("=","%3D")}"
      additional_post_data.each do |key, value|
        params += "&"
        params += key.to_s
        params += "="
        params += value.to_s
      end
      params.gsub(",", "%2C")
  
      url = "#{GLOW_ANDROID_BASE_URL}/a/v2/users/pull?ts=0&sign=todos%3A%7Cactivity_rules%3A%7Cclinics%3A%7Cfertile_score_coef%3A%7Cfertile_score%3A%7Cpredict_rules%3A%7Chealth_rules%3A&#{params}"
      #url = "#{GLOW_ANDROID_BASE_URL}/a/v2/users/pull?ts=#{ts}&sign=todos%3A-#{todos}%7Cactivity_rules%3A-#{activity_rules}%7Cclinics%3A%7Cfertile_score_coef%3A-#{fertile_score_coef}%7Cfertile_score%3A-#{fertile_score}%7Cpredict_rules%3A-#{predict_rules}%7Chealth_rules%3A#{health_rules}&#{params}"
      @res = HTTParty.get url
      self
    end

    ######## Home #######
    def ttc_female_complete_daily_log(args = {})
      data = {
        "data": {
          "reminders": [],
          "daily_data": [{
            "ovulation_test": 13,
            "emotional_symptom_1": 153722867280912930,
            "weight": 55.338223,
            "emotional_symptom_2": 8738,
            "cervical_mucus": 2570,
            "moods": 2,
            "exercise": 10,
            "physical_symptom_2": 3355443,
            "meds": "{\"Sodium Aminosalicylate\":2}",
            "sleep": 28800,
            "date": args[:date] || Time.now.strftime("%Y/%m/%d"),
            "period_flow": 18,
            "stress_level": 67,
            "physical_discomfort": 2,
            "physical_symptom_1": 76880198638903569,
            "smoke": 13,
            "temperature": 37.333332,
            "pregnancy_test": 12,
            "intercourse": 274,
            "alcohol": 8,
            "cervical": 4368
          }],
          "last_sync_time": 0,
          "tutorial_completed": 1,
          "settings": {
            "time_zone": 8,
            "meds": {
              "Sodium Aminosalicylate": {
                "id": "46726351-267a-4568-ad8c-980510b23f9a",
                "total": 100,
                "perDosage": 0,
                # "reminderId": "14501784794316c75a409e88439e3",
                "form": "Tablet",
                "name": "Sodium Aminosalicylate"
              }
            }
          },
          "notifications_read": false
        }
      }
      @res = HTTParty.post("#{GLOW_ANDROID_BASE_URL}/a/v2/users/push", :body => data.to_json,
        :headers => { "Authorization" => @ut, 'Content-Type' => 'application/json' })
      self
    end

    def non_ttc_female_complete_daily_log(args = {})
      data = {
        "data": {
          "reminders": [],
          "daily_data": [{
            "ovulation_test": 13,
            "emotional_symptom_1": 153722867280912930,
            "weight": 65.317245,
            "emotional_symptom_2": 8738,
            "cervical_mucus": 2570,
            "moods": 2,
            "exercise": 10,
            "physical_symptom_2": 3355443,
            "sleep": 28800,
            "date": args[:date] || Time.now.strftime("%Y/%m/%d"),
            "period_flow": 10,
            "stress_level": 54,
            "physical_discomfort": 2,
            "physical_symptom_1": 230584227620524305,
            "smoke": 13,
            "temperature": 36.72222,
            "pregnancy_test": 12,
            "intercourse": 8194,
            "alcohol": 9,
            "cervical": 4368
          }],
          "last_sync_time": 0,
          "tutorial_completed": 1,
          "settings": {
            "time_zone": 8,
            "meds": {
              "Acilac": {
                "id": "3828f73f-df19-4466-b2e6-76bfe02f9ba8",
                "total": 100,
                "perDosage": 0,
                "reminderId": "",
                "form": "Tablet",
                "name": "Acilac"
              }
            }
          },
          "notifications_read": false
        }
      }

      @res = HTTParty.post("#{GLOW_ANDROID_BASE_URL}/a/v2/users/push", :body => data.to_json,
        :headers => { "Authorization" => @ut, 'Content-Type' => 'application/json' })
      self
    end

    def ft_complete_daily_log(args = {})

      date = args[:date] || date_str(0)
      data = {
        "data": {
          "reminders": [],
          "last_sync_time": 0,
          "medical_logs": [{
            "date": date,
            "data_key": "Medication:Metformin (Glucophage)",
            "user_id": @user_id,
            "data_value": "0"
          }, {
            "date": date,
            "data_key": "Medication:Bromocriptine (Parlodel)",
            "user_id": @user_id,
            "data_value": "0"
          }, {
            "date": date,
            "data_key": "Medication:Clomiphene citrate (Clomid; Serophene)",
            "user_id": @user_id,
            "data_value": "1"
          }, {
            "date": date,
            "data_key": "Medication:Human menopausal gonadotropin or hMG (Repronex; Pergonal)",
            "user_id": @user_id,
            "data_value": "1"
          }, {
            "date": date,
            "data_key": "Medication:Gonadotropin-releasing hormone (Gn-RH)",
            "user_id": @user_id,
            "data_value": "0"
          }, {
            "date": date,
            "data_key": "Medication:Follicle-stimulating hormone or FSH (Gonal-F; Follistim)",
            "user_id": @user_id,
            "data_value": "0"
          }, {
            "date": date,
            "data_key": "uterineLiningThickness",
            "user_id": @user_id,
            "data_value": "3"
          }, {
            "date": date,
            "data_key": "hCGTriggerShot",
            "user_id": @user_id,
            "data_value": "2"
          }, {
            "date": date,
            "data_key": "luteinizingHormoneLevel",
            "user_id": @user_id,
            "data_value": "15"
          }, {
            "date": date,
            "data_key": "progesteroneLevel",
            "user_id": @user_id,
            "data_value": "15"
          }, {
            "date": date,
            "data_key": "ultrasound",
            "user_id": @user_id,
            "data_value": "1"
          }, {
            "date": date,
            "data_key": "estrogenLevel",
            "user_id": @user_id,
            "data_value": "15"
          }, {
            "date": date,
            "data_key": "hCGTriggerShotTime",
            "user_id": @user_id,
            "data_value": "0"
          }, {
            "date": date,
            "data_key": "folliclesNumber",
            "user_id": @user_id,
            "data_value": "3"
          }, {
            "date": date,
            "data_key": "bloodWork",
            "user_id": @user_id,
            "data_value": "1"
          }, {
            "date": date,
            "data_key": "folliclesSize",
            "user_id": @user_id,
            "data_value": "3"
          }]
        }
      }

      @res = HTTParty.post("#{GLOW_ANDROID_BASE_URL}/a/v2/users/push", :body => data.to_json,
        :headers => { "Authorization" => @ut, 'Content-Type' => 'application/json' })
      self
    end

    def male_complete_daily_log
      data = {
        "data": {
          "reminders": [],
          "daily_data": [{
            "emotional_symptom_1": 138009387554,
            "weight": 70.30676,
            "emotional_symptom_2": 0,
            "moods": 2,
            "masturbation": 34,
            "exercise": 10,
            "physical_symptom_2": 570434050,
            "meds": "{\"Acilac\":2}",
            "sleep": 25200,
            "fever": 34,
            "date": Time.now.strftime("%Y/%m/%d"),
            "stress_level": 52,
            "physical_discomfort": 2,
            "physical_symptom_1": 598280388084226,
            "smoke": 7,
            "intercourse": 2097154,
            "alcohol": 5,
            "heat_source": 34,
            "erection": 2
          }],
          "last_sync_time": 0,
          "tutorial_completed": 1,
          "settings": {
            "time_zone": 8,
            "meds": {
              "Acilac": {
                "id": "7d42ed3d-115d-4806-a30d-abce28bfec21",
                "total": 50,
                "perDosage": 0,
                "reminderId": "",
                "form": "Solution",
                "name": "Acilac"
              }
            }
          },
          "notifications_read": false
        }
      }

      @res = HTTParty.post("#{GLOW_ANDROID_BASE_URL}/a/v2/users/push", :body => data.to_json,
        :headers => { "Authorization" => @ut, 'Content-Type' => 'application/json' })
      self
    end   

    def add_non_ttc_daily_log(num_of_days = 1)
      (0...num_of_days).each do |n|
        non_ttc_female_complete_daily_log(date: date_str(-n))
      end
      self
    end

    def add_ttc_daily_log(num_of_days = 1)
      (0...num_of_days).each do |n|
        ttc_female_complete_daily_log(date: date_str(-n))
      end
      self
    end

    def add_ft_daily_log(num_of_days = 1)
      (0...num_of_days).each do |n|
        ft_complete_daily_log(date: date_str(-n))
      end
      self
    end

    def get_daily_tasks
      date = date_str
      #params = "&ut=#{@ut.gsub("=","%3D")}"
      params = "date=" + date_str.gsub('/', '%2F')
      additional_post_data.each do |key, value|
        params += "&"
        params += key.to_s
        params += "="
        params += value.to_s
      end
      params = params.gsub(",", "%2C").gsub('/', '%2F').gsub(' ', '%20')
      url = "#{GLOW_ANDROID_BASE_URL}/a/users/daily_task?#{params}"
      @res = HTTParty.get(url, :headers => { "Authorization" => @ut, 'Content-Type' => 'application/json' })
      self
    end

    # Period

    def add_periods
      data = {
        "data": {
          "periods": {
            "archived": [],
            "alive": live_periods
          },
          "last_sync_time": 1450212435
        }
      }

      @res = HTTParty.post("#{GLOW_ANDROID_BASE_URL}/a/v2/users/push", :body => data.to_json,
        :headers => { "Authorization" => @ut, 'Content-Type' => 'application/json' })
      self
    end

    ######## Me #########

    def export_pdf
      data = {
        "unit": "F",
        "email": "linus@glowing.com"
      }
      @res = HTTParty.post("#{GLOW_ANDROID_BASE_URL}/a/users/export", :body => data.to_json,
        :headers => { "Authorization" => @ut, 'Content-Type' => 'application/json' })
      self
    end

    def change_password
      # Glow Android doesn't support changing password in-app
    end

    def add_fertility_tests
      date = date_str
      data = {
        "data": [{
          "test_key": "papsmear",
          "test_val": date
        }, {
          "test_key": "doctor_name",
          "test_val": "Doctor Wei"
        }, {
          "test_key": "partner_semen_analysis_concentration",
          "test_val": "15"
        }, {
          "test_key": "cycle_day_three_blood_work_e2",
          "test_val": "15"
        }, {
          "test_key": "other_blood_tests_infectious_disease",
          "test_val": 1
        }, {
          "test_key": "partner_infectious_disease_blood_test",
          "test_val": date
        }, {
          "test_key": "partner_semen_analysis_morphology",
          "test_val": 1
        }, {
          "test_key": "partner_semen_analysis_motility",
          "test_val": "15"
        }, {
          "test_key": "cycle_day_three_blood_work_fsh",
          "test_val": "15"
        }, {
          "test_key": "partner_semen_analysis_volume",
          "test_val": "15"
        }, {
          "test_key": "partner_genetic_screening",
          "test_val": date
        }, {
          "test_key": "nurse_name",
          "test_val": "Nurse Li"
        }, {
          "test_key": "partner_semen_analysis",
          "test_val": date
        }, {
          "test_key": "hysterosalpingogram",
          "test_val": date
        }, {
          "test_key": "vaginal_ultrasound_antral_follicle_count",
          "test_val": "15"
        }, {
          "test_key": "other_blood_tests",
          "test_val": date
        }, {
          "test_key": "partner_infectious_disease_blood_test_result",
          "test_val": 1
        }, {
          "test_key": "mammogram",
          "test_val": date
        }, {
          "test_key": "cycle_day_three_blood_work_lh",
          "test_val": "15"
        }, {
          "test_key": "ovarian_reserve_testing_result",
          "test_val": 1
        }, {
          "test_key": "ovarian_reserve_testing",
          "test_val": date
        }, {
          "test_key": "cycle_day_three_blood_work_tsh",
          "test_val": "15"
        }, {
          "test_key": "papsmear_result",
          "test_val": 1
        }, {
          "test_key": "hysterosalpingogram_result",
          "test_val": 1
        }, {
          "test_key": "vaginal_ultrasound_lining",
          "test_val": "15"
        }, {
          "test_key": "saline_sonogram",
          "test_val": date
        }, {
          "test_key": "fertility_clinic",
          "test_val": 4
        }, {
          "test_key": "partner_genetic_screening_result",
          "test_val": 1
        }, {
          "test_key": "mammogram_result",
          "test_val": 1
        }, {
          "test_key": "genetic_screening_result",
          "test_val": 1
        }, {
          "test_key": "saline_sonogram_result",
          "test_val": 1
        }, {
          "test_key": "cycle_day_three_blood_work",
          "test_val": date
        }, {
          "test_key": "genetic_screening",
          "test_val": date
        }, {
          "test_key": "cycle_day_three_blood_work_prl",
          "test_val": "15"
        }, {
          "test_key": "vaginal_ultrasound",
          "test_val": date
        }, {
          "test_key": "other_blood_tests_amh",
          "test_val": "15"
        }]
      }
      @res = HTTParty.post("#{GLOW_ANDROID_BASE_URL}/a/users/fertility_test", :body => data.to_json,
        :headers => { "Authorization" => @ut, 'Content-Type' => 'application/json' })
      self
    end

    def invite_partner
      data = {
        "partner": {
          "is_mom": false,
          "email": @partner_email,
          "name": @partner_first_name + " Glow"
        }
      }.merge(additional_post_data)
      @res = HTTParty.post("#{GLOW_ANDROID_BASE_URL}/a/users/partner/email", :body => data.to_json,
        :headers => { "Authorization" => @ut, 'Content-Type' => 'application/json' })
      self
    end

    def remove_partner
      data = {}.merge(additional_post_data)
      @res = HTTParty.post("#{GLOW_ANDROID_BASE_URL}/a/users/remove_partner", :body => data.to_json,
        :headers => { "Authorization" => @ut, 'Content-Type' => 'application/json' })
    end

    def turn_off_period_prediction
      data = {
        "data": {
          "periods": {
            "archived": [],
            "alive": live_periods
          },
          "last_sync_time": 1450213617,
          "settings": {
            "time_zone": 8,
            "prediction_switch": 0
          },
          "notifications_read": false
        }
      }

      @res = HTTParty.post("#{GLOW_ANDROID_BASE_URL}/a/v2/users/push", :body => data.to_json,
        :headers => { "Authorization" => @ut, 'Content-Type' => 'application/json' })
      self
    end

    def add_health_profile(type = "")
      data = {
        "data": {
          "last_sync_time": 1450216427,
          "settings": {
            "insurance": 1,
            "occupation": "Employed",
            "live_birth_number": 1,
            "miscarriage_number": 1,
            "stillbirth_number": 1,
            "tubal_pregnancy_number": 1,
            "exercise": 4,
            "abortion_number": 1,
            "home_zipcode": "94304",
            "diagnosed_conditions": 6,
            "birth_control_start": 1385848427,
            "cycle_regularity": 1,
            "time_zone": 8,
            "period_cycle": 29,
            "sperm_egg_donation": 1,
            "infertility_diagnosis": 6,
            "relationship_status": 2,
            "partner_erection": 2
          },
          "notifications_read": false
        }
      }

      @res = HTTParty.post("#{GLOW_ANDROID_BASE_URL}/a/v2/users/push", :body => data.to_json,
        :headers => { "Authorization" => @ut, 'Content-Type' => 'application/json' })
      self
    end

  ######## Community-----community-----------
    def create_topic(args = {})
      data = {
        "title": args[:topic_title] || "#{@email} #{Time.now}",
        "anonymous": args[:anonymous]|| 0,
        "content": args[:topic_content] || ("Example create topic" + Time.now.to_s)
      }
      group_id = args[:group_id]|| GROUP_ID 
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/group/#{group_id}/topic?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      @topic_title = @res["result"]["title"]
      @topic_id = @res["result"]["id"]
      puts "topic >>>>>'#{@topic_title}'<<<<< created，\ntopic id is >>>>#{@topic_id}<<<<, \ngroup_id is >>>>#{group_id}<<<<\n\n"
      self
    end

    def create_poll(args = {})
      data = {
        "title": args[:topic_title] || ("Test Poll" + Time.now.to_s),
        "anonymous": args[:anonymous]|| 0,
        "content": args[:topic_content] || ("Example create Poll" + Time.now.to_s),
        "poll_options": ["option1", "opiton2", "option3"].to_s
      }
      group_id = args[:group_id]|| GROUP_ID 
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/group/#{group_id}/topic?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      @topic_title = @res["result"]["title"]
      @topic_id = @res["result"]["id"]
      puts "topic >>>>>'#{@topic_title}'<<<<< created，\ntopic id is >>>>#{@topic_id}<<<<, \ngroup_id is >>>>#{group_id}<<<<\n\n"
      self
    end


    def vote_poll(args= {})
      topic_id = args[:topic_id]
      vote_index = args[:vote_index] || 1
      data = {
        "vote_index": vote_index
      }
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/topic/#{topic_id}/vote?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      if @res["rc"] == 0
        puts "#{topic_id} is voted by vote_index #{vote_index} and user #{self.user_id}"
      else 
        puts "#{@res}<<<  Expected repeated vote"
      end
      self
    end



    def reply_to_topic(topic_id, args = {})
      data = {
        "content": args[:reply_content] || ("Example reply to topic" + Time.now.to_s)
      }
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/topic/#{topic_id}/reply?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      @reply_id = @res["result"]["id"]
      puts "reply_id is #{@reply_id}"
      self
    end

    def reply_to_comment(topic_id, reply_id, args = {})
      data = {
        "content": args[:reply_content] || ("Example reply to comment" + Time.now.to_s),
        "reply_to": reply_id
      }
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/topic/#{topic_id}/reply?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      @sub_reply_id = @res["result"]["id"]
      self
    end
#---------GROUPS----------
    def join_group(group_id = GROUP_ID )
      data = {
        "group_id": group_id
      }
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/group/subscribe?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "       ------------#{self.user_id} joined group >>>#{group_id}<<<-------------"
      self
    end

    def leave_group(group_id)
      data = {
        "group_id": group_id
      }
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/group/unsubscribe?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "       ------------#{self.user_id} left group >>>#{group_id}<<<-------------"
      self
    end

    def get_all_groups
      group_data = {
      }
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/user/0/groups?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      _res =  HTTParty.get(url, :body => group_data.to_json,
        :headers => {  "Authorization" => @ut , 'Content-Type' => 'application/json' })
      @all_group_ids = []
      _res["groups"].each do |element|
        element.each do |k,v|
          if k == "id"
            @all_group_ids.push v
          end
        end
      end
      self
    end

    def leave_all_groups
      get_all_groups
      @all_group_ids.each do |group_id|
        leave_group group_id
      end
      self
    end

    def delete_topic(topic_id)
      data = {}
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/topic/#{topic_id}?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.delete(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "topic >>>>>'#{@topic_title}'<<<<< deleted\ntopic id is >>>>#{topic_id}<<<<\n\n"
      self
    end

    def follow_user(user_id)
      data = {
        "empty_stub": ""
      }
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/user/#{user_id}/follow?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "User #{user_id} is followed by current user #{self.user_id}"  
      self
    end

    def unfollow_user(user_id)
      data = {
        "empty_stub": ""
      }
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/user/#{user_id}/unfollow?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "User #{user_id} is unfollowed by current user #{self.user_id}"  
      self
    end

    def block_user(user_id)
      data = {
        "empty_stub": ""
      }
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/user/#{user_id}/block?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "User #{user_id} is blocked by current user #{self.user_id}"  
      self
    end

    def unblock_user(user_id)
      data = {
        "empty_stub": ""
      }
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/user/#{user_id}/unblock?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "User #{user_id} is unblocked by current user #{self.user_id}"  
      self
    end


    def bookmark_topic(topic_id)
      data = {
        "bookmarked": 1
      }
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/topic/#{topic_id}/bookmark?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "topic id >>>>>'#{topic_id}'<<<<< is is bookmarked by #{self.user_id}\n\n"
      self
    end

    def unbookmark_topic(topic_id)
      data = {
        "bookmarked": 0
      }
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/topic/#{topic_id}/bookmark?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "topic id >>>>>'#{topic_id}'<<<<< is unbookmarked by #{self.user_id}\n\n"
      self
    end

# ------------upvote downvote -----------
    def upvote_topic(topic_id)
      data = {
        "liked": 1
      }
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/topic/#{topic_id}/like?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "topic id >>>>>'#{topic_id}'<<<<< is liked by #{self.user_id}\n\n"
      self
    end

    def cancel_upvote_topic(topic_id)
      data = {
        "liked": 0
      }
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/topic/#{topic_id}/like?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "topic id >>>>>'#{topic_id}'<<<<< is no longer liked by #{self.user_id}\n\n"
      self
    end

    def downvote_topic(topic_id)
      data = {
        "disliked": 1
      }
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/topic/#{topic_id}/dislike?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "topic id >>>>>'#{topic_id}'<<<<< is disliked by #{self.user_id}\n\n"
      self
    end

    def cancel_downvote_topic(topic_id)
      data = {
        "disliked": 0
      }
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/topic/#{topic_id}/dislike?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "topic id >>>>>'#{topic_id}'<<<<< is no longer disliked by #{self.user_id}\n\n"
      self
    end

    def upvote_comment(topic_id, reply_id)
      data = {
        "topic_id": topic_id,
        "liked": 1
      }
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/reply/#{reply_id}/like?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "Comment >>#{reply_id}<< under topic >>#{topic_id}<< is upvoted by #{self.user_id}\n"
      self
    end

    def cancel_upvote_comment(topic_id, reply_id)
      data = {
        "topic_id": topic_id,
        "liked": 0
      }
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/reply/#{reply_id}/like?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "Comment >>#{reply_id}<< under topic >>#{topic_id}<< is no longer upvoted by #{self.user_id}\n"
      self
    end

    def downvote_comment(topic_id, reply_id)
      data = {
        "topic_id": topic_id,
        "disliked": 1
      }
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/reply/#{reply_id}/dislike?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "Comment >>#{reply_id}<< under topic >>#{topic_id}<< is downvoted by #{self.user_id}\n"
      self
    end

    def cancel_downvote_comment(topic_id, reply_id)
      data = {
        "topic_id": topic_id,
        "disliked": 0
      }
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/reply/#{reply_id}/dislike?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "Comment >>#{reply_id}<< under topic >>#{topic_id}<< is no longer downvoted by #{self.user_id}\n"
      self
    end
 #-----------Flag topic/comment--------------

    def report_topic(topic_id, report_reason)
      data = {
        "reason": report_reason
      }
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/topic/#{topic_id}/flag?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "Topic >>#{topic_id}<< is reported for reason >>>#{report_reason}<<< by >>>#{self.user_id}<<<\n"
      self
    end

    def report_comment(topic_id, reply_id, report_reason)
      data = {
        "reply_id": reply_id,
        "reason": report_reason
      }
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/topic/#{topic_id}/flag?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "Comment >>>#{reply_id}<<< under >>#{topic_id}<< is reported for reason >>>#{report_reason}<<< by >>>#{self.user_id}<<<\n"
      self
    end
  end

  def hide_topic(topic_id, report_reason)
      data = {
        "reason": report_reason
      }
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/topic/#{topic_id}/flag?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "Topic >>#{topic_id}<< is reported for reason >>>#{report_reason}<<< by >>>#{self.user_id}<<<\n"
      self
    end
end