require 'httparty'
require 'faker'
require 'active_support/all'
require_relative 'test_helper'
require_relative "MultipartImage_Android.rb"
require_relative 'ForumApiAndroid.rb'
GROUP_ID = 3
TARGET_GROUP_NAME = "1st Child"
IMAGE_ROOT = File.dirname(__FILE__) + "/../../images/"
GROUP_CATEGORY = {"Glow" => 1, "Nurture" => 3, "Sex & Relationships" => 6, "Health & Lifestyle" => 7, "Tech Support" => 5, "Eve" => 20, "Baby" => 199}
PASSWORD = 'Glow12345'

module NurtureForumAndroid
  extend TestHelper


  BASE_URL = load_config["base_urls"]["Sandbox1"]
  ANDROID_FORUM_BASE_URL = load_config["base_urls"]["SandboxForum1"]

  class ForumUser < ForumApiAndroid::ForumAndroid
    include TestHelper
    include HTTParty

    base_uri BASE_URL

    attr_accessor :email, :password, :first_name, :last_name, :gender, :birthday, :user_id,:due_date
    attr_accessor :res, :ut, :topic_id, :reply_id, :topic_title, :reply_content, :group_id, :all_group_ids
    attr_accessor :tmi_flag, :group_name, :group_description, :group_category
    attr_accessor :tgt_user_id, :request_id, :all_participants

    def initialize(args = {})
      @first_name = (args[:first_name] || "ba") + Time.now.to_i.to_s[2..-1] + random_str_b(2)
      @email = args[:email] || "#{@first_name}@g.com"
      @last_name = "Miles_test"
      @password = args[:password] || PASSWORD
      @birthday = args[:birthday] || 25.years.ago.to_i
      @due_date = args[:due_date] || 5.months.from_now.to_i
      @forum_user_height = 187
      @forum_hl = "en_GB"
      @forum_random = rand.to_s[2..16]
      @forum_device_id = "f1506217d3d7" + ('0'..'9').to_a.shuffle[0,4].join
      @forum_android_version = "20000"
      @forum_time_zone = "American\/New_York"
      @forum_code_name = "kaylee"
      @additional_forum = "hl=#{@forum_hl}&android_version=#{@forum_android_version}&random=#{@forum_random}&device_id=#{@forum_device_id}&code_name=#{@forum_code_name}"
    end

    def additional_post_data
      {
        "hl": @forum_hl,
        "android_version": @forum_android_version,
        "device_id": @forum_device_id,
        "random": @forum_random,
        "code_name": @forum_code_name
      }
    end
    
    def get_first_name
      "ba" + Time.now.to_i.to_s[2..-1] + random_str_b(2)
    end

    def random_str_b(n)
      (10...36).map{ |i| i.to_s 36}.shuffle[0,n.to_i].join
    end

    def random_str
      Time.now.to_i.to_s + ('0'..'9').to_a.shuffle[0,4].join
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
        "hl": @forum_hl,
        "app_version": @forum_android_version,
        "device_id": @forum_device_id,
        "random": @forum_random
      }.to_param
    end
    
    def complete_tutorial
      self
    end

    def signup(args = {})
      data = {
        "userinfo": {
          "password": @password,
          "as_partner": false,
          "tz": @forum_time_zone,
          "email": @email,
          "height": @forum_user_height,
          "birthday": @birthday,
          "first_name": @first_name
        },
        "onboardinginfo":{
          "prepare_number": 1,
          "weight": 90,
          "how": 0,
          "due_date": @due_date
        }
      }
      @res = self.class.post "/android/users/signup?#{common_data}", options(data)
      if @res["rc"] == 0
        @ut = @res["dict"]["encrypted_token"]
        @user_id = @res["dict"]["user_id"]
        log_msg @email + " has been signed up. [user_id: #{@user_id}]"
      end
      self
    end

    def login(args = {})
      email = args[:email] || @email
      password = args[:password] || @password
      data = {
        userinfo: {
          email: email,
          password: password
        }
      }
      @res = self.class.post "/android/users/signin?#{common_data}", options(data)
      if @res["rc"] == 0
        @ut = @res["dict"]["encrypted_token"]
        @user_id = @res["dict"]["user_id"]
        log_msg email + " just logged in. [user_id: #{@user_id}]"
        @first_name = @res["dict"]["first_name"]
      end
      self
    end

  end
end

