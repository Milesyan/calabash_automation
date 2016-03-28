require 'httparty'
require 'json'
require 'net/http'
require 'securerandom'
require 'uri'
# require 'active_support/all'
require_relative "MultipartImage_Android.rb"
require_relative 'test_helper'
require_relative 'ForumApiAndroid'

PASSWORD = 'Glow12345'
GROUP_ID = 3
TARGET_GROUP_NAME = "1st Child"
IMAGE_ROOT = File.dirname(__FILE__) + "/../../images/"
GROUP_CATEGORY = {"Glow" => 1, "Nurture" => 3, "Sex & Relationships" => 6, "Health & Lifestyle" => 7, "Tech Support" => 5, "Eve" => 20, "Baby" => 199}

module EveForumAndroid


  EVE_ANDROID_BASE_URL = "http://titan-lexie.glowing.com"
  ANDROID_FORUM_BASE_URL = "http://titan-forum.glowing.com/android/forum"  

  class ForumUser < ForumApiAndroid::ForumAndroid
    attr_accessor :email, :password, :ut, :user_id, :topic_id, :reply_id
    attr_accessor :topic_title, :reply_content,:group_id,:all_group_ids
    attr_accessor :first_name, :last_name, :type, :tmi_flag, :group_name, :group_description, :group_category 
    attr_accessor :res
    attr_accessor :birthday

    def initialize(args = {})  
      @first_name = (args[:first_name] || "Eve_A") + ('0'..'9').to_a.shuffle[0,3].join + Time.now.to_i.to_s[-4..-1]
      @email = args[:email] || "#{@first_name}@g.com"
      @last_name = "Eve"
      @password = args[:password] || PASSWORD
      @today_date = Time.new.strftime("%Y\/%m\/%d")
      @pb = (Time.new - 10*60*60*24).strftime("%Y\/%m\/%d")
      @pe = (Time.new - 6*60*60*24).strftime("%Y\/%m\/%d")
      @next_pb = (Time.new + 12*60*60*24).strftime("%Y\/%m\/%d")
      # @birthday = args[:birthday] || 25.years.ago.to_i
      @birthday =  632406657
      @forum_locale = "en_US"
      @forum_fc = 1
      @forum_random = random_str
      @forum_device_id = "f1506217d3d7" + ('0'..'9').to_a.shuffle[0,4].join
      @forum_android_version = "Eve_1.0_miles_test"
      @forum_app_version = "HAHAHA_2"
      @forum_time_zone = "Asia\/Shanghai"
      @forum_code_name = "lexie"
      @forum_ts = Time.now.to_i.to_s + ('0'..'9').to_a.shuffle[0,3].join
      @additional_forum = "device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&locale=#{@forum_locale}&tz=#{@forum_time_zone}&random=#{@forum_random}&ts=#{@forum_ts}&is_guest=0&code_name=#{@forum_code_name}"
      @additional_post_data = "device_id=#{@forum_device_id}&app_version=#{@forum_android_version}&locale=#{@forum_locale}&tz=#{@forum_time_zone}&random=#{@forum_random}&ts=#{@forum_ts}"
    end


    def hash_to_query(hash)
      return URI.encode(hash.map{|k,v| "#{k}=#{v}"}.join("&"))
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

    def additional_post_data
      {
        "device_id": @forum_device_id,
        "app_version": @forum_android_version,
        "locale": @forum_locale,
        "tz": @forum_time_zone,
        "random": random_str,
        "ts": @forum_ts
      }
    end

    def additional_forum
      {
        "device_id": @forum_device_id,
        "android_version": @forum_android_version,
        "locale": @forum_locale,
        "tz": @forum_time_zone,
        "random": @forum_random,
        "ts": @forum_ts,
        "is_guest": 0,
        "code_name": @forum_code_name
      }
    end

    def complete_tutorial
      self
    end
    
    def signup_guest
      @uuid = SecureRandom.uuid.upcase
      data = {
        "guest_token": @uuid
      }.merge(additional_post_data)
      @res = HTTParty.post("#{EVE_ANDROID_BASE_URL}/android/users/signup_guest", :body => data.to_json, :headers => {'Content-Type' => 'application/json' })
      @ut = @res["data"]["encrypted_token"] 
      @user_id = @res["data"]["user_id"]
      puts "guest signup >>>#{@user_id} success" if @res["rc"] == 0
      self
    end

    def sync_guest_info
      puts "#{@user_id}<<<<<<<<<<"
      data = {
        "user_id": -1,
        "sync_items": [{
          "HealthProfile": {
            "update": [{
              "user_id": -1,
              "period_cycle": 22
            }]
          }
        }, {
          "Period": {
            "create": [{
              "pb": "2016/01/14",
              "pe": "2016/01/18",
              "pe_prediction": "2016/01/18",
              "uuid": @uuid
            }]
          }
        }, {
          "HealthProfile": {
            "update": [{
              "user_id": @user_id,
              "period_length": 5
            }]
          }
        }],
        "need_pull": 1,
        "additional_info": {
          "notification_last_read_time": 0
        }
      }
      @res = HTTParty.post("#{EVE_ANDROID_BASE_URL}/android/users/sync?#{@additional_post_data}", :body => data.to_json, :headers => {'Authorization' => @ut, 'Content-Type' => 'application/json' })
      puts "sync success" if @res["rc"] == 0
      self
    end

    def sync_guest_info_2
      data ={
        "user_id": @user_id,
        "sync_token": "0h7E0C-WpBIRj6jqyrc_uvP8eWxRyWi8cQgRhztkdF7F0JisXIstSgmfR9BRRUR7",
        "sync_items": [{
          "User": {
            "update": [{
              "syncToken": "0h7E0C-WpBIRj6jqyrc_uvP8eWxRyWi8cQgRhztkdF7F0JisXIstSgmfR9BRRUR7"
            }]
          }
        }, {
          "HealthProfile": {
            "update": [{
              "user_id": @user_id,
              "birth_control": 0
            }]
          }
        }],
        "need_pull": 1,
        "additional_info": {
          "notification_last_read_time": 0
        }
      }.merge(additional_post_data)
      @res = HTTParty.post("#{EVE_ANDROID_BASE_URL}/android/users/sync", :body => data.to_json, :headers => {'Authorization' => @ut, 'Content-Type' => 'application/json' })
      self
    end

    def get_daily_gems
      data = {
        "date": @today_date,
        "pb": @pb,
        "types": "2,4",
        "next_pb": @next_pb,
        "pe": @pe,
        "device_id": @forum_device_id,
        "app_version": @forum_app_version,
        "locale": @forum_locale,
        "tz": @forum_time_zone,
        "random": random_str,
        "ts": @forum_ts
      }
      url = hash_to_query data
      @res = HTTParty.get("#{EVE_ANDROID_BASE_URL}/android/users/get_daily_gems?#{url}", :body => {}.to_json, :headers => {'Authorization' => @ut, 'Content-Type' => 'application/json' })
      self
    end

    def signup_with_email
      data = {
        "guest_info":
        {
          "guest_token": @uuid
        },
        "user_info":
        {
          "email": @email,
          "password": @password,
          "birthday": @birthday,
          "first_name": @first_name,
          "last_name": @last_name
        },
        "onboarding_info":{}
      }
      puts "Signup with email:\n Email >>>#{@email}"
      @res = HTTParty.post("#{EVE_ANDROID_BASE_URL}/android/users/signup_with_email?#{@additional_post_data}", :body => data.to_json, :headers => {'Content-Type' => 'application/json' })
      self
    end

    def all_signup_flow
      signup_guest
      sync_guest_info
      sync_guest_info_2
      # get_daily_gems
      signup_with_email
      login_with_email
      self
    end

    def login_with_email(email = nil, password = nil)
      data = {
        "email": email || @email,
        "password": password || @password,
        "guest_info": 
          {
            "guest_token": "E8E8E7D6-89EB-4157-A20C-35E23D05D884",
          }
      }

      @res = HTTParty.post("#{EVE_ANDROID_BASE_URL}/android/users/login_with_email?#{@additional_post_data}", :body => data.to_json,
        :headers => {'Content-Type' => 'text/plain' })
      @ut = @res["data"]["encrypted_token"] if @res["rc"] == 0
      self
    end

  end
end