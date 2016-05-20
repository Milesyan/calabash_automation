require 'httparty'
require 'json'
require 'securerandom'
require 'active_support/all'
require 'yaml'

require_relative "MultipartImage_iOS.rb"
require_relative 'test_helper'
require_relative 'ForumApi'
require_relative 'env_config'

PASSWORD = 'Glow12345'
GROUP_ID = 3
TARGET_GROUP_NAME = "1st Child"
IMAGE_ROOT = File.dirname(__FILE__) + "/../../../images/"
GROUP_CATEGORY = {"Glow" => 1, "Nurture" => 3, "Sex & Relationships" => 6, "Health & Lifestyle" => 7, "Tech Support" => 5, "Eve" => 20, "Baby" => 199}



module EveForumIOS
  def forum_new_user(args={})
    ForumUser.new(args).all_signup_flow
  end

  def old_version_user(args = {})
    app_version = args[:app_version] || '1.5.0'
    ForumUser.new(:app_version => app_version).all_signup_flow
  end

  class ForumUser < ForumApi::ForumIOS
    include TestHelper
    include IOSConfig
    attr_accessor :email, :password, :ut, :res, :user_id, :preg_id,:due_date, :due_in_weeks
    attr_accessor :first_name, :last_name, :gender, :topic_id, :reply_id, :topic_title
    attr_accessor :reply_content,:group_id,:all_group_ids, :birthday, :app_version


    def initialize(args = {})
      @first_name = (args[:first_name] || "ei") + Time.now.to_i.to_s
      @email = args[:email] || "#{@first_name}@g.com"
      @password = args[:password] || PASSWORD
      @birthday = args[:birthday] || [30.years.ago.to_i,19.years.ago.to_i].sample
      @code_name = 'lexie'
      @app_version = args[:app_version] || '1.6.0'
    end

    def uuid
      SecureRandom.uuid
    end

    def random_str
      ('0'..'9').to_a.shuffle[0,9].join + "_" + Time.now.to_i.to_s
    end

    def date_str(n=0)
      (Time.now + n*24*3600).strftime("%Y/%m/%d")
    end

    def create_first_name
      "ei" + Time.now.to_i.to_s
    end

    def common_data
      {
        "app_version" => @app_version,
        "locale" => "en_US",
        "device_id" => "139E7990-DB88-4D11-9D6B-290" + random_str,
        "model" => "iPhone7,1",
        "language" => "en",
      }
    end

    def complete_tutorial
      self
    end

    def signup_guest
      @guest_token = SecureRandom.uuid.upcase
      data = {
        "guest_token": @guest_token,
        "install_data": nil,
        "branch_data": nil
      }.merge(common_data)
      @res = HTTParty.post "#{base_url}/ios/users/signup_guest", options(data)
      @ut = @res["data"]["encrypted_token"] 
      @user_id = @res["data"]["user_id"]
      log_msg "guest signup >>>#{@user_id} success" if @res["rc"] == 0
      self
    end

    def sync1
      data = {
        "sync_token": "0h7E0C-WpBIRj6jqyrc_uj_p8aokmDaMi0AYd3vmOYp9t9E_sGCjJ5M28NHsSuYY",
        "sync_items":[{"data":
          {"val_int":22,
            "time_modified": 10.seconds.ago.to_i,
            "id":0,
            "time_created":10.seconds.ago.to_i,
            "tag":0,
            "val_str":nil,
            "val_text":nil,
            "val_float":0,
            "time_removed":0,
            "profile_key":"period_cycle"},
            "model":"LXHealthProfile",
            "type":1,
            "uuid": @uuid}],
          "ut": @ut,
          "need_pull":true,
          "additional_info":{"notification_last_read_time":nil,"time_zone":"Asia\/Shanghai","device_token":nil,"syncable_attributes":{"predict_rules":"-266860366612057925","fertile_score":"-1915309563115276298","localized_birth_control_topics":"-7258227771261759909"}}
      }.merge(common_data)
      @res = HTTParty.post "#{base_url}/ios/users/sync", options(data)
      self
    end

    def sync2
      data = {
        "sync_token": "0h7E0C-WpBIRj6jqyrc_uj_p8aokmDaMi0AYd3vmOYp9t9E_sGCjJ5M28NHsSuYY",
        "sync_items":[{"data":{"val_int":5,"time_modified": 10.seconds.ago.to_i,
          "id":0,"time_created": 10.seconds.ago.to_i,"tag":0,"val_str":nil,"val_text":nil,"val_float":0,"time_removed":0,"profile_key": "period_length"},
          "model":"LXHealthProfile","type":1,"uuid": @uuid}],
          "ut": @ut,
          "need_pull":true,
          "additional_info":{
            "notification_last_read_time":nil,
            "time_zone":"Asia\/Shanghai",
            "device_token":nil,
            "syncable_attributes":{
              "predict_rules": "-266860366612057925","fertile_score":"-1915309563115276298","localized_birth_control_topics":"-7258227771261759909"}
              }
      }.merge(common_data)
      @res = HTTParty.post "#{base_url}/ios/users/sync", options(data)
      self
    end

    def sync3
      data = {
        "sync_token": "0h7E0C-WpBIRj6jqyrc_uhxEfUh3EpwjJx23O_B3O7vofQ1kJHL8IkqQNwlZp3Hr",
        "sync_items":[{"data":{"val_int":1,"time_modified": 10.seconds.ago.to_i,
          "id":0,"time_created": 10.seconds.ago.to_i,"tag":0,"val_str":nil,"val_text":nil,"val_float":0,"time_removed":0,"profile_key": "birth_control"},
          "model":"LXHealthProfile","type":1,"uuid": @uuid}],
          "ut": @ut,
          "need_pull":true,
          "additional_info":{
            "notification_last_read_time":nil,
            "time_zone":"Asia\/Shanghai",
            "device_token":nil,
            "syncable_attributes":{
              "predict_rules":"-266860366612057925","fertile_score":"-1915309563115276298","localized_birth_control_topics":"-7258227771261759909"}
              }
      }.merge(common_data)
      @res = HTTParty.post "#{base_url}/ios/users/sync", options(data)
      self
    end

    def sync4
      period_uuid = SecureRandom.uuid.upcase
      data = {
        "sync_token": "0h7E0C-WpBIRj6jqyrc_ug5vBcJTijql-3bNVUs_rRDabB63xqYf7FF8CJHcRR2N",
        "sync_items":[{"data":{
          "id":0,"time_created": 10.seconds.ago.to_i,"pb": "2016\/04\/20","uuid": period_uuid,"pe": "2016\/04\/22","pb_prediction": nil,"pe_prediction": nil,"time_removed":0,"time_modified": 10.seconds.ago.to_i},
          "model":"LXPeriod","type":1,"uuid": @uuid}],
          "ut": @ut,
          "need_pull":true,
          "additional_info":{
            "notification_last_read_time":nil,
            "time_zone":"Asia\/Shanghai",
            "device_token": nil,
            "syncable_attributes":{
              "predict_rules":"-266860366612057925","fertile_score":"-1915309563115276298","localized_birth_control_topics":"-7258227771261759909"}
              }
      }.merge(common_data)
      @res = HTTParty.post "#{base_url}/ios/users/sync", options(data)
      self
    end


    def get_daily_gems
      data = {
        "date": "2016\/02\/18",
        "fb": "2016\/02\/01",
        "fe": "2016\/02\/05",
        "next_pb": "2016\/02\/18",
        "pb": "2016\/01\/27",
        "pe": "2016\/01\/31",
        "types": "5",
        "ut": @ut
      }.merge(common_data)
      @res = HTTParty.get "#{base_url}/ios/users/get_daily_gems", options(data)
      self
    end

    def signup_with_email
      data = {
        "user_info":
          { 
          "email": @email,
          "password": @password,
          "last_name": "",
          "birthday": @birthday,
          "first_name": @first_name
          },
        "install_data":
           {
            "af_message":"organic install",
            "af_status":"Organic"
            },
        "onboarding_info":{},
        "guest_info":
          {
          "guest_token": @guest_token
          },
        "branch_data":
          {
          "+clicked_branch_link":false,
          "+is_first_session":false
          }
      }.merge(common_data)
      @res = HTTParty.post "#{base_url}/ios/users/signup_with_email", options(data)
      @ut = @res["data"]["encrypted_token"] if @res["rc"] == 0
      @user_id = @res["data"]["user_id"]
      log_msg "#{@email} has been signed up. [user_id: #{@user_id}]"
      self
    end

    
    def login
      data = {
        "email": @email,
        "password": @password,
        "guest_info": 
          {
            "guest_token": @uuid,
          },
        "install_data":
          {
            "af_message":"organic install",
            "af_status":"Organic"
          },
        "branch_data":
          {
            "+clicked_branch_link":false,
            "+is_first_session":false
          }
      }.merge(common_data)
      @res = HTTParty.post "#{base_url}/ios/users/login_with_email", :body => data.to_json,
        :headers => {'Content-Type' => 'text/plain' }
      @ut = @res["data"]["encrypted_token"] if @res["rc"] == 0
      @user_id = @res["data"]["user_id"]
      @first_name = @res["data"]["first_name"]
      log_important "#{@email} just logged in. [user_id: #{@user_id}]"
      self
    end

    def all_signup_flow
      signup_guest
      sync1
      sync2
      sync3
      sync4
      signup_with_email
      login
      self
    end
    
    def pull
      sync1
      @notifications = @res["data"]["updates"]["notifications"] if @res["rc"] == 0
      log_important "RC IS NOT EQUAL to 0 in pull api call" if @res["rc"] != 0
      self
    end
  end
end



