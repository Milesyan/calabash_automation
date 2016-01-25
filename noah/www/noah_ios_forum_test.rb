require 'httparty'
require 'faker'
require 'json'
require 'securerandom'
require 'active_support/all'
require 'yaml'
require_relative "MultipartImage_IOS.rb"
require_relative 'noah_test_helper'

GROUP_ID = 3
TARGET_GROUP_NAME = "1st Child"

module NoahForumIOS
  extend BabyTestHelper 
  PASSWORD = 'Glow12345'
  BASE_URL = load_config["base_urls"]["Sandbox"]
  FORUM_BASE_URL = load_config["base_urls"]["SandboxForum"]
  IMAGE_ROOT = "../../images/"
  GROUP_CATEGORY = {"Glow" => 1, "Nurture" => 3, "Sex & Relationships" => 6, "Health & Lifestyle" => 7, "Tech Support" => 5, "Eve" => 20, "Baby" => 199}


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

  class NoahUser
    include BabyTestHelper
    include HTTParty
    attr_accessor :email, :password, :ut, :user_id, :topic_id, :reply_id, :topic_title, :reply_content,:group_id,:all_group_ids
    attr_accessor :first_name, :last_name, :gender,:birth_due_date, :birth_timezone
    attr_accessor :res
    attr_accessor :current_baby, :current_baby_id, :birthday, :relation 

    def initialize(args = {})  
      @first_name = (args[:first_name] || "noah") + ('0'..'3').to_a.shuffle[0,3].join + Time.now.to_i.to_s[-4..-1]
      @email = args[:email] || "#{@first_name}@g.com"
      @last_name = "Noah"
      @password = args[:password] || PASSWORD
      @partners = []
      @birthday = args[:birthday] || 25.years.ago.to_i
      @babies = []
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


    def options(data)
      { :body => data.to_json, :headers => { 'Content-Type' => 'application/json' }}
    end

    def common_data
      {
        "app_version" => "1.0",
        "locale" => "en_US",
        "time_zone"=> "Asia\/Shanghai",
        "device_id" => "139E7990-DB88-4D11-9D6B-290" + random_str,
        "model" => "iPhone7,1",
      }
    end

    def signup(args = {})
      user = args[:user] || self
      data = {
        "onboarding_info": {
        "birthday": user.birthday,
        "first_name": user.first_name,
        "last_name": user.last_name,
        "email": args[:email] || user.email,
        "password": args[:password] || user.password
        },
      }.merge(common_data)
      @res = HTTParty.post "#{BASE_URL}/ios/user/signup", options(data)
      user.user_id = @res["data"]["user"]["user_id"]
      puts "#{user.email} has been signed up"
      puts "User id is >>>>#{user.user_id}<<<<"
      self
    end

    def login(email = nil, password = nil)
      # the response of login doesn't return the rc code
      data = {
        "email": email || @email,
        "password": password || @password
      }.merge(common_data)
      @res = HTTParty.post "#{BASE_URL}/ios/user/login", options(data)
      @ut = @res["data"]["user"]["encrypted_token"]
      @user_id = @res["data"]["user"]["id"]
      puts "Login User id is #{@user_id}"
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

      @res = self.class.post "#{BASE_URL}/ios/user/pull", options(data)

      if @res["rc"] == 0
        @notifications = @res["data"]["user"]["Notification"]["update"]
      end
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

      @res = self.class.post "#{BASE_URL}/ios/baby/create", options(data)

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

      @res = self.class.post "#{BASE_URL}/ios/baby/create", options(data)

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

      @res = self.class.post "#{BASE_URL}/ios/baby/remove", options(data)

      if @res["rc"] == 0
        @babies.delete_if {|b| b.baby_id == baby.baby_id } 
        if @current_baby.id == baby.id
          @current_baby_id = nil
          @current_baby = nil
        end
      end
      self
    end



    ######## Community

    def create_topic(args = {})
      topic_data = {
        "code_name": "noah",
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
        "code_name": "noah",
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
        "code_name": "noah",
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
        "code_name": "noah",
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
        "code_name": "noah",
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
        "code_name": "noah",
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
        "code_name": "noah",
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
        "code_name": "noah",
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
        "code_name": "noah",
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{FORUM_BASE_URL}/topic/#{topic_id}/remove", :body => reply_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      self
      puts "#{topic_id} deleted"
    end



    def follow_user(user_id)
      reply_data = {
        "code_name": "noah",
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{FORUM_BASE_URL}/user/#{user_id}/follow", :body => reply_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      self
      puts "#{user_id} is followed by user #{self.user_id}"
    end

    def unfollow_user(user_id)
      reply_data = {
        "code_name": "noah",
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{FORUM_BASE_URL}/user/#{user_id}/unfollow", :body => reply_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      self
      puts "#{user_id} is unfollowed by user #{self.user_id}"
    end

    def block_user(user_id)
      reply_data = {
        "code_name": "noah",
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{FORUM_BASE_URL}/user/#{user_id}/block", :body => reply_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      self
      puts "#{user_id} is blocked by user #{self.user_id}"
    end

    def unblock_user(user_id)
      reply_data = {
        "code_name": "noah",
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{FORUM_BASE_URL}/user/#{user_id}/unblock", :body => reply_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      self
      puts "#{user_id} is unblocked by user #{self.user_id}"
    end  

    def bookmark_topic(topic_id)
      topic_data = {
        "code_name": "noah",
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
        "code_name": "noah",
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
        "code_name": "noah",
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
        "code_name": "noah",
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
        "code_name": "noah",
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
        "code_name": "noah",
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
        "code_name": "noah",
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
        "code_name": "noah",
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
        "code_name": "noah",
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
        "code_name": "noah",
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
        "code_name": "noah",
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
        "code_name": "noah",
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
        "code_name": "noah",
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
        "code_name": "noah",
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
      puts "Photo created >>>>>>>>>>#{@topic_title}<<<<<<<"
      self
    end

    def create_group(args={})
      image_pwd = IMAGE_ROOT + Dir.new(IMAGE_ROOT).to_a.select{|f|    f.downcase.match(/\.jpg|\.jpeg|\.png/) }.sample
      topic_data = {
        "ut": @ut,
        "desc": args[:group_description] || "Test group discription",
        "code_name": "noah",
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