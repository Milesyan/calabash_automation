require 'httparty'
require 'json'
require 'net/http'
require_relative "MultipartImage_Android.rb"

module GlowForumAndroid

  PASSWORD = 'Glow12345'
  GROUP_ID = 5
  GLOW_ANDROID_BASE_URL = "http://titan-emma.glowing.com"
  GLOW_ANDROID_BASE_FORUM_URL = "http://titan-forum.glowing.com/android/forum"  
  IMAGE_ROOT = "/Users/Miles/automation/AutomationTests/glow/www/images/"
  GROUP_CATEGORY = {"Glow" => 1, "Nurture" => 3, "Sex & Relationships" => 6, "Health & Lifestyle" => 7, "Tech Support" => 5, "Eve" => 20, "Baby" => 199}

  class GlowUser
    attr_accessor :email, :password, :ut, :user_id, :topic_id, :reply_id, :topic_title, :reply_content,:group_id,:all_group_ids
    attr_accessor :first_name, :last_name, :type, :partner_email, :partner_first_name, :tmi_flag, :group_name, :group_description, :group_category 

    attr_accessor :res
    attr_accessor :gender

    def initialize(args = {})  
      @first_name = (args[:first_name] || "ga") + ('0'..'3').to_a.shuffle[0,3].join + Time.now.to_i.to_s[-4..-1]
      @email = args[:email] || "#{@first_name}@g.com"
      @last_name = "Glow"
      @password = args[:password] || PASSWORD
      @partner_email = "p#{@email}"
      @partner_first_name = "p#{@first_name}"
      @gender = args[:gender] || "female"
      @type = args[:type]
      @forum_hl = "en_US"
      @forum_fc = 1
      @forum_random = random_str
      @forum_device_id = "be3ca737160d" + ('0'..'9').to_a.shuffle[0,4].join
      @forum_android_version = "3.8.0-play-beta"
      @forum_vc = 376
      @forum_time_zone = "America%2FNew_York"
      @forum_code_name = "emma"
    end

    def random_str
      Time.now.to_i.to_s + ('0'..'9').to_a.shuffle[0,4].join
    end

    def assert_rc(res)
      assert_equal 0, res["rc"]
    end

    def date_str(n=0)
      (Time.now + n*24*3600).strftime("%Y/%m/%d")
    end

    def additional_post_data
      {
        "code_name": "emma",
        "time_zone": "Asia Shanghai",
        "vc": 380,
        "android_version": "3.8.0-play-beta",
        "device_id": "be3ca737160d9da3",
        "random": random_str,
        "fc": 1,
        "hl": "en_US"
      }
    end

    def ttc_signup(args = {})
      age = args[:age] || 25
      data = {
        "user": {
          "android_version": "3.8.0-play-beta",
          "birthday": (Time.now.to_i - age*365*24*3600),
          "first_name": @first_name,
          "timezone": "China Standard Time",
          "email": @email,
          "settings": {
            "time_zone": 8,
            "height": 185.4199981689453,
            "weight": 68.03880310058594,
            "first_pb_date": (Time.now - 14*24*3600).strftime("%Y/%m/%d"),
            "ttc_start": 1433853037,
            "period_cycle": 28,
            "period_length": 3,
            "current_status": 0,
            "children_number": 2
          },
          "last_name": "Glow",
          "gender": "F",
          "password": @password,
          "notifications_read": false
        }
      }

      @res = HTTParty.post("#{GLOW_ANDROID_BASE_URL}/a/v2/users/signup", :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @ut = @res["user"]["encrypted_token"]
      @user_id = @res["user"]["id"]
      puts email + " has been signed up"
      puts "User id is #{@user_id}"
      self
    end

    def non_ttc_signup
      data = {
        "user": {
          "android_version": "3.8.0-play-beta",
          "birthday": 427048062,
          "first_name": @first_name,
          "timezone": "China Standard Time",
          "email": @email,
          "settings": {
            "time_zone": 8,
            "birth_control": 1,
            "height": 198.1199951171875,
            "weight": 65.31724548339844,
            "first_pb_date": (Time.now).strftime("%Y/%m/%d"),
            "ttc_start": 0,
            "period_cycle": 29,
            "period_length": 4,
            "current_status": 3
          },
          "last_name": "Glow",
          "gender": "F",
          "password": @password,
          "notifications_read": false
        }
      }

      @res = HTTParty.post("#{GLOW_ANDROID_BASE_URL}/a/v2/users/signup", :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      # json_res = eval(res.to_s)
      @ut = @res["user"]["encrypted_token"]
      @user_id = @res["user"]["id"]
      puts @email + " has been signed up"
      self
    end

    def complete_tutorial
      data = {
        "data": {
          "reminders": [],
          "last_sync_time": 0,
          "tutorial_completed": 1,
          "settings": {
            "time_zone": 8
          },
          "notifications_read": false
        }
      }

      @res = HTTParty.post("#{GLOW_ANDROID_BASE_URL}/a/v2/users/push", :body => data.to_json,
        :headers => { "Authorization" => @ut, 'Content-Type' => 'application/json' })
      self
    end

    def login(email = nil, password = nil)
      data = {
        "email": email || @email,
        "password": password || @password
      }.merge(additional_post_data)

      # puts "debug #{data}"
      # puts "#{@res} res"
      @res = HTTParty.post("#{GLOW_ANDROID_BASE_URL}/a/users/signin", :body => data.to_json,
        :headers => {'Content-Type' => 'application/json' })
      @ut = @res["user"]["encrypted_token"] if @res["rc"] == 0
      self
    end

    def logout
      # @ut = nil
      # self
      data = additional_post_data
      @res = HTTParty.post("#{GLOW_ANDROID_BASE_URL}/a/users/logout", :body => data.to_json,
        :headers => { "Authorization" => @ut, 'Content-Type' => 'application/json' })
      self
    end

    def forgot_password(email)
      data = {
        "email": email
      }.merge(additional_post_data)

      @res = HTTParty.post("#{GLOW_ANDROID_BASE_URL}/a/users/recover_password", :body => data.to_json,
        :headers => {'Content-Type' => 'application/json' })
      self
    end

    def pull_content
      todos = "3985177229087007215"
      activity_rules = "4394188183635176431"
      clinics = "771039131751357848"
      drugs = "5594482260161071637"
      fertile_score_coef = "7468128932913297878"
      fertile_score = "1915309563115276298"
      predict_rules = "3037978852677495799"
      health_rules = "3809831023003012200"
      ts = Time.now.to_i.to_s

      params = "&ut=#{@ut.gsub("=","%3D")}"
      additional_post_data.each do |key, value|
        params += "&"
        params += key.to_s
        params += "="
        params += value.to_s
      end
      params.gsub(",", "%2C")
  
      url = "#{GLOW_ANDROID_BASE_URL}/a/v2/users/pull?ts=0&sign=todos%3A%7Cactivity_rules%3A%7Cclinics%3A%7Cfertile_score_coef%3A%7Cfertile_score%3A%7Cpredict_rules%3A%7Chealth_rules%3A&#{params}"
      #url = "#{GLOW_ANDROID_BASE_URL}/a/v2/users/pull?ts=#{ts}&sign=todos%3A-#{todos}%7Cactivity_rules%3A-#{activity_rules}%7Cclinics%3A%7Cfertile_score_coef%3A-#{fertile_score_coef}%7Cfertile_score%3A-#{fertile_score}%7Cpredict_rules%3A-#{predict_rules}%7Chealth_rules%3A#{health_rules}&#{params}"
      @res = HTTParty.get url
      self
    end
  ######## Community-----community-----------
    def create_topic(args = {})
      data = {
        "title": args[:topic_title] || "#{@email} #{Time.now}",
        "anonymous": args[:anonymous]|| 0,
        "content": args[:topic_content] || ("Example create topic" + Time.now.to_s)
      }
      group_id = args[:group_id]|| GROUP_ID 
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/group/#{group_id}/topic?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
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
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/group/#{group_id}/topic?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
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
      uri = URI("#{GLOW_ANDROID_BASE_FORUM_URL}/group/#{group_id}/topic")
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
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/topic/#{topic_id}/vote?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
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
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/topic/#{topic_id}/reply?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
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
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/topic/#{topic_id}/reply?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      @sub_reply_id = @res["result"]["id"]
      self
    end
#---------GROUPS----------
    def join_group(group_id = GROUP_ID )
      data = {
        "group_id": group_id
      }
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/group/subscribe?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "       ------------#{self.user_id} joined group >>>#{group_id}<<<-------------"
      self
    end

    def leave_group(group_id)
      data = {
        "group_id": group_id
      }
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/group/unsubscribe?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "   #{self.user_id} left group >>>#{group_id}<<<   "
      self
    end

    def get_all_groups
      group_data = {
      }
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/user/0/groups?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
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


    def delete_topic(topic_id)
      data = {}
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/topic/#{topic_id}?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.delete(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "topic >>>>>'#{@topic_title}'<<<<< deleted\ntopic id is >>>>#{topic_id}<<<<\n\n"
      self
    end

    def follow_user(user_id)
      data = {
        "empty_stub": ""
      }
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/user/#{user_id}/follow?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "User #{user_id} is followed by current user #{self.user_id}"  
      self
    end

    def unfollow_user(user_id)
      data = {
        "empty_stub": ""
      }
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/user/#{user_id}/unfollow?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "User #{user_id} is unfollowed by current user #{self.user_id}"  
      self
    end

    def block_user(user_id)
      data = {
        "empty_stub": ""
      }
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/user/#{user_id}/block?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "User #{user_id} is blocked by current user #{self.user_id}"  
      self
    end

    def unblock_user(user_id)
      data = {
        "empty_stub": ""
      }
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/user/#{user_id}/unblock?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "User #{user_id} is unblocked by current user #{self.user_id}"  
      self
    end


    def bookmark_topic(topic_id)
      data = {
        "bookmarked": 1
      }
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/topic/#{topic_id}/bookmark?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "topic id >>>>>'#{topic_id}'<<<<< is is bookmarked by #{self.user_id}\n\n"
      self
    end

    def unbookmark_topic(topic_id)
      data = {
        "bookmarked": 0
      }
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/topic/#{topic_id}/bookmark?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "topic id >>>>>'#{topic_id}'<<<<< is unbookmarked by #{self.user_id}\n\n"
      self
    end

# ------------upvote downvote -----------
    def upvote_topic(topic_id)
      data = {
        "liked": 1
      }
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/topic/#{topic_id}/like?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "topic id >>>>>'#{topic_id}'<<<<< is liked by #{self.user_id}\n\n"
      self
    end

    def cancel_upvote_topic(topic_id)
      data = {
        "liked": 0
      }
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/topic/#{topic_id}/like?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "topic id >>>>>'#{topic_id}'<<<<< is no longer liked by #{self.user_id}\n\n"
      self
    end

    def downvote_topic(topic_id)
      data = {
        "disliked": 1
      }
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/topic/#{topic_id}/dislike?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "topic id >>>>>'#{topic_id}'<<<<< is disliked by #{self.user_id}\n\n"
      self
    end

    def cancel_downvote_topic(topic_id)
      data = {
        "disliked": 0
      }
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/topic/#{topic_id}/dislike?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "topic id >>>>>'#{topic_id}'<<<<< is no longer disliked by #{self.user_id}\n\n"
      self
    end

    def upvote_comment(topic_id, reply_id)
      data = {
        "topic_id": topic_id,
        "liked": 1
      }
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/reply/#{reply_id}/like?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "Comment >>#{reply_id}<< under topic >>#{topic_id}<< is upvoted by #{self.user_id}\n"
      self
    end

    def cancel_upvote_comment(topic_id, reply_id)
      data = {
        "topic_id": topic_id,
        "liked": 0
      }
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/reply/#{reply_id}/like?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "Comment >>#{reply_id}<< under topic >>#{topic_id}<< is no longer upvoted by #{self.user_id}\n"
      self
    end

    def downvote_comment(topic_id, reply_id)
      data = {
        "topic_id": topic_id,
        "disliked": 1
      }
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/reply/#{reply_id}/dislike?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "Comment >>#{reply_id}<< under topic >>#{topic_id}<< is downvoted by #{self.user_id}\n"
      self
    end

    def cancel_downvote_comment(topic_id, reply_id)
      data = {
        "topic_id": topic_id,
        "disliked": 0
      }
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/reply/#{reply_id}/dislike?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "Comment >>#{reply_id}<< under topic >>#{topic_id}<< is no longer downvoted by #{self.user_id}\n"
      self
    end
 #-----------Flag topic/comment--------------

    def report_topic(topic_id, report_reason)
      data = {
        "reason": report_reason
      }
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/topic/#{topic_id}/flag?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "Topic >>#{topic_id}<< is reported for reason >>>#{report_reason}<<< by >>>#{self.user_id}<<<\n"
      self
    end

    def report_comment(topic_id, reply_id, report_reason)
      data = {
        "reply_id": reply_id,
        "reason": report_reason
      }
      url = "#{GLOW_ANDROID_BASE_FORUM_URL}/topic/#{topic_id}/flag?hl=#{@forum_hl}&fc=#{@forum_fc}&random=#{@forum_random}&device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&vc=#{@forum_vc}&time_zone=#{@forum_time_zone}&code_name=#{@forum_code_name}"
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
      uri = URI("#{GLOW_ANDROID_BASE_FORUM_URL}/group")
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