require 'httparty'
require 'active_support/all'

require_relative 'test_helper'
require_relative "MultipartImage_Android.rb"
require_relative 'ForumApiAndroid'
require_relative 'env_config'

PASSWORD = 'Glow12345'
GROUP_ID = 3
TARGET_GROUP_NAME = "1st Child"
IMAGE_ROOT = File.dirname(__FILE__) + "/../../../images/"
GROUP_CATEGORY = {"Glow" => 1, "Nurture" => 3, "Sex & Relationships" => 6, "Health & Lifestyle" => 7, "Tech Support" => 5, "Eve" => 20, "Baby" => 199}

module NoahForumAndroid
  extend TestHelper

  def forum_new_user(args={})
    ForumUser.new(args).signup.login
  end
  
  def old_version_user(args = {})
    android_version = args[:android_version] || "1.0.0-milestestapi"
    vc = args[:vc] || 10000
    ForumUser.new(:android_version => android_version, :vc => vc).signup.login
  end

  class ForumUser < ForumApiAndroid::ForumAndroid
    include TestHelper
    include HTTParty
    include AndroidConfig
    base_uri AndroidConfig.base_url

    attr_accessor :email, :password, :first_name, :last_name, :gender, :birthday
    attr_accessor :relation, :partners, :status
    attr_accessor :babies, :current_baby, :user_id, :current_baby_id

    attr_accessor :res, :ut, :topic_id, :reply_id, :topic_title, :reply_content, :group_id, :all_group_ids
    attr_accessor :tmi_flag, :group_name, :group_description, :group_category, :android_version, :vc
    attr_accessor :tgt_user_id, :request_id, :all_participants


    def initialize(args = {})
      @first_name = (args[:first_name] || "ba") + Time.now.to_i.to_s[2..-1] + random_str_b(2)
      @email = args[:email] || "#{@first_name}@g.com"
      @last_name = "Miles_test"
      @password = args[:password] || PASSWORD
      @relation = args[:relation] || "Mother"
      @birthday = args[:birthday] || 30.years.ago.to_i
      @babies = []
      @partners = []
      @forum_hl = "en_US"
      @forum_random = rand.to_s[2..15]
      @forum_device_id = "f1506217d3d7" + ('0'..'9').to_a.shuffle[0,4].join
      @forum_android_version = args[:android_version] || "1.1.99-milestestapi"
      @forum_vc = args[:vc] || 10199
      @forum_time_zone = "American%2FNew_York"
      @code_name = "noah"
      @additional_forum = additional_forum.to_param
    end

    def additional_forum
      {
        "hl": @forum_hl,
        "random": @forum_random,
        "device_id": @forum_device_id,
        "android_version": @forum_android_version,
        "vc": @forum_vc,
        "tz": @forum_time_zone,
        "code_name": @code_name
      }
    end

    def common_data
      data = {
        "hl": "en_US",
        "random": @forum_random,
        "device_id": @forum_device_id,
        "android_version": @forum_android_version,
        "vc": @forum_vc,
        "tz": @forum_time_zone,
        "code_name": "noah",
      }.to_param
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



    def complete_tutorial
      self
    end
    
    def signup(args = {})
      user = args[:user] || self
      data = {
        "user": {
          "first_name": user.first_name,
          "last_name": user.last_name,
          "email": user.email,
          "password": user.password,
          "birthday": @birthday,
          "birthday_str": "1980\/04\/22"
        }
      }
      user.res = self.class.post "/android/user/sign_up?#{common_data}", options(data)
      user.ut = user.res["data"]["user"]["encrypted_token"]
      user.user_id = user.res["data"]["user"]["id"]
      # log_msg "#{@email} has been signed up. [user_id: #{@user_id}]"
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
        @first_name = @res["data"]["user"]["first_name"]
        log_important email + " just logged in. [user_id: #{@user_id}]"
      end
      self
    end

    def pull
      data = {
        "data": {
          "user": {},
          "babies": []
        }
      }
      @res = self.class.post "/android/user/pull?#{common_data}", auth_options(data)
      @notifications = @res["data"]["user"]["Notification"]["update"] if not @res["data"]["user"]["Notification"].nil?
      log_important "No notification field in response" if @res["data"]["user"]["Notification"].nil?
      self
    end

    def daily_content
      @res = self.class.get "/android/user/daily_content?#{common_data}"
      self
    end
  end
end
