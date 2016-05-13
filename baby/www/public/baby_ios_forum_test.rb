require 'httparty'
require 'faker'
require 'json'
require 'securerandom'
require 'active_support/all'
require 'yaml'
require_relative "MultipartImage_IOS.rb"
require_relative 'test_helper'
require_relative 'ForumApi'
require_relative 'env_config'

PASSWORD = 'Glow12345'
GROUP_ID = 3
TARGET_GROUP_NAME = "1st Child"
IMAGE_ROOT = File.dirname(__FILE__) + "/../../../images/"
GROUP_CATEGORY = {"Glow" => 1, "Nurture" => 3, "Sex & Relationships" => 6, "Health & Lifestyle" => 7, "Tech Support" => 5, "Eve" => 20, "Baby" => 199}

module NoahForumIOS
  extend TestHelper 


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

  def forum_new_user(args={})
    ForumUser.new(args).signup.login
  end

  def old_version_user(args = {})
    app_version = args[:app_version] || '1.0.0'
    ForumUser.new(:app_version => app_version).signup.login
  end

  class ForumUser < ForumApi::ForumIOS
    include TestHelper
    include HTTParty
    include IOSConfig
    
    attr_accessor :email, :password, :ut, :user_id, :topic_id, :reply_id, :topic_title, :reply_content,:group_id,:all_group_ids
    attr_accessor :first_name, :last_name, :gender,:birth_due_date, :birth_timezone
    attr_accessor :res, :app_version
    attr_accessor :current_baby, :current_baby_id, :birthday, :relation 
    attr_accessor :tgt_user_id, :request_id, :all_participants
    
    def initialize(args = {})  
      @first_name = (args[:first_name] || "noah") + ('0'..'3').to_a.shuffle[0,3].join + Time.now.to_i.to_s[-4..-1]
      @email = args[:email] || "#{@first_name}@g.com"
      @last_name = "Noah"
      @password = args[:password] || PASSWORD
      @partners = []
      @birthday = args[:birthday] || 30.years.ago.to_i
      @babies = []
      @code_name = 'noah'
      @app_version = args[:app_version] || '1.2.0'
    end

    def random_str
      ('0'..'9').to_a.shuffle[0,9].join + "_" + Time.now.to_i.to_s
    end

    def uuid
      SecureRandom.uuid
    end

    def date_str(t)
      t.strftime("%Y/%m/%d")
    end

    def time_str(t)
      t.strftime("%Y/%m/%d %H:%M:%S")
    end

    def common_data
      {
        "app_version" => @app_version,
        "locale" => "en_US",
        "time_zone"=> "Asia\/Shanghai",
        "device_id" => "139E7990-DB88-4D11-9D6B-290" + random_str,
        "model" => "iPhone7,1"
      }
    end

    def complete_tutorial
      self
    end
    
    def signup(args = {})
      user = args[:user] || self
      data = {
        "onboarding_info": {
        "birthday": user.birthday,
        "first_name": user.first_name,
        "appsflyer_install_data":{
            "af_message": "organic install",
            "af_status": "Organic"
        },
        "email": args[:email] || user.email,
        "password": args[:password] || user.password
        },
      }.merge(common_data)
      @res = HTTParty.post "#{base_url}/ios/user/signup", options(data)
      user.user_id = @res["data"]["user"]["user_id"]
      log_important "#{user.email} has been signed up"
      log_important "User id is >>>>#{user.user_id}<<<<"
      self
    end

    def login(em = nil, password = nil)
      # the response of login doesn't return the rc code
      email = em || @email
      data = {
        "email": email,
        "password": password || @password
      }.merge(common_data)
      @res = HTTParty.post "#{base_url}/ios/user/login", options(data)
      @ut = @res["data"]["user"]["encrypted_token"]
      @user_id = @res["data"]["user"]["id"]
      @first_name = @res["data"]["user"]["first_name"]
      log_important email + " just logged in. [user_id: #{@user_id}]"
      self
    end

    def logout
      @ut = nil
    end

    ######## Baby Info
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

      @res = self.class.post "#{base_url}/ios/user/pull", options(data)
      @notifications = @res["data"]["user"]["Notification"]["update"] if not @res["data"]["user"]["Notification"].nil?
      log_important "No notification field in response" if @res["data"]["user"]["Notification"].nil?
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

      @res = self.class.post "#{base_url}/ios/baby/create", options(data)

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

      @res = self.class.post "#{base_url}/ios/baby/create", options(data)

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

      @res = self.class.post "#{base_url}/ios/baby/remove", options(data)

      if @res["rc"] == 0
        @babies.delete_if {|b| b.baby_id == baby.baby_id } 
        if @current_baby.id == baby.id
          @current_baby_id = nil
          @current_baby = nil
        end
      end
      self
    end


  end
end