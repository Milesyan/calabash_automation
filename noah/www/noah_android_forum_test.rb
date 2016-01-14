require 'httparty'
require 'faker'
require 'active_support/all'
require_relative 'noah_test_helper'

GROUP_ID = 3
TARGET_GROUP_NAME = "1st Child"

module NoahForumAndroid
  extend BabyTestHelper

  PASSWORD = 'Glow12345'
  BASE_URL = load_config["base_urls"]["Sandbox1"]
  ANDROID_FORUM_BASE_URL = load_config["base_urls"]["SandboxForum1"]
  IMAGE_ROOT = "/Users/Miles/automation/AutomationTests/glow/www/images/"

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

  class BabyUser
    include BabyTestHelper
    include HTTParty

    base_uri BASE_URL

    attr_accessor :email, :password, :first_name, :last_name, :gender, :birthday
    attr_accessor :relation, :partners, :status
    attr_accessor :babies, :current_baby, :user_id, :current_baby_id
    attr_accessor :res, :ut

    def initialize(args = {})
      @first_name = args[:first_name] || get_first_name
      @email = args[:email] || "#{@first_name}@g.com"
      @last_name = "Glow"
      @password = args[:password] || PASSWORD
      @relation = args[:relation] || "Mother"
      @birthday = args[:birthday] || 25.years.ago.to_i
      @babies = []
      @partners = []
    end

    def get_first_name
      "ba" + Time.now.to_i.to_s[2..-1] + random_str(2)
    end

    def random_str(n)
      (10...36).map{ |i| i.to_s 36}.shuffle[0,n.to_i].join
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
        "hl": "en_US",
        "random": random_num,
        "device_id": "be3ca737160d9da3",
        "android_version": "1.0-beta",
        "vc": 1,
        "time_zone": "Asia Shanghai",
        "code_name": "noah",
      }.to_param
    end

    def signup(args = {})
      user = args[:user] || self
      data = {
        "user": {
          "first_name": user.first_name,
          "last_name": user.last_name,
          "email": user.email,
          "password": user.password
        }
      }
      user.res = self.class.post "/android/user/sign_up?#{common_data}", options(data)

      if user.res["rc"] == 0
        user.ut = user.res["data"]["user"]["encrypted_token"]
        user.user_id = user.res["data"]["user"]["id"]
        puts user.email + " has been signed up. [user_id: #{@user_id}]"
      end
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
        log_msg email + " just logged in. [user_id: #{@user_id}]"
        if @res["data"]["babies"].size > 0
          current_baby = @res["data"]["babies"].detect {|b| b["Baby"]["baby_id"] == @current_baby_id }
          @current_baby = Baby.new current_baby["Baby"].symbolize_keys
          log_msg "current baby is: #{@current_baby.first_name} [baby_id: #{@current_baby.baby_id}]"
        end
      end
      self
    end

    def pull
      data = {
        "data": {
          "user": {
            "last_sync_time": 0
          }
        }
      }

      @res = self.class.post "/android/user/pull?#{common_data}", auth_options(data)
      self
    end

    def daily_content
      @res = self.class.get "/android/user/daily_content?#{common_data}"
      self
    end

    def nurture_baby
      @res = self.class.get "/android/user/nurture_baby?#{common_data}"
      self
    end

    def new_born_baby(args = {})
      name = Faker::Name.name.split(" ")
      params = {
        first_name: args[:first_name] || name.first,
        last_name: args[:last_name] || name.last,
        relation: args[:relation] || "Mother",
        gender: args[:gender] || "M",
        birth_due_date: args[:birth_due_date] || date_str(10.days.ago),
        birthday: args[:birthday] || date_str(10.days.ago),
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
        birth_due_date: args[:birth_due_date] || date_str(10.days.ago),
      }
      Baby.new(params)
    end

    def add_born_baby(baby)
      data = {
        "first_name": baby.first_name,
        "last_name": baby.last_name,
        "gender": baby.gender,
        "birthday": baby.birthday,
        "due_date": baby.birth_due_date,
        "relation": baby.relation.capitalize
      }

      @res = self.class.post "/android/baby?#{common_data}", auth_options(data)
      if @res["rc"] == 0
        @current_baby = baby
        @current_baby.baby_id = @res["data"]["baby_id"]
        @babies << @current_baby
        puts "Baby #{baby.first_name} is added [baby_id: #{@current_baby.baby_id}]"
      end
      self
    end

    def add_upcoming_baby(baby)
      data = {
        "first_name": baby.first_name,
        "last_name": baby.last_name,
        "gender": "",
        "birthday": "",
        "due_date": baby.birth_due_date,
        "relation": baby.relation.capitalize
      }

      @res = self.class.post "/android/baby?#{common_data}", auth_options(data)
      if @res["rc"] == 0
        @current_baby = baby
        @current_baby.baby_id = @res["data"]["baby_id"]
        @babies << @current_baby
        puts "Baby #{baby.first_name} is added [baby_id: #{@current_baby.baby_id}]"
      end
      self
    end

    def delete_baby(baby)
      
    end

########## Community ###########
    def create_topic(args = {})
      data = {
        "title": args[:topic_title] || "#{@email} #{Time.now}",
        "anonymous": args[:anonymous]|| 0,
        "content": args[:topic_content] || ("Example create topic" + Time.now.to_s)
      }
      group_id = args[:group_id]|| GROUP_ID 
      url = "#{ANDROID_FORUM_BASE_URL}/group/#{group_id}/topic?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
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
      url = "#{ANDROID_FORUM_BASE_URL}/group/#{group_id}/topic?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
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
      puts "Photo created >>>>>>>>>>#{@topic_title}<<<<<<<"
      self
    end

    def vote_poll(args= {})
      topic_id = args[:topic_id]
      vote_index = args[:vote_index] || 1
      data = {
        "vote_index": vote_index
      }
      url = "#{ANDROID_FORUM_BASE_URL}/topic/#{topic_id}/vote?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
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
      url = "#{ANDROID_FORUM_BASE_URL}/topic/#{topic_id}/reply?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
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
      url = "#{ANDROID_FORUM_BASE_URL}/topic/#{topic_id}/reply?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      @sub_reply_id = @res["result"]["id"]
      self
    end
##########GROUP


    def join_group(group_id = GROUP_ID )
      data = {
        "group_id": group_id
      }
      url = "#{ANDROID_FORUM_BASE_URL}/group/subscribe?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "       ------------#{self.user_id} joined group >>>#{group_id}<<<-------------"
      self
    end


    def leave_group(group_id)
      data = {
        "group_id": group_id
      }
      url = "#{ANDROID_FORUM_BASE_URL}/group/unsubscribe?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "       ------------#{self.user_id} left group >>>#{group_id}<<<-------------"
      self
    end


    def get_all_groups
      group_data = {
      }
      url = "#{ANDROID_FORUM_BASE_URL}/user/0/groups?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
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
      url = "#{ANDROID_FORUM_BASE_URL}/topic/#{topic_id}?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.delete(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "topic >>>>>'#{@topic_title}'<<<<< deleted\ntopic id is >>>>#{topic_id}<<<<\n\n"
      self
    end

    def follow_user(user_id)
      data = {
        "empty_stub": ""
      }
      url = "#{ANDROID_FORUM_BASE_URL}/user/#{user_id}/follow?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "User #{user_id} is followed by current user #{self.user_id}"  
      self
    end

    def unfollow_user(user_id)
      data = {
        "empty_stub": ""
      }
      url = "#{ANDROID_FORUM_BASE_URL}/user/#{user_id}/unfollow?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "User #{user_id} is unfollowed by current user #{self.user_id}"  
      self
    end

    def block_user(user_id)
      data = {
        "empty_stub": ""
      }
      url = "#{ANDROID_FORUM_BASE_URL}/user/#{user_id}/block?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "User #{user_id} is blocked by current user #{self.user_id}"  
      self
    end

    def unblock_user(user_id)
      data = {
        "empty_stub": ""
      }
      url = "#{ANDROID_FORUM_BASE_URL}/user/#{user_id}/unblock?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "User #{user_id} is unblocked by current user #{self.user_id}"  
      self
    end
  
    def bookmark_topic(topic_id)
      data = {
        "bookmarked": 1
      }
      url = "#{ANDROID_FORUM_BASE_URL}/topic/#{topic_id}/bookmark?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "topic id >>>>>'#{topic_id}'<<<<< is is bookmarked by #{self.user_id}\n\n"
      self
    end

    def unbookmark_topic(topic_id)
      data = {
        "bookmarked": 0
      }
      url = "#{ANDROID_FORUM_BASE_URL}/topic/#{topic_id}/bookmark?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "topic id >>>>>'#{topic_id}'<<<<< is unbookmarked by #{self.user_id}\n\n"
      self
    end

# ------------upvote downvote -----------
    def upvote_topic(topic_id)
      data = {
        "liked": 1
      }
      url = "#{ANDROID_FORUM_BASE_URL}/topic/#{topic_id}/like?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "topic id >>>>>'#{topic_id}'<<<<< is liked by #{self.user_id}\n\n"
      self
    end

    def cancel_upvote_topic(topic_id)
      data = {
        "liked": 0
      }
      url = "#{ANDROID_FORUM_BASE_URL}/topic/#{topic_id}/like?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "topic id >>>>>'#{topic_id}'<<<<< is no longer liked by #{self.user_id}\n\n"
      self
    end

    def downvote_topic(topic_id)
      data = {
        "disliked": 1
      }
      url = "#{ANDROID_FORUM_BASE_URL}/topic/#{topic_id}/dislike?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "topic id >>>>>'#{topic_id}'<<<<< is disliked by #{self.user_id}\n\n"
      self
    end

    def cancel_downvote_topic(topic_id)
      data = {
        "disliked": 0
      }
      url = "#{ANDROID_FORUM_BASE_URL}/topic/#{topic_id}/dislike?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "topic id >>>>>'#{topic_id}'<<<<< is no longer disliked by #{self.user_id}\n\n"
      self
    end

    def upvote_comment(topic_id, reply_id)
      data = {
        "topic_id": topic_id,
        "liked": 1
      }
      url = "#{ANDROID_FORUM_BASE_URL}/reply/#{reply_id}/like?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "Comment >>#{reply_id}<< under topic >>#{topic_id}<< is upvoted by #{self.user_id}\n"
      self
    end

    def cancel_upvote_comment(topic_id, reply_id)
      data = {
        "topic_id": topic_id,
        "liked": 0
      }
      url = "#{ANDROID_FORUM_BASE_URL}/reply/#{reply_id}/like?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "Comment >>#{reply_id}<< under topic >>#{topic_id}<< is no longer upvoted by #{self.user_id}\n"
      self
    end

    def downvote_comment(topic_id, reply_id)
      data = {
        "topic_id": topic_id,
        "disliked": 1
      }
      url = "#{ANDROID_FORUM_BASE_URL}/reply/#{reply_id}/dislike?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "Comment >>#{reply_id}<< under topic >>#{topic_id}<< is downvoted by #{self.user_id}\n"
      self
    end

    def cancel_downvote_comment(topic_id, reply_id)
      data = {
        "topic_id": topic_id,
        "disliked": 0
      }
      url = "#{ANDROID_FORUM_BASE_URL}/reply/#{reply_id}/dislike?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "Comment >>#{reply_id}<< under topic >>#{topic_id}<< is no longer downvoted by #{self.user_id}\n"
      self
    end

#-----------Flag topic/comment--------------
    def report_topic(topic_id, report_reason)
      data = {
        "reason": report_reason
      }
      url = "#{ANDROID_FORUM_BASE_URL}/topic/#{topic_id}/flag?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "Topic >>#{topic_id}<< is reported for reason >>>#{report_reason}<<< by >>>#{self.user_id}<<<\n"
      self
    end

    def report_comment(topic_id, reply_id, report_reason)
      data = {
        "reply_id": reply_id,
        "reason": report_reason
      }
      url = "#{ANDROID_FORUM_BASE_URL}/topic/#{topic_id}/flag?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
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
  end
end

