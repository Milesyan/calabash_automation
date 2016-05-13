require 'httparty'
require 'json'
# require 'net/http'
require 'securerandom'
require 'uri'
require 'active_support/all'

require_relative "MultipartImage_Android.rb"
require_relative 'test_helper'
require_relative 'ForumApiAndroid'
require_relative 'env_config'

PASSWORD = 'Glow12345'
GROUP_ID = 3
TARGET_GROUP_NAME = "1st Child"
IMAGE_ROOT = File.dirname(__FILE__) + "/../../../images/"
GROUP_CATEGORY = {"Glow" => 1, "Nurture" => 3, "Sex & Relationships" => 6, "Health & Lifestyle" => 7, "Tech Support" => 5, "Eve" => 20, "Baby" => 199}

module EveForumAndroid

  def forum_new_user(args = {})
    ForumUser.new(args).all_signup_flow
  end
  
  def old_version_user(args = {})
    android_version = args[:android_version] || '10100'
    app_version = args[:app_version] || "1.1.0-milestestapi"
    ForumUser.new(:android_version => android_version, :app_version => app_version).all_signup_flow
  end

  class ForumUser < ForumApiAndroid::ForumAndroid
    include TestHelper
    include AndroidConfig
    attr_accessor :email, :password, :ut, :user_id, :topic_id, :reply_id
    attr_accessor :topic_title, :reply_content,:group_id,:all_group_ids
    attr_accessor :first_name, :last_name, :type, :group_name, :group_description, :group_category 
    attr_accessor :res, :android_version, :app_version
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
      @birthday =  args[:birthday] || [166984446,798798831].sample
      @forum_locale = "en_US"
      @forum_random = random_str
      @forum_device_id = "f1506217d3d7" + ('0'..'9').to_a.shuffle[0,4].join
      @forum_android_version = args[:android_version] || "10200"
      @forum_app_version = args[:app_version] || "1.2.0-milestestapi"
      @forum_time_zone = "Asia\/Shanghai"
      @code_name = "lexie"
      @forum_ts = Time.now.to_i.to_s + ('0'..'9').to_a.shuffle[0,3].join
      @additional_forum = additional_forum.to_param
      @additional_post_data = additional_post_data.to_param
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
        "app_version": @forum_app_version,
        "locale": @forum_locale,
        "tz": @forum_time_zone,
        "random": @forum_random,
        "ts": @forum_ts,
        "is_guest": 0,
        "code_name": @code_name
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
      @res = HTTParty.post "#{base_url}/android/users/signup_guest", options(data)
      @ut = @res["data"]["encrypted_token"] 
      @user_id = @res["data"]["user_id"]
      log_msg "guest signup >>>#{@user_id} success" if @res["rc"] == 0
      self
    end

    def sync_guest_info
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
              "pb": @pb,
              "pe": @pe,
              "pe_prediction": @pe,
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
      @res = HTTParty.post "#{base_url}/android/users/sync?#{@additional_post_data}", auth_options(data)
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
      @res = HTTParty.post "#{base_url}/android/users/sync", auth_options(data)
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
      @res = HTTParty.get "#{base_url}/android/users/get_daily_gems?#{url}", :body => {}.to_json, :headers => {'Authorization' => @ut, 'Content-Type' => 'application/json' }
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
      @res = HTTParty.post "#{base_url}/android/users/signup_with_email?#{@additional_post_data}", options(data)
      @user_id = @res["data"]["user_id"]
      @ut = @res["data"]["encrypted_token"] if @res["rc"] == 0
      log_msg "#{@email} has been signed up. [user_id: #{@user_id}]"
      self
    end

    def all_signup_flow
      signup_guest
      sync_guest_info
      sync_guest_info_2
      signup_with_email
      login
      self
    end

    def login
      data = {
        "email":  @email,
        "password": @password,
        "guest_info": 
          {
            "guest_token": "E8E8E7D6-89EB-4157-A20C-35E23D05D884",
          }
      }

      @res = HTTParty.post "#{base_url}/android/users/login_with_email?#{@additional_post_data}", :body => data.to_json,
        :headers => {'Content-Type' => 'text/plain' }
      @ut = @res["data"]["encrypted_token"] if @res["rc"] == 0
      @user_id = @res["data"]["user_id"]
      @first_name = @res["data"]["first_name"]
      log_important "#{@email} just logged in. [user_id: #{@user_id}]"
      self
    end


    def pull
      data = {
        "user_id": self.user_id,
        "sync_items": [],
        "need_pull": 1,
        "additional_info": {
          "notification_last_read_time": 0,
          "time_zone": @forum_time_zone
        }
      }
      @res = HTTParty.post "#{base_url}/android/users/sync?#{@additional_post_data}", auth_options(data)
      @notifications = @res["data"]["Notification"]["update"] if @res["rc"] == 0
      log_important "RC IS NOT EQUAL to 0 in pull api call" if @res["rc"] != 0
      self
    end
    
  end
end