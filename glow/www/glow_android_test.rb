require 'httparty'
require 'json'
require 'active_support/all'

module GlowAndroid

  PASSWORD = 'Glow12345'
  TREATMENT_TYPES = {"med": 1, "iui": 2, "ivf": 3, "prep": 4}
  GLOW_ANDROID_BASE_URL = "http://titan-emma.glowing.com"

  class GlowUser
    include HTTParty
    base_uri GLOW_ANDROID_BASE_URL

    attr_accessor :email, :password, :first_name, :last_name, :gender
    attr_accessor :type, :partner_email, :partner_first_name
    attr_accessor :res, :ut, :user_id, :topic_id, :reply_id

    def initialize(args = {})  
      @first_name = args[:first_name] || "ga" + Time.now.to_i.to_s
      @email = args[:email] || "#{@first_name}@g.com"
      @last_name = "Glow"
      @password = args[:password] || PASSWORD
      @partner_email = "p#{@email}"
      @partner_first_name = "p#{@first_name}"
      @gender = args[:gender] || "female"
      @type = args[:type]
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

    def options(data)
      { :body => data.to_json, :headers => { 'Content-Type' => 'application/json' }}
    end

    def auth_options(data)
      { :body => data.to_json, :headers => { 'Authorization' => @ut, 'Content-Type' => 'application/json' }}
    end

    def common_data
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

      @res = self.class.post "/a/v2/users/signup", options(data)

      if @res["rc"] == 0
        @ut = @res["user"]["encrypted_token"]
        @user_id = @res["user"]["id"]
        puts email + " has been signed up"
      end
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

      @res = self.class.post "/a/v2/users/signup", options(data)
      if @res["rc"] == 0
        @ut = @res["user"]["encrypted_token"]
        @user_id = @res["user"]["id"]
        puts @email + " has been signed up"
      end
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
          "android_version": "3.9.0-play-beta",
          "fertility_test": {
            "fertility_clinic": 4
          }
        }
      }

      @res = self.class.post "/a/v2/users/signup", options(data)
      if @res["rc"] == 0
        @ut = @res["user"]["encrypted_token"]
        @user_id = @res["user"]["id"]
        puts @email + " has been signed up"
      end
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
          "android_version": "3.9.0-play-beta"
        }
      }

      @res = self.class.post "/a/v2/users/signup", options(data)
      if @res["rc"] == 0
        @ut = @res["user"]["encrypted_token"]
        @user_id = @res["user"]["id"]
        puts @email + " has been signed up"
      end
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

      @res = self.class.post "/a/v2/users/push", auth_options(data)
      self
    end

    def login(email = nil, password = nil)
      data = {
        "email": email || @email,
        "password": password || @password
      }.merge(common_data)

      @res = self.class.post "/a/users/signin", options(data)
      if @res["rc"] == 0
        @ut = @res["user"]["encrypted_token"]
      end
      self
    end

    def logout
      #@ut = nil
      data = common_data
      @res = self.class.post "/a/users/logout", auth_options(data)
      self
    end

    def forgot_password(email)
      data = {
        "email": email
      }.merge(common_data)

      @res = self.class.post "/a/users/recover_password", options(data)
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
      common_data.each do |key, value|
        params += "&"
        params += key.to_s
        params += "="
        params += value.to_s
      end
      params.gsub(",", "%2C")
  
      url = "/a/v2/users/pull?ts=0&sign=todos%3A%7Cactivity_rules%3A%7Cclinics%3A%7Cfertile_score_coef%3A%7Cfertile_score%3A%7Cpredict_rules%3A%7Chealth_rules%3A&#{params}"
      @res = self.class.get url
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
      @res = self.class.post "/a/v2/users/push", auth_options(data)
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

      @res = self.class.post "/a/v2/users/push", auth_options(data)
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

      @res = self.class.post "/a/v2/users/push", auth_options(data)
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

      @res = self.class.post "/a/v2/users/push", auth_options(data)
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
      params = "date=" + date_str.gsub('/', '%2F')
      common_data.each do |key, value|
        params += "&"
        params += key.to_s
        params += "="
        params += value.to_s
      end
      params = params.gsub(",", "%2C").gsub('/', '%2F').gsub(' ', '%20')
      url = "/a/users/daily_task?#{params}"
      @res = self.class.get(url, :headers => { "Authorization" => @ut, 'Content-Type' => 'application/json' })
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

      @res = self.class.post "/a/v2/users/push", auth_options(data)
      self
    end

    ######## Me #########

    def export_pdf
      data = {
        "unit": "F",
        "email": "linus@glowing.com"
      }

      @res = self.class.post "/a/users/export", auth_options(data)
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

      @res = self.class.post "/a/users/fertility_test", auth_options(data)
      self
    end

    def invite_partner
      data = {
        "partner": {
          "is_mom": false,
          "email": @partner_email,
          "name": @partner_first_name + " Glow"
        }
      }.merge(common_data)

      @res = self.class.post "/a/users/partner/email", auth_options(data)
      self
    end

    def remove_partner
      data = {}.merge(common_data)
      @res = self.class.post "/a/users/remove_partner", auth_options(data)
      self
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

      @res = self.class.post "/a/v2/users/push", auth_options(data)
      self
    end

    def add_health_profile(type = "")
      data = {
        "data": {
          "last_sync_time": 1450216427,
          "settings": {
            "insurance": 1,
            "time_zone": 8,
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

      @res = self.class.post "/a/v2/users/push", auth_options(data)
      self
    end

  def new_log(args)
    {
      "locale": "en_US",
      "device_id": "6c75a409e88439e3",
      "user_id": @user_id,
      "version": "3.9.0",
      "event_name": args[:event_name],
      "event_time": args[:event_time] || Time.now.to_i
    }
  end

  def sync_log()
    data = {
      "log_list": log_list
    }
    self.class.post "/a/users/sync_log?#{common_data}", auth_options(data)
  end

  end
end

