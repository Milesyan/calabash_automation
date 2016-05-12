require 'httparty'
require 'json'
# require 'net/http'
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


module GlowForumAndroid
  extend TestHelper
  def forum_new_user(args = {})
    ForumUser.new(args).non_ttc_signup.login.complete_tutorial.join_group
  end

  class ForumUser < ForumApiAndroid::ForumAndroid
    include TestHelper
    include AndroidConfig
    attr_accessor :email, :password, :ut, :user_id, :topic_id, :reply_id, :topic_title, :reply_content,:group_id,:all_group_ids
    attr_accessor :first_name, :last_name, :type, :partner_email, :partner_first_name, :tmi_flag, :group_name, :group_description, :group_category
    attr_accessor :res, :vc, :android_version
    attr_accessor :gender, :birthday

    def initialize(args = {})
      @first_name = (args[:first_name] || "ga") + ('0'..'3').to_a.shuffle[0,3].join + Time.now.to_i.to_s[-4..-1]
      @email = args[:email] || "#{@first_name}@g.com"
      @last_name = "Glow"
      @password = args[:password] || PASSWORD
      @gender = args[:gender] || "female"
      @type = args[:type]
      @birthday = args[:birthday]
      @forum_hl = "en_US"
      @forum_fc = 1
      @forum_random = random_str
      @forum_device_id = "be3ca737160d" + ('0'..'9').to_a.shuffle[0,4].join
      @forum_android_version = args[:android_version] || "3.9.9-play-beta"
      @forum_vc = args[:vc] || 399
      @forum_time_zone = "Asia\/Shanghai"
      @code_name = "emma"
      @additional_forum = additional_post_data.to_param
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
        "hl": @forum_hl,
        "fc": @forum_fc,
        "random": @forum_random,
        "device_id": @forum_device_id,
        "android_version": @forum_android_version,
        "vc": @forum_vc,
        "time_zone": @forum_time_zone,
        "code_name": @code_name 
      }
    end

    def ttc_signup(args = {})
      age = args[:age] || 30
      data = {
        "user": {
          "android_version": "3.8.0-play-beta",
          "birthday": @birthday || (Time.now.to_i - age*365*24*3600),
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

      @res = HTTParty.post "#{base_url}/a/v2/users/signup", options(data)
      @ut = @res["user"]["encrypted_token"]
      @user_id = @res["user"]["id"]
      log_important email + " has been signed up"
      puts "User id is #{@user_id}"
      self
    end

    def non_ttc_signup
      data = {
        "user": {
          "android_version": "3.8.0-play-beta",
          "birthday": @birthday || 427048062,
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

      @res = HTTParty.post "#{base_url}/a/v2/users/signup", options(data)
      # json_res = eval(res.to_s)
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

      @res = HTTParty.post "#{base_url}/a/v2/users/push", auth_options(data)
      self
    end

    def login(email = nil, password = nil)
      data = {
        "email": email || @email,
        "password": password || @password
      }.merge(additional_post_data)

      @res = HTTParty.post "#{base_url}/a/users/signin", options(data)
      @ut = @res["user"]["encrypted_token"] if @res["rc"] == 0
      @user_id = @res["user"]["id"]
      @first_name = @res["user"]["first_name"]
      self
    end

    def logout
      # @ut = nil
      # self
      data = additional_post_data
      @res = HTTParty.post "#{base_url}/a/users/logout", auth_options(data)
      self
    end

    def forgot_password(email)
      data = {
        "email": email
      }.merge(additional_post_data)

      @res = HTTParty.post "#{base_url}/a/users/recover_password", options(data)
      self
    end

    def pull
      data = {
        "ts": 0,
        "sign": "todos:|activity_rules:|clinics:|fertile_score_coef:|fertile_score:|predict_rules:|health_rules:",
      }
      @res = HTTParty.get "#{base_url}/a/v2/users/pull?#{additional_post_data}", auth_options(data)
      @notifications = @res["notifications"] if @res["user_id"]
      log_important "RC IS NOT EQUAL to 0 in pull api call" if @res["user_id"].nil?
      self
    end
    
  end
end