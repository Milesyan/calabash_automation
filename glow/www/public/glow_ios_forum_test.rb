require 'httparty'
require 'json'
require 'securerandom'
require 'yaml'
require_relative "MultipartImage_IOS.rb"
require_relative 'test_helper'
require_relative 'ForumApi'

PASSWORD = 'Glow12345'
NEW_PASSWORD = 'Glow1234'
GROUP_ID = 5
IMAGE_ROOT = File.dirname(__FILE__) + "/../../../images/"
GROUP_CATEGORY = {"Glow" => 1, "Nurture" => 3, "Sex & Relationships" => 6, "Health & Lifestyle" => 7, "Tech Support" => 5, "Eve" => 20, "Baby" => 199}

module GlowForumIOS
  extend TestHelper 
  extend ForumApi

  BASE_URL = load_config["base_urls"]["Sandbox"]
  FORUM_BASE_URL = load_config["base_urls"]["SandboxForum"]

  def forum_new_user(args={})
    ForumUser.new(args).ttc_signup.login.complete_tutorial
  end

  class ForumUser < ForumApi::ForumIOS

    attr_accessor :email, :password, :ut, :user_id, :topic_id, :reply_id, :topic_title, :reply_content,:group_id,:all_group_ids
    attr_accessor :first_name, :last_name, :type, :res, :gender, :group_name, :group_description, :group_category, :vote_index


    def initialize(args = {})  
      @first_name = (args[:first_name] || "gi") + ('0'..'3').to_a.shuffle[0,3].join + Time.now.to_i.to_s[-4..-1]
      @email = args[:email] || "#{@first_name}@g.com"
      @last_name = "Glow"
      @password = args[:password] || PASSWORD
      @partner_email = "p#{@email}"
      @partner_first_name = "p#{@first_name}"
      @gender = args[:gender] || "female"
      @type = args[:type]
      @code_name = 'emma'
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
        "device_id" => "139E7990-DB88-4D11-9D6B-290" + random_str,
        "model" => "iPhone7,1",
        "random" => random_str,
      }
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
      log_important email + " has been signed up"
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
      puts "Login User id is #{@user_id}"
      self
    end

    def logout
      @ut = nil
    end

  end
end
