require 'httparty'
require 'faker'
require 'active_support/all'
require_relative 'noah_test_helper'

module BabyAndroid
  extend BabyTestHelper

  PASSWORD = '111222'
  BASE_URL = load_config["base_urls"]["sandbox1"]

  POO_MASK                 = 0xFFFF
  POO                      = 0x0001

  POO_COLOR_MASK           = 0x00F0
  POO_COLOR_GREEN          = 0x0010
  POO_COLOR_YELLOW         = 0x0020
  POO_COLOR_BROWN          = 0x0030
  POO_COLOR_BLACK          = 0x0040
  POO_COLOR_RED            = 0x0050
  POO_COLOR_WHITE          = 0x0060

  POO_TEXTURE_MASK         = 0x0F00
  POO_TEXTURE_VERY_RUNNY   = 0x0100
  POO_TEXTURE_RUNNY        = 0x0200
  POO_TEXTURE_MUSHY        = 0x0300
  POO_TEXTURE_MUCUSY       = 0x0400
  POO_TEXTURE_SOLID        = 0x0500
  POO_TEXTURE_LITTLE_BALLS = 0x0600

  PEE_MASK                 = 0xF0000
  PEE                      = 0x10000

  class Baby
    attr_accessor :first_name, :last_name, :gender
    attr_accessor :birthday, :birth_due_date, :birth_timezone
    attr_accessor :baby_id
    attr_accessor :relation
    attr_accessor :weight_all, :height_all, :headcirc_all
    attr_accessor :birth_weight, :birth_height, :birth_headcirc, :ethnicity

    def initialize(args)
      @first_name = args[:first_name]
      @last_name = args[:last_name]
      @gender = args[:gender]
      @relation = args[:relation]
      @birthday = args[:birthday]
      @birth_due_date = args[:birth_due_date]
      @birth_timezone = args[:birth_timezone]
      @baby_id = args[:baby_id]
      @weight_all = []
      @height_all = []
      @birth_weight = args[:birth_weight]
      @birth_height = args[:birth_height]
      @birth_headcirc = args[:birth_headcirc] || args[:birth_head]
      @headcirc_all = []
      @ethnicity = [1]
    end
  end

  class BabyUser
    include BabyTestHelper
    include HTTParty

    base_uri BASE_URL

    attr_accessor :email, :password, :first_name, :last_name, :gender, :birthday
    attr_accessor :relation, :partners, :status
    attr_accessor :babies, :current_baby, :user_id, :current_baby_id
    attr_accessor :res, :ut

    def initialize(args = {})
      @first_name = args[:first_name] || get_first_name
      @email = args[:email] || "#{@first_name}@g.com"
      @last_name = "Glow"
      @password = args[:password] || PASSWORD
      @relation = args[:relation] || "Mother"
      @birthday = args[:birthday] || 25.years.ago.to_i
      @babies = []
      @partners = []
    end

    def get_first_name
      "ba" + Time.now.to_i.to_s[2..-1] + random_str(2)
    end

    def random_str(n)
      (10...36).map{ |i| i.to_s 36}.shuffle[0,n.to_i].join
    end

    def random_num
      rand.to_s[2..16]
    end

    def uuid
      SecureRandom.uuid
    end

    def date_str(t)
      t.strftime("%Y/%m/%d")
    end

    def date_time_str(dt)
      # "2016/01/11 12:51:00" date label
      dt.strftime("%Y/%m/%d %H:%M:%S")
    end

    def options(data)
      { :body => data.to_json, :headers => { 'Content-Type' => 'application/json' }}
    end

    def auth_options(data)
      { :body => data.to_json, :headers => { 'Authorization' => @ut, 'Content-Type' => 'application/json' }}
    end

    def common_data
      data = {
        "hl": "en_US",
        "random": random_num,
        "device_id": "be3ca737160d9da3",
        "android_version": "1.0-beta",
        "vc": 1,
        "time_zone": "Asia Shanghai",
        "code_name": "noah",
      }.to_param
    end

    def signup(args = {})
      user = args[:user] || self
      data = {
        "user": {
          "first_name": user.first_name,
          "last_name": user.last_name,
          "email": user.email,
          "password": user.password
        }
      }

      data = {
        "user": {
          "first_name": user.first_name,
          "last_name": user.last_name,
          "email": user.email,
          "birthday": user.birthday,
          "birthday_str": date_str(Time.at(user.birthday)),
          "password": user.password
        }
      }
      # http://titan-noah.glowing.com/android/user/sign_up?code_name=noah&time_zone=Asia%2FShanghai&vc=1&android_version=1.0-beta&device_id=be3ca737160d9da3&random=826154824919581&hl=en_US&
      # "http://titan-noah.glowing.com/android/user/sign_up?hl=en_GB&random=248763385519373&device_id=68e851582c0f3631&android_version=1.0-beta&vc=1&time_zone=Asia%2FShanghai&code_name=noah"
      user.res = self.class.post "/android/user/sign_up?#{common_data}", options(data)

      if user.res["rc"] == 0
        user.ut = user.res["data"]["user"]["encrypted_token"]
        user.user_id = user.res["data"]["user"]["id"]
        puts user.email + " has been signed up. [user_id: #{@user_id}]"
      end
      self
    end

    def login(args = {})
      email = args[:email] || @email
      password = args[:password] || @password
      data = {
        email: email,
        password: password
      }

      @res = self.class.post "/android/user/sign_in?#{common_data}", options(data)

      if @res["rc"] == 0
        @ut = @res["data"]["user"]["encrypted_token"]
        @user_id = @res["data"]["user"]["id"]
        @current_baby_id = @res["data"]["user"]["current_baby_id"]
        log_msg email + " just logged in. [user_id: #{@user_id}]"
        if @res["data"]["babies"].size > 0
          current_baby = @res["data"]["babies"].detect {|b| b["Baby"]["baby_id"] == @current_baby_id }
          @current_baby = Baby.new current_baby["Baby"].symbolize_keys
          log_msg "current baby is: #{@current_baby.first_name} [baby_id: #{@current_baby.baby_id}]"
        end
      end
      self
    end

    def pull
      data = {
        "data": {
          "user": {
            "sync_time": 0
          }
        }
      }

      @res = self.class.post "/android/user/pull?#{common_data}", auth_options(data)
      self
    end

    def daily_content
      @res = self.class.get "/android/user/daily_content?#{common_data}"
      self
    end

    def nurture_baby
      @res = self.class.get "/android/user/nurture_baby?#{common_data}"
      self
    end

    def new_born_baby(args = {})
      name = Faker::Name.name.split(" ")
      params = {
        first_name: args[:first_name] || name.first,
        last_name: args[:last_name] || name.last,
        relation: args[:relation] || "Mother",
        gender: args[:gender] || "M",
        birth_due_date: args[:birth_due_date] || date_str(10.days.ago),
        birthday: args[:birthday] || date_str(10.days.ago),
        birth_timezone: args[:birth_timezone] || "Asia\/Shanghai"
      }
      Baby.new(params)
    end

    def new_upcoming_baby(args = {})
      name = Faker::Name.name.split(" ")
      params = {
        first_name: args[:first_name] || name.first,
        last_name: args[:last_name] || name.last,
        relation: args[:relation] || "Mother",
        birth_due_date: args[:birth_due_date] || date_str(10.days.ago),
      }
      Baby.new(params)
    end

    def add_born_baby(baby)
      data = {
        "first_name": baby.first_name,
        "last_name": baby.last_name,
        "gender": baby.gender,
        "birthday": baby.birthday,
        "due_date": baby.birth_due_date,
        "relation": baby.relation.capitalize,
        "from_nurture": 0
      }

      @res = self.class.post "/android/baby?#{common_data}", auth_options(data)
      if @res["rc"] == 0
        @current_baby = baby
        @current_baby.baby_id = @res["data"]["baby_id"]
        @babies << @current_baby
        puts "Baby #{baby.first_name} is added [baby_id: #{@current_baby.baby_id}]"
      end
      self
    end

    def add_upcoming_baby(baby)
      data = {
        "first_name": baby.first_name,
        "last_name": baby.last_name,
        "gender": "",
        "birthday": "",
        "due_date": baby.birth_due_date,
        "relation": baby.relation.capitalize,
        "from_nurture": 0
      }

      @res = self.class.post "/android/baby?#{common_data}", auth_options(data)
      if @res["rc"] == 0
        @current_baby = baby
        @current_baby.baby_id = @res["data"]["baby_id"]
        @babies << @current_baby
        puts "Baby #{baby.first_name} is added [baby_id: #{@current_baby.baby_id}]"
      end
      self
    end

    def delete_baby(baby)
      
    end

    def new_feed(args = {})
      # 2 breast feeding
      # 3 bottle breast milk
      # 4 bottle formula milk
      start_time = args[:start_time]
      feed_type = args[:feed_type]
      left_duration = args[:breast_left_time] || 1200
      right_duration = args[:breast_right_time] || 1200
      {
        "uuid": uuid,
        "baby_id": @current_baby.baby_id,
        "action_user_id": @user_id,
        "breast_left_time": left_duration,
        "breast_right_time": right_duration,
        "date_label": date_str(start_time),
        "feed_type": 2,
        "start_timestamp": start_time.to_i,
        "start_time_label": date_time_str(start_time)
      }
    end

    def add_feed(feed)
      data = {
        "items": [{
          "babies": [{
            "baby_id": @current_baby.baby_id,
            "BabyFeedData": {
              "create": [feed]
            }
          }]
        }]
      }
      @res = self.class.patch "/android/user/push?#{common_data}", auth_options(data)
      self
    end

    def new_sleep(args={})
      start_time = args[:start_time]
      end_time = args[:end_time]
      {
        "uuid": uuid,
        "baby_id": @current_baby.baby_id,
        "action_user_id": @user_id,
        "key": "sleep",
        "date_label": date_str(start_time),
        "start_time_label": date_time_str(start_time),
        "start_timestamp": start_time.to_i,
        "end_timestamp": end_time.to_i,
        "end_time_label": date_time_str(end_time)
      }
    end

    def add_sleep(sleep)
      data = {
        "items": [{
          "babies": [{
            "baby_id": @current_baby.baby_id,
            "BabyData": {
              "create": [sleep]
            }
          }]
        }]
      }

      @res = self.class.patch "/android/user/push?#{common_data}", auth_options(data)
      self
    end

    def new_diaper(args = {})
      poo_colors = [POO_COLOR_GREEN, POO_COLOR_YELLOW, POO_COLOR_BROWN, POO_COLOR_BLACK, POO_COLOR_RED, POO_COLOR_WHITE]
      poo_textures = [POO_TEXTURE_VERY_RUNNY, POO_TEXTURE_RUNNY, POO_TEXTURE_MUSHY, POO_TEXTURE_MUCUSY, POO_TEXTURE_SOLID, POO_TEXTURE_LITTLE_BALLS]
      
      value_int = 0
      type = args[:type].downcase

      case type.downcase
      when "poo"
        value_int = POO_MASK & (POO + poo_colors.sample + poo_textures.sample)
      when "pee"
        value_int = PEE_MASK & PEE
      end

      start_time = args[:start_time]
      {
        "uuid": uuid,
        "key": "diaper",
        "baby_id": @current_baby.baby_id,
        "date_label": date_str(start_time),
        "action_user_id": @user_id,
        "start_timestamp": start_time.to_i,
        "start_time_label": date_time_str(start_time),
        "val_int": value_int
      }
    end

    def add_diaper(diaper)
      {
        "items": [{
          "babies": [{
            "baby_id": @current_baby.baby_id,
            "BabyData": {
              "create": [diaper]
            }
          }]
        }]
      }

      @res = self.class.patch "/android/user/push?#{common_data}", auth_options(data)
      self
    end


    def new_weight(args)
      start_time = args[:start_time]
      weight = args[:weight] = 5.0
      {
        "uuid": uuid,
        "date_label": date_str(start_time),
        "key": "weight",
        "baby_id": @current_baby.baby_id,
        "action_user_id": @user_id,
        "val_float": weight
      }
    end

    def add_weight(weight)
      data = {
        "items": [{
          "babies": [{
            "baby_id": @current_baby.baby_id,
            "BabyData": {
              "create": [weight]
            }
          }]
        }]
      }

      @res = self.class.patch "/android/user/push?#{common_data}", auth_options(data)
      self
    end

    def new_height(args)
      start_time = args[:start_time]
      height = args[:height]
      {
        "uuid": uuid,
        "date_label": date_str(start_time),
        "key": "height",
        "baby_id": @current_baby.baby_id,
        "action_user_id": @user_id,
        "val_float": height
      }
    end

    def add_height(weight)
      data = {
        "items": [{
          "babies": [{
            "baby_id": @current_baby.baby_id,
            "BabyData": {
              "create": [weight]
            }
          }]
        }]
      }

      @res = self.class.patch "/android/user/push?#{common_data}", auth_options(data)
      self
    end

    def new_headcirc(args)
      start_time = args[:start_time]
      headcirc = args[:headcirc]
      {
        "uuid": uuid,
        "date_label": date_str(start_time),
        "key": "headcirc",
        "baby_id": @current_baby.baby_id,
        "action_user_id": @user_id,
        "val_float": headcirc
      }
    end

    def add_headcirc(headcirc)
      data = {
        "items": [{
          "babies": [{
            "baby_id": @current_baby.baby_id,
            "BabyData": {
              "create": [headcirc]
            }
          }]
        }]
      }

      @res = self.class.patch "/android/user/push?#{common_data}", auth_options(data)
      self
    end

    def add_growth_data
      data = {
        "items": [{
          "babies": [{
            "baby_id": @current_baby.baby_id,
            "BabyData": {
              "create": [new_weight, new_height, new_headcirc]
            }
          }]
        }]
      }

      @res = self.class.patch "/android/user/push?#{common_data}", auth_options(data)
      self
    end

    def change_email(new_email)
      data = {
        "items": [{
          "user": {
            "user_id": @user_id,
            "User": {
              "update": [{
                "user_id": @user_id,
                "email": new_email
              }]
            }
          }
        }]
      }

      self.class.patch "/android/user/push?#{common_data}", auth_options(data)
      self
    end

    def update_account_settings(args)
      data = {
        "items": [{
          "user": {
            "user_id": @user_id,
            "User": {
              "update": [{
                "user_id": @user_id,
                "first_name": args[:first_name] || @first_name,
                "last_name": args[:last_name] || @last_name,
                "email": args[:email] || @email,
                "receive_push_notification": args[:receive_push_notification] || 1
              }]
            }
          }
        }]
      }

      self.class.patch "/android/user/push?#{common_data}", auth_options(data)
      self
    end

    def invite_family(args)
      partner = args[:partner]
      data = {
        "baby_id": @current_baby.baby_id,
        "email": partner.email,
        "name": partner.first_name + " " + partner.last_name,
        "relation": args[:relation] || partner.relation
      }

      @res = self.class.post "/android/baby/invite_family?#{common_data}", auth_options(data)
      if @res["rc"] == 0
        partner.user_id = @res["data"]["BabyFamily"]["update"].first["user_id"]
        partner.gender = @res["data"]["BabyFamily"]["update"].first["gender"]
        partner.status = @res["data"]["BabyFamily"]["update"].first["status"] # partner's status should be 3
        partner.current_baby_id = @res["data"]["BabyFamily"]["update"].first["current_baby_id"] # it's 0 in res ??!!

        # Connect partners in both direction
        @partners << partner
        partner.partners << self
      end
      self
    end

    def change_relation(relation)
      data = {
        "items": [{
          "babies": [{
            "baby_id": @current_baby.baby_id,
            "UserBabyRelation": {
              "update": [{
                "baby_id": @current_baby.baby_id,
                "user_id": @user_id,
                "relation": relation.capitalize
              }]
            }
          }]
        }]
      }

      @res = self.class.patch "/android/user/push?#{common_data}", auth_options(data)
      self
    end

    def update_baby_profile(args)
      data = {
        "items": [{
          "babies": [{
            "baby_id": @current_baby.baby_id,
            "Baby": {
              "update": [{
                "baby_id": @current_baby.baby_id,
                "first_name": args[:first_name] || @first_name,
                "last_name": args[:last_name] || @last_name,
                "gender": args[:gender] || @gender,
                "birthday": date_str(args[:birthday]) || @birthday,
                "birth_due_date": date_str(args[:birth_due_date]) || @brith_due_date,
                "birth_weight": args[:birth_weigth] || @birth_weight,
                "birth_height": args[:birth_height] || @birth_height,
                "birth_head": args[:birth_headcirc] || @birth_headcirc,
                "ethnicity": args[:ethnicity] || "asian / pacific islander"
              }]
            }
          }]
        }]
      }

      @res = self.class.patch "/android/user/push?#{common_data}", auth_options(data)
      self
    end

    def disconnect_family(baby, partner)
      @partners.delete_if { |p| p.user_id == partner.user_id }
      partner.partners.delete_if { |pp| pp.user_id == @user_id }
      data = {
        "baby_id": baby.baby_id,
        "family_user_id": partner.user_id
      }

      @res = self.class.post "/android/baby/disconnect_family?#{common_data}", auth_options(data)
      self
    end


    # Me 
    def change_email(new_email)
      data = {
        email: new_email
      }

      @res = self.class.post "/android/user/change_email?#{common_data}", auth_options(data)
      self
    end

    def turn_off_notification
      update_account_settings receive_push_notification: 0
    end

  end
end

