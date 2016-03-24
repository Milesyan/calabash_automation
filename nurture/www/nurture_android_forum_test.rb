require 'httparty'
require 'faker'
require 'active_support/all'
require_relative 'nurture_test_helper'
require_relative "MultipartImage_Android.rb"

GROUP_ID = 3
TARGET_GROUP_NAME = "1st Child"

module NurtureForumAndroid
  extend NurtureTestHelper

  PASSWORD = 'Glow12345'
  BASE_URL = load_config["base_urls"]["Sandbox1"]
  ANDROID_FORUM_BASE_URL = load_config["base_urls"]["SandboxForum1"]
  IMAGE_ROOT = File.dirname(__FILE__) + "/../../images/"
  GROUP_CATEGORY = {"Glow" => 1, "Nurture" => 3, "Sex & Relationships" => 6, "Health & Lifestyle" => 7, "Tech Support" => 5, "Eve" => 20, "Baby" => 199}


  class ForumUser
    include NurtureTestHelper
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
      @additional_forum = "?hl=#{@forum_hl}&android_version=#{@forum_android_version}&random=#{@forum_random}&device_id=#{@forum_device_id}&code_name=#{@forum_code_name}"
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




########## Community ###########
    def create_topic(args = {})
      data = {
        "title": args[:topic_title] || "#{@email} #{Time.now}",
        "anonymous": args[:anonymous]|| 0,
        "content": args[:topic_content] || ("Example create topic" + Time.now.to_s)
      }
      group_id = args[:group_id]|| GROUP_ID 
      url = "#{ANDROID_FORUM_BASE_URL}/group/#{group_id}/topic#{@additional_forum}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      @topic_title = @res["result"]["title"]
      @topic_id = @res["result"]["id"]
      puts "topic >>>>>'#{@topic_title}'<<<<< created，\ntopic id is >>>>#{@topic_id}<<<<, \ngroup_id is >>>>#{group_id}<<<<\n\n"
      self
    end


    def create_poll(args = {})
      data = {
        "title": args[:topic_title] || ("Test Poll" + Time.now.to_s),
        "anonymous": args[:anonymous]|| 0,
        "content": args[:topic_content] || ("Example create Poll" + Time.now.to_s),
        "poll_options": ["option1", "opiton2", "option3"].to_s
      }
      group_id = args[:group_id]|| GROUP_ID 
      url = "#{ANDROID_FORUM_BASE_URL}/group/#{group_id}/topic#{@additional_forum}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      @topic_title = @res["result"]["title"]
      @topic_id = @res["result"]["id"]
      puts "topic >>>>>'#{@topic_title}'<<<<< created，\ntopic id is >>>>#{@topic_id}<<<<, \ngroup_id is >>>>#{group_id}<<<<\n\n"
      self
    end




    def create_photo(args={})
      image_pwd = IMAGE_ROOT + Dir.new(IMAGE_ROOT).to_a.select{|f|    f.downcase.match(/\.jpg|\.jpeg/) }.sample
      topic_data = {
        "title": args[:topic_title] || ("Test Post Photo " + Time.now.to_s),
        "anonymous": args[:anonymous]|| 0,
        "warning": args[:tmi_flag] || 0,
        "image": File.new(image_pwd)
      }.merge(additional_post_data)
      @group_id = args[:group_id] || GROUP_ID
      data,headers = MultipartImage::Post.prepare_query(topic_data)
      headers = headers.merge({ "Authorization" => @ut })
      uri = URI("#{ANDROID_FORUM_BASE_URL}/group/#{group_id}/topic")
      http = Net::HTTP.new(uri.host, uri.port)
      _res = http.post(uri.path, data, headers)
      @res = JSON.parse _res.body
      @topic_title = @res["result"]["title"] 
      @topic_id = @res["result"]["id"]
      puts "Photo created >>>>>>>>>>#{@topic_title}<<<<<<<"
      self
    end

    def vote_poll(args= {})
      topic_id = args[:topic_id]
      vote_index = args[:vote_index] || 1
      data = {
        "vote_index": vote_index
      }
      url = "#{ANDROID_FORUM_BASE_URL}/topic/#{topic_id}/vote#{@additional_forum}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      if @res["rc"] == 0
        puts "#{topic_id} is voted by vote_index #{vote_index} and user #{self.user_id}"
      else 
        puts "#{@res}<<<  Expected repeated vote"
      end
      self
    end

    def reply_to_topic(topic_id, args = {})
      data = {
        "content": args[:reply_content] || ("Example reply to topic" + Time.now.to_s)
      }
      url = "#{ANDROID_FORUM_BASE_URL}/topic/#{topic_id}/reply#{@additional_forum}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      @reply_id = @res["result"]["id"]
      puts "reply_id is #{@reply_id}"
      self
    end

    def reply_to_comment(topic_id, reply_id, args = {})
      data = {
        "content": args[:reply_content] || ("Example reply to comment" + Time.now.to_s),
        "reply_to": reply_id
      }
      url = "#{ANDROID_FORUM_BASE_URL}/topic/#{topic_id}/reply#{@additional_forum}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      @sub_reply_id = @res["result"]["id"]
      self
    end
##########GROUP


    def join_group(group_id = GROUP_ID )
      data = {
        "group_id": group_id
      }
      url = "#{ANDROID_FORUM_BASE_URL}/group/subscribe#{@additional_forum}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "---#{self.user_id} joined group >>>#{group_id}<<<---"
      self
    end


    def leave_group(group_id)
      data = {
        "group_id": group_id
      }
      url = "#{ANDROID_FORUM_BASE_URL}/group/unsubscribe#{@additional_forum}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts " ---#{self.user_id} left group >>>#{group_id}<<<---"
      self
    end


    def get_all_groups
      group_data = {
      }
      url = "#{ANDROID_FORUM_BASE_URL}/user/0/groups#{@additional_forum}"
      _res =  HTTParty.get(url, :body => group_data.to_json,
        :headers => {  "Authorization" => @ut , 'Content-Type' => 'application/json' })
      @all_group_ids = []
      @all_group_names = []
      _res["groups"].each do |element|
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
      @all_group_ids.each do |group_id|
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


####Delete
    def delete_topic(topic_id)
      data = {}
      url = "#{ANDROID_FORUM_BASE_URL}/topic/#{topic_id}#{@additional_forum}"
      @res = HTTParty.delete(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "topic >>>>>'#{@topic_title}'<<<<< deleted\ntopic id is >>>>#{topic_id}<<<<\n\n"
      self
    end

    def follow_user(user_id)
      data = {
        "empty_stub": ""
      }
      url = "#{ANDROID_FORUM_BASE_URL}/user/#{user_id}/follow#{@additional_forum}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "User #{user_id} is followed by current user #{self.user_id}"  
      self
    end

    def unfollow_user(user_id)
      data = {
        "empty_stub": ""
      }
      url = "#{ANDROID_FORUM_BASE_URL}/user/#{user_id}/unfollow#{@additional_forum}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "User #{user_id} is unfollowed by current user #{self.user_id}"  
      self
    end

    def block_user(user_id)
      data = {
        "empty_stub": ""
      }
      url = "#{ANDROID_FORUM_BASE_URL}/user/#{user_id}/block#{@additional_forum}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "User #{user_id} is blocked by current user #{self.user_id}"  
      self
    end

    def unblock_user(user_id)
      data = {
        "empty_stub": ""
      }
      url = "#{ANDROID_FORUM_BASE_URL}/user/#{user_id}/unblock#{@additional_forum}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "User #{user_id} is unblocked by current user #{self.user_id}"  
      self
    end
  
    def bookmark_topic(topic_id)
      data = {
        "bookmarked": 1
      }
      url = "#{ANDROID_FORUM_BASE_URL}/topic/#{topic_id}/bookmark#{@additional_forum}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "topic id >>>>>'#{topic_id}'<<<<< is is bookmarked by #{self.user_id}\n\n"
      self
    end

    def unbookmark_topic(topic_id)
      data = {
        "bookmarked": 0
      }
      url = "#{ANDROID_FORUM_BASE_URL}/topic/#{topic_id}/bookmark#{@additional_forum}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "topic id >>>>>'#{topic_id}'<<<<< is unbookmarked by #{self.user_id}\n\n"
      self
    end

# ------------upvote downvote -----------
    def upvote_topic(topic_id)
      data = {
        "liked": 1
      }
      url = "#{ANDROID_FORUM_BASE_URL}/topic/#{topic_id}/like#{@additional_forum}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "topic id >>>>>'#{topic_id}'<<<<< is liked by #{self.user_id}\n\n"
      self
    end

    def cancel_upvote_topic(topic_id)
      data = {
        "liked": 0
      }
      url = "#{ANDROID_FORUM_BASE_URL}/topic/#{topic_id}/like#{@additional_forum}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "topic id >>>>>'#{topic_id}'<<<<< is no longer liked by #{self.user_id}\n\n"
      self
    end

    def downvote_topic(topic_id)
      data = {
        "disliked": 1
      }
      url = "#{ANDROID_FORUM_BASE_URL}/topic/#{topic_id}/dislike#{@additional_forum}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "topic id >>>>>'#{topic_id}'<<<<< is disliked by #{self.user_id}\n\n"
      self
    end

    def cancel_downvote_topic(topic_id)
      data = {
        "disliked": 0
      }
      url = "#{ANDROID_FORUM_BASE_URL}/topic/#{topic_id}/dislike#{@additional_forum}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "topic id >>>>>'#{topic_id}'<<<<< is no longer disliked by #{self.user_id}\n\n"
      self
    end

    def upvote_comment(topic_id, reply_id)
      data = {
        "topic_id": topic_id,
        "liked": 1
      }
      url = "#{ANDROID_FORUM_BASE_URL}/reply/#{reply_id}/like#{@additional_forum}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "Comment >>#{reply_id}<< under topic >>#{topic_id}<< is upvoted by #{self.user_id}\n"
      self
    end

    def cancel_upvote_comment(topic_id, reply_id)
      data = {
        "topic_id": topic_id,
        "liked": 0
      }
      url = "#{ANDROID_FORUM_BASE_URL}/reply/#{reply_id}/like#{@additional_forum}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "Comment >>#{reply_id}<< under topic >>#{topic_id}<< is no longer upvoted by #{self.user_id}\n"
      self
    end

    def downvote_comment(topic_id, reply_id)
      data = {
        "topic_id": topic_id,
        "disliked": 1
      }
      url = "#{ANDROID_FORUM_BASE_URL}/reply/#{reply_id}/dislike#{@additional_forum}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "Comment >>#{reply_id}<< under topic >>#{topic_id}<< is downvoted by #{self.user_id}\n"
      self
    end

    def cancel_downvote_comment(topic_id, reply_id)
      data = {
        "topic_id": topic_id,
        "disliked": 0
      }
      url = "#{ANDROID_FORUM_BASE_URL}/reply/#{reply_id}/dislike#{@additional_forum}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "Comment >>#{reply_id}<< under topic >>#{topic_id}<< is no longer downvoted by #{self.user_id}\n"
      self
    end

#-----------Flag topic/comment--------------
    def report_topic(topic_id, report_reason)
      data = {
        "reason": report_reason
      }
      url = "#{ANDROID_FORUM_BASE_URL}/topic/#{topic_id}/flag#{@additional_forum}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "Topic >>#{topic_id}<< is reported for reason >>>#{report_reason}<<< by >>>#{self.user_id}<<<\n"
      self
    end

    def report_comment(topic_id, reply_id, report_reason)
      data = {
        "reply_id": reply_id,
        "reason": report_reason
      }
      url = "#{ANDROID_FORUM_BASE_URL}/topic/#{topic_id}/flag#{@additional_forum}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "Comment >>>#{reply_id}<<< under >>#{topic_id}<< is reported for reason >>>#{report_reason}<<< by >>>#{self.user_id}<<<\n"
      self
    end

    def create_group(args={})
      image_pwd = IMAGE_ROOT + Dir.new(IMAGE_ROOT).to_a.select{|f|    f.downcase.match(/\.jpg|\.jpeg/) }.sample
      topic_data = {
        "name": args[:group_name] || ("Test Create Group"),
        "desc": args[:group_description]|| "Test Create Group Description",
        "category_id": args[:group_category] || 6,
        "image": File.new(image_pwd)
      }.merge(additional_post_data)
      data,headers = MultipartImage::Post.prepare_query(topic_data)
      headers = headers.merge({ "Authorization" => @ut })
      uri = URI("#{ANDROID_FORUM_BASE_URL}/group")
      http = Net::HTTP.new(uri.host, uri.port)
      _res = http.post(uri.path, data, headers)
      @res = JSON.parse _res.body
      @group_id = @res["group"]["id"]
      @group_name = @res["group"]["name"]
      puts "Group created >>>>>>>>>>#{@group_id}<<<<<<<\r\n Group name  >>>>>>>>>#{@group_name}<<<<<<<<<<"
      self
    end  


    # ---- PREMIUM ----
    def turn_off_chat(args={})
      data = {
        "website": nil,
        "chat_off":1,
        "signature_on":1
      }
      url = "#{ANDROID_FORUM_BASE_URL}/update_basic_info#{@additional_forum}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      log_important "TURN OFF CHAT FOR #{self.user_id} >>#{self.first_name}<<"
      self
    end

    def turn_on_chat(args={})
      data = {
        "website": nil,
        "chat_off":0,
        "signature_on":1
      }
      url = "#{ANDROID_FORUM_BASE_URL}/update_basic_info#{@additional_forum}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      log_important "TURN ON CHAT FOR #{self.user_id} >>#{self.first_name}<<"
      self
    end

    def turn_off_signature(args={})
      data = {
        "website": nil,
        "chat_off":0,
        "signature_on":0
      }
      url = "#{ANDROID_FORUM_BASE_URL}/update_basic_info#{@additional_forum}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      log_important "TURN OFF SIGNATURE FOR #{self.user_id} >>#{self.first_name}<<"
      self
    end


    def turn_on_signature(args={})
      data = {
        "website": nil,
        "chat_off":0,
        "signature_on":1
      }
      url = "#{ANDROID_FORUM_BASE_URL}/update_basic_info#{@additional_forum}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      log_important "TURN ON SIGNATURE FOR #{self.user_id} >>#{self.first_name}<<"
      self
    end

    def send_chat_request(tgt_user_id)
      chat_data = {
        "src": 2,
        "tgt_user_id": tgt_user_id,
      }
      @tgt_user_id = tgt_user_id
      @res = HTTParty.post("#{ANDROID_FORUM_BASE_URL}/chat/new#{@additional_forum}", :body => chat_data.to_json,
        :headers => { "Authorization" => @ut, 'Content-Type' => 'application/json' })
      log_important "#{self.user_id} send chat request to #{tgt_user_id}"
      self
    end

    def get_request_id
      chat_data = {}
      @res = HTTParty.get("#{ANDROID_FORUM_BASE_URL}/chats_and_participants#{@additional_forum}", :body => chat_data.to_json,
        :headers => { "Authorization" => @ut, 'Content-Type' => 'application/json' })
      @request_id = @res["requests"][0]["id"]
      self
    end

    def accept_chat
      get_request_id
      chat_data = {
        "request_id": @request_id,
      }
      @res = HTTParty.post("#{ANDROID_FORUM_BASE_URL}/chat/accept#{@additional_forum}", :body => chat_data.to_json,
        :headers => { "Authorization" => @ut, 'Content-Type' => 'application/json' })
      puts "#{self.user_id} accepts chat request id >>>#{@request_id}<<<"
      self
    end

    def establish_chat(tgt_user)
      send_chat_request tgt_user.user_id
      tgt_user.accept_chat
    end

    def ignore_chat
      get_request_id
      chat_data = {
        "request_id": @request_id,
      }
      @res = HTTParty.post("#{ANDROID_FORUM_BASE_URL}/chat/reject#{@additional_forum}", :body => chat_data.to_json,
        :headers => { "Authorization" => @ut, 'Content-Type' => 'application/json' })
      puts "#{self.user_id} rejects chat request id >>>#{@request_id}<<<"
      self
    end

    def remove_chat(tgt_user_id)
      chat_data = {
        "contact_uid": tgt_user_id,
      }
      @tgt_user_id = tgt_user_id
      @res = HTTParty.post("#{ANDROID_FORUM_BASE_URL}/chat/contact/remove#{@additional_forum}", :body => chat_data.to_json,
        :headers => { "Authorization" => @ut, 'Content-Type' => 'application/json' })
      puts @res
      puts "#{self.user_id} remove chat relationship with #{tgt_user_id}" if @res["rc"] ==0
      self
    end

    def get_all_participants
      chat_data = {
      }
      _res = HTTParty.get("#{ANDROID_FORUM_BASE_URL}/chats_and_participants#{@additional_forum}", :body => chat_data.to_json,
        :headers => { "Authorization" => @ut, 'Content-Type' => 'application/json' })
      @all_participants = []
      _res["participants"].each do |element|
        element.each do |k,v|
          if k == "id"
            @all_participants.push v
          end
        end
      end
      @all_participants
    end
    
    def remove_all_participants
      _participants = self.get_all_participants
      _participants.each do |id|
        remove_chat id
      end
      self
    end


  end
end

