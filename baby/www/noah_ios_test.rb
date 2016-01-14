require 'httparty'
require 'faker'
require 'securerandom'
require 'active_support/all'
require 'yaml'
require_relative 'noah_test_helper'


module BabyIOS
  extend BabyTestHelper

  PASSWORD = '111222'
  BASE_URL = load_config["base_urls"]["sandbox0"]
  TIME_ZONES = ['Africa/Abidjan','Brazil/East','Brazil/West','America/New_York','America/Los_Angeles','Europe/Paris','Asia/Shanghai','Australia/Sydney','Asia/Tokyo']

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
    attr_accessor :partners
    attr_accessor :ut, :res
    attr_accessor :babies, :current_baby, :user_id, :current_baby_id
    attr_accessor :notifications
    attr_accessor :relation # for UI automation

    def initialize(args = {})
      @first_name = args[:first_name] || get_first_name
      @email = args[:email] || "#{@first_name}@g.com"
      @last_name = "Glow"
      @partners = []
      @password = args[:password] || PASSWORD
      @birthday = args[:birthday] || 25.years.ago.to_i
      @babies = []
    end

    def get_first_name
      # add the random string, so that the email will not be duplicated
      # "bi" + Time.now.to_i.to_s + random_str(3)
      "bi" + Time.now.to_i.to_s[0..-1] + random_str(5)
    end

    def random_str(n)
      #(0...36).map{ |i| i.to_s 36}.shuffle[0,n.to_i].join
      (10...36).map{ |i| i.to_s 36}.shuffle[0,n.to_i].join
    end

    def uuid
      SecureRandom.uuid.upcase
    end

    def options(data)
      { :body => data.to_json, :headers => { 'Content-Type' => 'application/json' }}
    end

    def old_date_str(n=0)
      (Time.now + n.to_i*24*3600).strftime("%Y/%m/%d")
    end

    def date_str(t)
      t.strftime("%Y/%m/%d")
    end

    def time_str(t)
      t.strftime("%Y/%m/%d %H:%M:%S")
    end

    def common_data
      {
        # "locale": "en_US",
        "locale": "zh_CN",
        "time_zone": 'Asia\/Shanghai',
        "app_version": "1.0",
        "device_id": "F5A3E7A7-3817-4A84-8215-AE983BF22850",
        "model": "x86_64"
      }
    end

    def signup(args = {})
      user = args[:user] || self
      data = { 
        "onboarding_info": {
          "birthday": user.birthday,
          "first_name": user.first_name,
          "last_name": user.last_name,
          "email": args[:email] || user.email,
          "password": args[:password] || user.password
        }
      }.merge(common_data)

      @res = self.class.post "/ios/user/signup", options(data)

      if @res["rc"] == 0
        user.ut = @res["data"]["user"]["encrypted_token"]
        user.user_id = @res["data"]["user"]["user_id"]
        log_msg user.email + " has been signed up [user_id: #{user.user_id}]"
      end
      self
    end

    def login(args = {})
      email = args[:email] || @email
      password = args[:password] || @password
      data = {
        "email": email,
        "password": password
      }.merge(common_data)

      @res = self.class.post "/ios/user/login", options(data)

      if @res["rc"] == 0
        @ut = @res["data"]["user"]["encrypted_token"]
        @user_id = @res["data"]["user"]["user_id"]
        log_msg email + " just logged in [user_id: #{@user_id}]"
        @current_baby_id = @res["data"]["user"]["current_baby_id"]
        if @res["data"]["babies"].size > 0
          current_baby = @res["data"]["babies"].detect {|b| b["Baby"]["baby_id"] == @current_baby_id }
          baby_params = current_baby["Baby"].symbolize_keys
          @current_baby = Baby.new baby_params
          log_msg "current baby is: #{@current_baby.first_name} baby_id: #{@current_baby.baby_id}"
        end
      end
      self    
    end

    def pull
      data = {
        "data": {
          "user": {
            "user_id": @user_id,
            "sync_time": 0
          },
          "babies": []
        },
        "ut": @ut
      }.merge(common_data)

      @res = self.class.post "/ios/user/pull", options(data)

      if @res["rc"] == 0
        @notifications = @res["data"]["user"]["Notification"]["update"]
      end
    end

    def new_born_baby(args = {})
      name = Faker::Name.name.split(" ")
      params = {
        first_name: args[:first_name] || name.first,
        last_name: args[:last_name] || name.last,
        relation: args[:relation] || "Mother",
        gender: args[:gender] || "M",
        birth_due_date: args[:birth_due_date] || date_str(1.day.ago),
        birthday: args[:birthday] || date_str(1.day.ago),
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
        birth_due_date: args[:birth_due_date] || date_str(30.days.since),
        birth_timezone: args[:birth_timezone] || "Asia\/Shanghai"
      }
      Baby.new(params)
    end

    def add_born_baby(baby)
      data = {
        "relation": baby.relation.capitalize,
        "baby_info": {
          "first_name": baby.first_name,
          "last_name": baby.last_name,
          "gender": baby.gender,
          "birth_due_date": baby.birth_due_date,
          "birth_height": 0,
          "from_nurture_baby": 0,
          "birthday": baby.birthday,
          "birth_timezone": baby.birth_timezone,
          "birth_weight": 0
        },
        "as_current_baby": true,
        "ut": @ut
      }.merge(common_data)

      @res = self.class.post "/ios/baby/create", options(data)

      if @res["rc"] == 0
        @current_baby = baby
        @current_baby.baby_id = @res["data"]["baby_id"]
        @babies << @current_baby
        log_msg "Baby #{@current_baby.first_name} is added -- baby_id: #{@current_baby.baby_id }"
      end
      self
    end

    def add_upcoming_baby(baby)
      data = {
        "relation": baby.relation.capitalize,
        "baby_info": {
          "first_name": baby.first_name,
          "last_name": baby.last_name,
          "birth_due_date": baby.birth_due_date,
          "birth_height": 0,
          "from_nurture_baby": 0,
          "birth_timezone": baby.birth_timezone,
          "birth_weight": 0
        },
        "as_current_baby": true,
        "ut": @ut
      }.merge(common_data)

      @res = self.class.post "/ios/baby/create", options(data)

      if @res["rc"] == 0
        @current_baby = baby
        @current_baby.baby_id = @res["data"]["baby_id"]
        @babies << @current_baby
      end
      self
    end

    def delete_baby(baby)
      data = {
        "baby_id": baby.baby_id,
        "ut": @ut
      }

      @res = self.class.post "/ios/baby/remove", options(data)

      if @res["rc"] == 0
        @babies.delete_if {|b| b.baby_id == baby.baby_id } 
        if @current_baby.id == baby.id
          @current_baby_id = nil
          @current_baby = nil
        end
      end
      self
    end

    def new_feed(args = {})
      start_time = args[:start_time]
      start_timestamp = start_time.to_i
      start_time_label = time_str(start_time)
      date_label = date_str(start_time)
      {
        "uuid": uuid,
        "bottle_ml": args[:bottle_ml] || 10,
        "baby_id": @current_baby.baby_id,
        "feed_type": 3, # bottle feed
        "sync_uuid": "x-coredata:\/\/#{uuid}\/ManagedBabyFeedData\/p1",
        "start_timestamp": start_timestamp,
        "start_time_label": start_time_label,
        "date_label": date_label,
        "action_user_id": @user_id
      }
    end

    def new_sleep(args = {})
      start_time = args[:start_time]
      end_time = args[:end_time]
      
      start_timestamp = start_time.to_i
      start_time_label = time_str(start_time)

      date_label = date_str(start_time)

      end_timestamp = end_time.to_i
      end_time_label = time_str(end_time)

      {
        "uuid": uuid,
        "end_timestamp": end_timestamp,
        "end_time_label": end_time_label,
        "baby_id": @current_baby.baby_id,
        "key": "sleep",
        "sync_uuid": "x-coredata:\/\/#{uuid}\/ManagedBabyData\/p1",
        "start_timestamp": start_timestamp,
        "start_time_label": start_time_label,
        "date_label": "2016\/01\/07",
        "action_user_id": @user_id
      }
    end

    def add_sleep(sleep)
      data = {
        "data": {
          "babies": [{
            "baby_id": @current_baby.baby_id,
            "BabyData": {
              "create": [sleep]
            }
          }]
        },
        "ut": @ut
      }.merge(common_data)

      @res = self.class.post "/ios/user/push", options(data)
      self
    end

    def add_feed(feed)
      data = {
        "data": {
          "babies": [{
            "baby_id": @current_baby.baby_id,
            "BabyFeedData": {
              "create": [feed]
            }
          }]
        },
        "ut": @ut
      }.merge(common_data)

      @res = self.class.post "/ios/user/push", options(data)
      self
    end


    def new_weight(args = {})
      {
        "uuid": uuid,
        "val_float": args[:weight] || @current_baby.weight,
        "baby_id": @current_baby.baby_id,
        "key": "weight",
        "sync_uuid": "x-coredata:\/\/#{uuid}\/ManagedBabyData\/p1",
        "date_label": args[:date] || date_str(Date.today),
        "action_user_id": @user_id
      }
    end

    def new_height(args = {})
      {
        "uuid": uuid,
        "val_float": args[:height] || @current_baby.height,
        "baby_id": @current_baby.baby_id,
        "key": "height",
        "sync_uuid": "x-coredata:\/\/#{uuid}\/ManagedBabyData\/p2",
        "date_label": args[:date] || date_str(Date.today),
        "action_user_id": @user_id
      }
    end

    def new_head_circ(args = {})
      {
        "uuid": uuid,
        "val_float": args[:headcirc] || @current_baby.headcirc,
        "baby_id": @current_baby.baby_id,
        "key": "headcirc",
        "sync_uuid": "x-coredata:\/\/#{uuid}\/ManagedBabyData\/p3",
        "date_label": args[:date] || date_str(Date.today),
        "action_user_id": @user_id
      }
    end

    def add_weight(args = {})
      data = {
        "data": {
          "babies": [{
            "baby_id": @current_baby.baby_id,
            "BabyData": {
              "create": [new_weight(args)]
            }
          }]
        },
        "ut": @ut
      }.merge(common_data)

      @res = self.class.post "/ios/user/push", options(data)
    end

    def add_height(args = {})
      data = {
        "data": {
          "babies": [{
            "baby_id": @current_baby.baby_id,
            "BabyData": {
              "create": [new_height(args)]
            }
          }]
        },
        "ut": @ut
      }.merge(common_data)

      @res = self.class.post "/ios/user/push", options(data)
      self
    end

    def add_headcirc(args = {})
      data = {
        "data": {
          "babies": [{
            "baby_id": @current_baby.baby_id,
            "BabyData": {
              "create": [new_head_circ(args)]
            }
          }]
        },
        "ut": @ut
      }.merge(common_data)

      @res = self.class.post "/ios/user/push", options(data)
      self
    end

    def add_growth_data(args = {})
      data = {
        "data": {
          "babies": [{
            "baby_id": @current_baby.baby_id,
            "BabyData": {
              "create": [new_weight(args), new_height(args), new_head_circ(args)]
            }
          }]
        },
        "ut": @ut
      }.merge(common_data)

      @res = self.class.post "/ios/user/push", options(data)
      self
    end

    def create_baby_feed(args = {})
      start_time = args[:start_time] || 50.minutes.ago

      {
        "breast_left_time": 50,
        "uuid": uuid,
        "baby_id": @current_baby.baby_id,
        "feed_type": 1,
        "sync_uuid": "x-coredata:\/\/#{uuid}\/ManagedBabyFeedData\/p1",
        "start_timestamp": start_time.to_i,
        "start_time_label": start_time.strftime("%Y\/%m\/%d %H:%M:%S"), # "2016\/01\/05 14:37:43",
        "date_label": args[:date] || date_str(Date.today),
        "breast_right_time": 0,
        "action_user_id": @user_id
      }
    end

    def add_baby_feed_data(args = {})
      data = {
        "data": {
          "babies": [{
            "baby_id": @current_baby.baby_id,
            "BabyFeedData": {
              "create": [create_baby_feed(args)]
            }
          }]
        },
        "ut": @ut
      }.merge(common_data)
      @res = self.class.post "/ios/user/push", options(data)
      self
    end

    def ms_smile
      {
        "title": "#{@current_baby.first_name} can smile at people.",
        "uuid": uuid,
        "baby_id": @current_baby.baby_id,
        "milestone_reference_id": 20101,
        "sync_uuid": "x-coredata:\/\/#{uuid}\/ManagedBabyMilestone\/p1",
        "date_label": date_str(1.day.ago),
        "action_user_id": @user_id
      }
    end

    def ms_baby_born
      {
        "title": "Baby's born",
        "uuid": uuid,
        "baby_id": @current_baby.baby_id,
        "milestone_reference_id": 0,
        "sync_uuid": "x-coredata:\/\/#{uuid}\/ManagedBabyMilestone\/p1",
        "date_label": @current_baby.birthday,
        "action_user_id": @user_id
      }
    end

    def add_mile_stone
      data = {
        "data": {
          "babies": [{
            "baby_id": @current_baby.baby_id,
            "BabyMilestone": {
              "create": [ms_baby_born]
            }
          }]
        },
        "ut": @ut
      }.merge(common_data)
      
      @res = self.class.post "/ios/user/push", options(data)
      self
    end

    # Me
    def change_password(args = {})
      data = {
        "new": args[:new],
        "old": args[:old],
        "ut": @ut
      }.merge(common_data)

      @res = self.class.post "/ios/user/change_password", options(data)
      self
    end

    def update_baby_profile(baby)
      data = {
        "data": {
          "babies": [{
            "baby_id": baby.baby_id,
            "Baby": {
              "update": [{
                "sync_uuid": "x-coredata:\/\/#{uuid}\/ManagedBaby\/p2",
                "first_name": baby.first_name,
                "last_name": baby.last_name,
                "gender": baby.gender,
                "birthday": baby.birthday,
                "birth_due_date": baby.birth_due_date,
                "birth_weight": baby.birth_weight,
                "birth_height": baby.birth_height,
                "birth_head": baby.birth_headcirc,
                "ethnicity": baby.ethnicity.join(","), # "1,2,4,5,3"
                "baby_id": baby.baby_id
              }]
            }
          }]
        },
        "ut": @ut
      }.merge(common_data)

      @res = self.class.post "/ios/user/push", options(data)
      self
    end

    def change_relation(relation)
      data = {
        "relation": relation.capitalize,
        "baby_id": current_baby.baby_id,
        "ut": @ut
      }.merge(common_data)

      @res = self.class.post "/ios/baby/change_relation", options(data)
      self
    end

    def invite_family(args = {})
      partner = args[:partner]
      data = {
        "relation": args[:relation] || "Father",
        "name": partner.first_name + ' ' + partner.last_name,
        "baby_id": @current_baby.baby_id,
        "email": partner.email,
        "ut": @ut
      }.merge(common_data)

      @res = self.class.post "/ios/baby/invite_family", options(data)
      log_msg "Partner #{partner.email} has been invited"

      # Connect partners in both direction
      @partners << partner
      partner.partners << self

      # set partner values
      partner.user_id = @res["data"]["BabyFamily"]["update"].first["user_id"]
      partner.gender = @res["data"]["BabyFamily"]["update"].first["gender"]
      partner.current_baby_id = @res["data"]["BabyFamily"]["update"].first["current_baby_id"]
      self
    end

    def delete_partner(partner)
      # delete partners in both direction
      @partners.delete_if { |p| p.user_id == partner.user_id }
      partner.partners.delete_if { |pp| pp.user_id == @user_id }
    end

    def disconnect(baby, partner)
      data = {
        "baby_id": baby.baby_id,
        "family_user_id": partner.user_id,
        "ut": @ut
      }.merge(common_data)

      @res = self.class.post "/ios/baby/disconnect_family", options(data)

      if @res["rc"] == 0
        delete_partner(partner)
      end
      self
    end

    def change_email(new_email)
      data = {
        "email": new_email,
        "ut": @ut
      }.merge(common_data)

      @res = self.class.post "/ios/user/change_email", options(data)
      self
    end

    def update_account_settings(args = {})
      data = {
        "data": {
          "user": {
            "User": {
              "update": [{
                "sync_uuid": "x-coredata:\/\/#{uuid}\/ManagedUser\/p1",
                "user_id": @user_id,
                "receive_push_notification": args[:receive_push_notification] || 1
              }]
            },
            "user_id": @user_id
          }
        },
        "ut": @ut
      }.merge(common_data)

      @res = self.class.post "/ios/user/push", options(data)
      self
    end

    def turn_off_push_notification
      update_account_settings receive_push_notification: 0
    end

  end
end
