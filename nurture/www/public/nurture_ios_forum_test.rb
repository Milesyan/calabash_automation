require 'httparty'
require 'json'
require 'securerandom'
require 'active_support/all'
require 'yaml'
require_relative 'test_helper'
require_relative "MultipartImage_iOS.rb"
require_relative 'ForumApi'
require_relative 'env_config'

PASSWORD = 'Glow12345'
GROUP_ID = 3
TARGET_GROUP_NAME = "1st Child"
IMAGE_ROOT = File.dirname(__FILE__) + "/../../../images/"
GROUP_CATEGORY = {"Glow" => 1, "Nurture" => 3, "Sex & Relationships" => 6, "Health & Lifestyle" => 7, "Tech Support" => 5, "Eve" => 20, "Baby" => 199}



module NurtureForumIOS
  extend TestHelper 
  extend ForumApi

  def due_date_in_weeks(n = 40)
    Time.now.to_i + n.to_i*7*24*3600
  end

  def forum_new_user(args={})
    ForumUser.new(args).signup.login
  end

  def old_version_user(args = {})
    app_version = args[:app_version] || '2.8'
    ForumUser.new(:app_version => app_version).signup.login
  end

  class ForumUser < ForumApi::ForumIOS
    include IOSConfig
    attr_accessor :email, :password, :ut, :res, :user_id, :preg_id,:due_date, :due_in_weeks, :birthday
    attr_accessor :first_name, :last_name, :gender, :topic_id, :reply_id, :topic_title
    attr_accessor :reply_content,:group_id,:all_group_ids
    attr_accessor :tgt_user_id, :request_id, :all_participants, :app_version

    def initialize(args = {})
      @first_name = (args[:first_name] || "ni") + Time.now.to_i.to_s + random_str_b(3)
      @email = args[:email] || "#{@first_name}@g.com"
      @password = args[:password] || PASSWORD
      @due_in_weeks = args[:due_in_weeks]
      @code_name = 'kaylee'
      @birthday = args[:birthday] || 566452800
      @app_version = args[:app_version] || "3.0.0"
    end

    def uuid
      SecureRandom.uuid
    end

    def random_str
      ('0'..'9').to_a.shuffle[0,9].join + "_" + Time.now.to_i.to_s
    end

    def random_str_b(n)
      (10...36).map{ |i| i.to_s 36}.shuffle[0,n.to_i].join
    end

    def date_str(n=0)
      (Time.now + n*24*3600).strftime("%Y/%m/%d")
    end

    def create_first_name
      "ni" + Time.now.to_i.to_s
    end

    def common_data
      {
        "app_version" => @app_version,
        "locale" => "en_US",
        "device_id" => "VpqHBZ32za3BmwWj9DzKy4Hv-TPf1AaKNi89OZhCpRqc4K6YE6Zan-y8"+('A'..'Z').to_a.shuffle[0,9].join,
        "model" => "x86_64",
      }
    end
    
    def complete_tutorial
      self
    end

    def signup(args = {})
      data = {
        "onboardinginfo": {
          "pregnancy_number": 0,
          "appsflyer_install_data": {
            "af_message": "organic install",
            "af_status": "Organic"
          },
          "weight": 67.08639,
          "how": 0,
          "due_date": args[:due_date] || Time.now.to_i + 265*24*3600
        },
        "userinfo": {
          "height": 170,
          "password": @password,
          "tz": "Asia\/Shanghai",
          "last_name": "Kaylee",
          "birthday": @birthday,
          "email": @email,
          "as_partner": false,
          "first_name": @first_name
        }
      }.merge(common_data)
      @res = HTTParty.post "#{base_url}/ios/users/signup", options(data)
      @ut = @res["data"]["encrypted_token"]
      @user_id = @res["data"]["id"]
      @preg_id = @res["data"]["pregnancies"].first["id"]
      log_msg "#{@email} has been signed up. [user_id: #{@user_id}]"
      self
    end

    def get_premium(args = {})
      data = {
        "ut": @ut
      }.merge(common_data)
      @res = HTTParty.get "http://dragon-bryo.glowing.com/ios/plan/fetch", options(data)
      self 
    end

    def login
      data = {
        userinfo: {
          email: @email,
          tz: "Asia\/Shanghai",
          password: @password
        }
      }.merge(common_data)
      @res = HTTParty.post "#{base_url}/ios/users/signin", options(data)
      @ut = @res["data"]["encrypted_token"]
      @user_id = @res["data"]["id"]
      @gender = @res["data"]["gender"]
      @first_name = @res["data"]["first_name"]
      log_important "#{@email} just logged in. [user_id: #{@user_id}]"
      self
    end

    def pull
      data = {
        "article_ts": 10.days.ago.to_i,
        "checklist_ts": 0,
        "sign": "daily_log:-5297321039698049625|daily_task:-4144874413046290064|article_categories:1944778104830470978|health_rules:-4413499579029728433|appointments:-4801534297506013527|readability:571520",
        "support_postpartum": 1,
        "hp_ts": 0,
        "ts": 0,
        "ut": @ut
      }.merge(common_data)
      @res = HTTParty.get "#{base_url}/ios/users/pull", options(data)
      @notifications = @res["data"]["notifications"] if @res["rc"] == 0
      if @res["rc"] != 0
        log_important "RC IS NOT EQUAL to 0 in pull api call"
      end
      self
    end   
  end
end




