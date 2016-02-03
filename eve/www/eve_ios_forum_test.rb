require 'httparty'
require 'json'
require 'securerandom'
require 'active_support/all'
require 'yaml'
require_relative 'eve_test_helper'
require_relative "MultipartImage_iOS.rb"

GROUP_ID = 3
TARGET_GROUP_NAME = "1st Child"


module EveForumIOS
  extend EveTestHelper 
  PASSWORD = 'Glow12345'
  BASE_URL = load_config["base_urls"]["Sandbox"]
  FORUM_BASE_URL = load_config["base_urls"]["SandboxForum"]
  IMAGE_ROOT = File.dirname(__FILE__) + "/../../images/"
  GROUP_CATEGORY = {"Glow" => 1, "Nurture" => 3, "Sex & Relationships" => 6, "Health & Lifestyle" => 7, "Tech Support" => 5, "Eve" => 20, "Baby" => 199}


  class EveUser
    attr_accessor :email, :password, :ut, :res, :user_id, :preg_id,:due_date, :due_in_weeks
    attr_accessor :first_name, :last_name, :gender, :topic_id, :reply_id, :topic_title
    attr_accessor :reply_content,:group_id,:all_group_ids


    def initialize(args = {})
      @first_name = (args[:first_name] || "ei") + Time.now.to_i.to_s
      @email = args[:email] || "#{@first_name}@g.com"
      @password = args[:password] || PASSWORD
      @birthday = args[:birthday] || 20.years.ago
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
        "app_version" => "1.5.1",
        "locale" => "en_US",
        "device_id" => "139E7990-DB88-4D11-9D6B-290" + random_str,
        "model" => "iPhone7,1",
        "language" => "en",
      }
    end


    def signup_guest
      @uuid = SecureRandom.uuid.upcase
      data = {
        "guest_token": @uuid,
        "install_data": nil,
        "branch_data": nil
      }.merge(common_data)
      @res = HTTParty.post("#{BASE_URL}/ios/users/signup_guest", :body => data.to_json, :headers => {'Content-Type' => 'application/json' })
      @ut = @res["data"]["encrypted_token"] 
      @user_id = @res["data"]["user_id"]
      puts "guest signup >>>#{@user_id} success" if @res["rc"] == 0
      self
    end

    def sync1
      data = {
        "sync_token": nil,
        "sync_items":[{"data":{"val_int":22,"time_modified": 10.seconds.ago.to_i,"id":0,"time_created":10.seconds.ago.to_i,"tag":0,"val_str":nil,"val_text":nil,"val_float":0,"time_removed":0,"profile_key":"period_cycle"},"model":"LXHealthProfile","type":1,"uuid": @uuid}],
          "ut": @ut,
          "need_pull":true,
          "additional_info":{"notification_last_read_time":nil,"time_zone":"Asia\/Shanghai","device_token":nil,"syncable_attributes":{"predict_rules":"-266860366612057925","fertile_score":"-1915309563115276298","localized_birth_control_topics":"-7258227771261759909"}}
      }.merge(common_data)
      @res = HTTParty.post("#{BASE_URL}/ios/users/sync", :body => data.to_json, :headers => {'Content-Type' => 'application/json' })
      self
    end

    def sync2
      data = {
        "sync_token":"0h7E0C-WpBIRj6jqyrc_uj_p8aokmDaMi0AYd3vmOYp9t9E_sGCjJ5M28NHsSuYY",
        "sync_items":[{"data":{"val_int":5,"time_modified": 10.seconds.ago.to_i,
          "id":0,"time_created": 10.seconds.ago.to_i,"tag":0,"val_str":nil,"val_text":nil,"val_float":0,"time_removed":0,"profile_key":"period_length"},
          "model":"LXHealthProfile","type":1,"uuid": @uuid}],
          "model":"x86_64",
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
      @res = HTTParty.post("#{BASE_URL}/ios/users/sync", :body => data.to_json, :headers => {'Content-Type' => 'application/json' })
      self
    end

    def sync3
      data = {
        "sync_token":"0h7E0C-WpBIRj6jqyrc_uhxEfUh3EpwjJx23O_B3O7vofQ1kJHL8IkqQNwlZp3Hr",
        "sync_items":[{"data":{"val_int":0,"time_modified": 10.seconds.ago.to_i,
          "id":0,"time_created": 10.seconds.ago.to_i,"tag":0,"val_str":nil,"val_text":nil,"val_float":0,"time_removed":0,"profile_key":"period_length"},
          "model":"LXHealthProfile","type":1,"uuid": @uuid}],
          "model":"x86_64",
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
      @res = HTTParty.post("#{BASE_URL}/ios/users/sync", :body => data.to_json, :headers => {'Content-Type' => 'application/json' })
      self
    end

    def get_daily_gems
      data = {
        "date": "2016\/02\/02",
        "fb": "2016\/02\/01",
        "fe": "2016\/02\/05",
        "next_pb": "2016\/02\/18",
        "pb": "2016\/01\/27",
        "pe": "2016\/01\/31",
        "types": "2",
        "ut": @ut
      }.merge(common_data)
      @res = HTTParty.get("#{BASE_URL}/ios/users/get_daily_gems", :body => data.to_json, :headers => {'Content-Type' => 'application/json' })
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
          "guest_token": @uuid
          },
        "branch_data":
          {
          "+clicked_branch_link":false,
          "+is_first_session":false
          }
      }.merge(common_data)
      puts "Signup with email:\n Email >>>#{@email}"
      @res = HTTParty.post("#{BASE_URL}/ios/users/signup_with_email", :body => data.to_json, :headers => {'Content-Type' => 'application/json' })
      self
    end

    
    def login_with_email(email = nil, password = nil)
      data = {
        "email": email || @email,
        "password": password || @password,
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
      @res = HTTParty.post("#{BASE_URL}/ios/users/login_with_email", :body => data.to_json,
        :headers => {'Content-Type' => 'text/plain' })
      @ut = @res["data"]["encrypted_token"] if @res["rc"] == 0
      self
    end

    def all_signup_flow
      signup_guest
      sync1
      sync2
      sync3
      get_daily_gems
      signup_with_email
      login_with_email
      self
    end
#-------Community 
    def create_topic
      topic_data = {
        "group_id": @group_id,
        "content": "#{Time.now.to_s}",
        "title": "#{Time.now.to_i}",
        "anonymous": 0,
        "ut": @ut,
      }.merge(common_data)

      @res =  HTTParty.post("#{BASE_URL}/ios/forum/topic/create", :body => topic_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      self
    end

    def reply_to_topic(topic_id)
      reply_data = {
        "topic_id": topic_id,
        "content": "Reply to topic #{Time.now}",
        "anonymous": 0,
        "reply_to": 0,
        "ut": @ut,
      }.merge(common_data)

      @res =  HTTParty.post("#{BASE_URL}/ios/forum/create_reply", :body => reply_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      self
    end

     def create_topic(args = {})
      topic_data = {
        "code_name": "lexie",
        "content": "#{Time.now.strftime "%D %T"}",
        "title": args[:topic_title] || "#{@email} #{Time.now}",
        "anonymous": 0,
        "ut": @ut
      }.merge(common_data)  # random_str isn't needed
      @group_id = args[:group_id] || GROUP_ID
      @res =  HTTParty.post("#{FORUM_BASE_URL}/group/#{@group_id}/create_topic", :body => topic_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @topic_id = @res["data"]["topic"]["id"]
      @group_id = @res["data"]["topic"]["group_id"]
      title = @res["data"]["topic"]["title"]
      @topic_title = title
      puts "topic >>>>>'#{title}'<<<<< created，topic id is #{topic_id}"
      self
    end

    def create_poll(args = {})
      topic_data = {
        "code_name": "lexie",
        "content": "#{Time.now.strftime "%D %T"}",
        "anonymous": 0,
        "title": args[:topic_title] || "Poll + #{@email} #{Time.now}",
        "options": ["Field1","Field2","Field3"].to_s,
        "ut": @ut
      }.merge(common_data)
      @group_id = args[:group_id] || GROUP_ID
      @res =  HTTParty.post("#{FORUM_BASE_URL}/group/#{@group_id}/create_poll", :body => topic_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @topic_id = @res["data"]["result"]["id"]
      title = @res["data"]["result"]["title"]
      @topic_title = title
      puts "Poll >>>>>'#{title}'<<<<< created, topic id is #{topic_id}"
      self
    end

    def vote_poll(args = {})
      vote_data = {
        "code_name": "lexie",
        "vote_index": 2,
        "ut": @ut
      }.merge(common_data)
      topic_id = args[:topic_id]
      @res = HTTParty.post("#{FORUM_BASE_URL}/topic/#{topic_id}/vote", :body => vote_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts "Topic #{topic_id} is voted"
      self
    end 


    def reply_to_topic(topic_id, args = {})
      reply_data = {
        "code_name": "lexie",
        "content": args[:reply_content]||"Reply to topic #{topic_id} and time is #{Time.now.to_i}",
        "anonymous": 0,
        "reply_to": 0,
        "ut": @ut
      }.merge(common_data)

      @res =  HTTParty.post("#{FORUM_BASE_URL}/topic/#{topic_id}/create_reply", :body => reply_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @reply_id = @res["data"]["result"]["id"] 
      puts "Reply to topic >>>>>#{topic_id}<<<<<"
      self
    end

    def reply_to_comment(topic_id,reply_id,args = {})
      reply_data = {
        "code_name": "lexie",
        "content": args[:reply_content] || "Reply to topic #{topic_id} and reply #{reply_id} "+Random.rand(10).to_s,
        "anonymous": 0,
        "reply_to": reply_id,
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{FORUM_BASE_URL}/topic/#{topic_id}/create_reply", :body => reply_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts "Reply to comment >>>>>#{reply_id}<<<<< under >>>>#{topic_id}<<<<"
      self
    end


    def join_group(group_id = GROUP_ID )
      data = {
        "code_name": "lexie",
        "ut": @ut
      }.merge(common_data)

      @res =  HTTParty.post("#{FORUM_BASE_URL}/group/#{group_id}/subscribe", :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts "     -----Should Join group #{group_id}-----    "
      get_all_groups
      puts "User current group : >>>#{@all_group_ids} <<<"
      self
    end



    def leave_group(leave_group_id)
      data = {
        "code_name": "lexie",
        "ut": @ut
      }.merge(common_data)
      unsubscribe_groupid = leave_group_id || GROUP_ID
      @res =  HTTParty.post("#{FORUM_BASE_URL}/group/#{unsubscribe_groupid}/unsubscribe", :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts "Leave group #{unsubscribe_groupid}"
      self
    end

    def vote_poll(args = {})
      vote_data = {
        "code_name": "lexie",
        "vote_index": 2,
        "ut": @ut
      }.merge(common_data)
      topic_id = args[:topic_id]
      @res = HTTParty.post("#{FORUM_BASE_URL}/topic/#{topic_id}/vote", :body => vote_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts "Topic #{topic_id} is voted"
      self
    end 

    def delete_topic(topic_id)
      reply_data = {
        "code_name": "lexie",
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{FORUM_BASE_URL}/topic/#{topic_id}/remove", :body => reply_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      self
      puts "#{topic_id} deleted"
    end



    def follow_user(user_id)
      reply_data = {
        "code_name": "lexie",
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{FORUM_BASE_URL}/user/#{user_id}/follow", :body => reply_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      self
      puts "#{user_id} is followed by user #{self.user_id}"
    end

    def unfollow_user(user_id)
      reply_data = {
        "code_name": "lexie",
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{FORUM_BASE_URL}/user/#{user_id}/unfollow", :body => reply_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      self
      puts "#{user_id} is unfollowed by user #{self.user_id}"
    end

    def block_user(user_id)
      reply_data = {
        "code_name": "lexie",
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{FORUM_BASE_URL}/user/#{user_id}/block", :body => reply_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      self
      puts "#{user_id} is blocked by user #{self.user_id}"
    end

    def unblock_user(user_id)
      reply_data = {
        "code_name": "lexie",
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{FORUM_BASE_URL}/user/#{user_id}/unblock", :body => reply_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      self
      puts "#{user_id} is unblocked by user #{self.user_id}"
    end  

    def bookmark_topic(topic_id)
      topic_data = {
        "code_name": "lexie",
        "bookmarked": 1,
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{FORUM_BASE_URL}/topic/#{topic_id}/bookmark", :body => topic_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts "topic #{topic_id} is bookmarked by #{self.user_id}"
      self
    end

    def unbookmark_topic(topic_id)
      topic_data = {
        "code_name": "lexie",
        "bookmarked": 0,
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{FORUM_BASE_URL}/topic/#{topic_id}/bookmark", :body => topic_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts "topic #{topic_id} is unbookmarked by #{self.user_id}"
      self
    end

#---------upvote downvote------------
    def upvote_topic(topic_id)
      topic_data = {
        "code_name": "lexie",
        "liked": 1,
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{FORUM_BASE_URL}/topic/#{topic_id}/like", :body => topic_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts "topic #{topic_id} is upvoted by #{self.user_id}"
      self
    end

    def cancel_upvote_topic(topic_id)
      topic_data = {
        "code_name": "lexie",
        "liked": 0,
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{FORUM_BASE_URL}/topic/#{topic_id}/like", :body => topic_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts "topic #{topic_id} is no longer upvoted by #{self.user_id}"
      self
    end

    def upvote_comment(topic_id, reply_id)
      topic_data = {
        "code_name": "lexie",
        "liked": 1,
        "topic_id": topic_id,
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{FORUM_BASE_URL}/reply/#{reply_id}/like", :body => topic_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts "Comment >>#{reply_id}<< under topic >>#{topic_id}<< is upvoted by >>#{self.user_id}<<"
      self
    end

    def cancel_upvote_comment(topic_id, reply_id)
      topic_data = {
        "code_name": "lexie",
        "liked": 0,
        "topic_id": topic_id,
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{FORUM_BASE_URL}/reply/#{reply_id}/like", :body => topic_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts "Comment #{reply_id} under topic #{topic_id}is no longer upvoted by #{self.user_id}"
      self
    end

    def downvote_topic(topic_id)
      topic_data = {
        "code_name": "lexie",
        "disliked": 1,
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{FORUM_BASE_URL}/topic/#{topic_id}/dislike", :body => topic_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts "topic #{topic_id} is downvoted by #{self.user_id}"
      self
    end

    def downvote_comment(topic_id, reply_id)
      topic_data = {
        "code_name": "lexie",
        "disliked": 1,
        "topic_id": topic_id,
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{FORUM_BASE_URL}/reply/#{reply_id}/dislike", :body => topic_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts "Comment #{reply_id} under topic #{topic_id}is downvoted by #{self.user_id}"
      self
    end
    def cancel_downvote_topic(topic_id)
      topic_data = {
        "code_name": "lexie",
        "disliked": 0,
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{FORUM_BASE_URL}/topic/#{topic_id}/dislike", :body => topic_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts "topic #{topic_id} is no longer downvoted by #{self.user_id}"
      self
    end

    def cancel_downvote_comment(topic_id, reply_id)
      topic_data = {
        "code_name": "lexie",
        "disliked": 0,
        "topic_id": topic_id,
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{FORUM_BASE_URL}/reply/#{reply_id}/dislike", :body => topic_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts "Comment #{reply_id} under topic #{topic_id}is no longer downvoted by #{self.user_id}"
      self
    end
#-----------Flag topic/comment--------------
    def report_topic(topic_id,report_reason)
      topic_data = {
        "code_name": "lexie",
        "reason": report_reason,
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{FORUM_BASE_URL}/topic/#{topic_id}/flag", :body => topic_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts "topic #{topic_id} is flagged for reason #{report_reason} by #{self.user_id}"
      self
    end

    def report_comment(topic_id, reply_id, report_reason)
      topic_data = {
        "code_name": "lexie",
        "reason": report_reason,
        "reply_id": reply_id,
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{FORUM_BASE_URL}/topic/#{topic_id}/flag", :body => topic_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts "comment #{reply_id} under #{topic_id} is flagged for reason #{report_reason} by #{self.user_id}"
      self
    end

    def get_all_groups
      group_data = {
        "code_name": "lexie",
        "ut": @ut
      }.merge(common_data)
      _res =  HTTParty.get("#{FORUM_BASE_URL}/user/#{self.user_id}/social_info", :body => group_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @all_group_ids = []
      @all_group_names = []
      _res["data"]["groups"].each do |element|
        element.each do |k,v|
          if k == "id"
            @all_group_ids.push v
          elsif k == "name"
            @all_group_names.push v
          end
        end
      end
      self
    end

    def leave_all_groups
      get_all_groups
      all_group_ids.each do |group_id|
        leave_group group_id
      end
      self
    end

    def get_all_group_names
      get_all_groups
      return @all_group_names
    end

    def get_all_group_ids
      get_all_groups
      return @all_group_ids
    end
    
    def create_photo(args={})
      image_pwd = IMAGE_ROOT + Dir.new(IMAGE_ROOT).to_a.select{|f|    f.downcase.match(/\.jpg|\.jpeg|\.png/) }.sample
      topic_data = {
        "title": args[:topic_title] || "Baby App IMAGE" + Time.now.to_s,
        "code_name": "lexie",
        "anonymous": 0,
        "ut": @ut,
        "warning": args[:tmi_flag] || 0,
        "image": File.new(image_pwd)
      }
      @group_id = args[:group_id] || GROUP_ID
      data,headers = MultipartImage::Post.prepare_query(topic_data)
      uri = URI ("#{FORUM_BASE_URL}/group/#{@group_id}/create_photo")
      http = Net::HTTP.new(uri.host, uri.port)
      _res = http.post(uri.path, data, headers)
      @res = JSON.parse _res.body
      @topic_title = @res["data"]["result"]["title"] 
      @topic_id = @res["data"]["result"]["id"]
      puts "Photo created >>>>>>>>>>#{@topic_title}<<<<<<<"
      self
    end

    def create_group(args={})
      image_pwd = IMAGE_ROOT + Dir.new(IMAGE_ROOT).to_a.select{|f|    f.downcase.match(/\.jpg|\.jpeg|\.png/) }.sample
      topic_data = {
        "ut": @ut,
        "desc": args[:group_description] || "Test group discription",
        "code_name": "lexie",
        "category_id": args[:group_category] || 1,
        "name": args[:group_name] || "Test create group",
        "image": File.new(image_pwd)
      }

      data,headers = MultipartImage::Post.prepare_query(topic_data)
      uri = URI ("#{FORUM_BASE_URL}/group/create")
      http = Net::HTTP.new(uri.host, uri.port)
      _res = http.post(uri.path, data, headers)
      @res = JSON.parse _res.body
      @group_id = @res["data"]["group"]["id"]
      @group_name = @res["data"]["group"]["name"]
      puts "Group created >>>>>>>>>>#{@group_id}<<<<<<<\r\n Group name  >>>>>>>>>#{@group_name}<<<<<<<<<<"
      self
    end

  end
end



