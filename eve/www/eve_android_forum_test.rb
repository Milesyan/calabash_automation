require 'httparty'
require 'json'
require 'net/http'
require 'securerandom'
require 'uri'
# require 'active_support/all'
require_relative "MultipartImage_Android.rb"

module EveForumAndroid

  PASSWORD = 'Glow12345'
  GROUP_ID = 5
  EVE_ANDROID_BASE_URL = "http://titan-lexie.glowing.com"
  EVE_ANDROID_BASE_FORUM_URL = "http://titan-forum.glowing.com/android/forum"  
  IMAGE_ROOT = "/Users/Miles/automation/AutomationTests/glow/www/images/"

  class EveUser
    attr_accessor :email, :password, :ut, :user_id, :topic_id, :reply_id
    attr_accessor :topic_title, :reply_content,:group_id,:all_group_ids
    attr_accessor :first_name, :last_name, :type, :tmi_flag, :group_name, :group_description, :group_category 
    attr_accessor :res
    attr_accessor :birthday

    def initialize(args = {})  
      @first_name = (args[:first_name] || "Eve_A") + ('0'..'9').to_a.shuffle[0,3].join + Time.now.to_i.to_s[-4..-1]
      @email = args[:email] || "#{@first_name}@g.com"
      @last_name = "Eve"
      @password = args[:password] || PASSWORD
      @today_date = Time.new.strftime("%Y\/%m\/%d")
      @pb = (Time.new - 10*60*60*24).strftime("%Y\/%m\/%d")
      @pe = (Time.new - 6*60*60*24).strftime("%Y\/%m\/%d")
      @next_pb = (Time.new + 12*60*60*24).strftime("%Y\/%m\/%d")
      # @birthday = args[:birthday] || 25.years.ago.to_i
      @birthday = args[:birthday] || 632406657
      @forum_locale = "en_US"
      @forum_fc = 1
      @forum_random = random_str
      @forum_device_id = "f1506217d3d7" + ('0'..'9').to_a.shuffle[0,4].join
      @forum_android_version = "Eve_1.0_miles_test"
      @forum_app_version = "HAHAHA"
      @forum_time_zone = "America%2FNew_York"
      @forum_code_name = "lexie"
      @forum_ts = Time.now.to_i.to_s + ('0'..'9').to_a.shuffle[0,3].join
      @additional_post_data_forum = "device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&locale=#{@forum_locale}&tz=#{@forum_time_zone}&random=#{@forum_random}&ts=#{@forum_ts}&is_guest=0&code_name=#{@forum_code_name}"
      @additional_post_data = "device_id=#{@forum_device_id}&app_version=#{@forum_android_version}&locale=#{@forum_locale}&tz=#{@forum_time_zone}&random=#{@forum_random}&ts=#{@forum_ts}"
      @additional_post_data_follow = "device_id=#{@forum_device_id}&android_version=#{@forum_android_version}&app_version=#{@forum_app_version}locale=#{@forum_locale}&tz=#{@forum_time_zone}&random=#{@forum_random}&ts=#{@forum_ts}&is_guest=0&code_name=#{@forum_code_name}"
    end


    def hash_to_query(hash)
      return URI.encode(hash.map{|k,v| "#{k}=#{v}"}.join("&"))
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
        "device_id": @forum_device_id,
        "app_version": @forum_android_version,
        "locale": @forum_locale,
        "tz": @forum_time_zone,
        "random": random_str,
        "ts": @forum_ts
      }
    end

    def additional_post_data_forum
      {
        "device_id": @forum_device_id,
        "android_version": @forum_android_version,
        "locale": @forum_locale,
        "tz": @forum_time_zone,
        "random": @forum_random,
        "ts": @forum_ts,
        "is_guest": 0,
        "code_name": @forum_code_name
      }
    end

    def signup_guest
      @uuid = SecureRandom.uuid.upcase
      data = {
        "guest_token": @uuid
      }.merge(additional_post_data)
      @res = HTTParty.post("#{EVE_ANDROID_BASE_URL}/android/users/signup_guest", :body => data.to_json, :headers => {'Content-Type' => 'application/json' })
      @ut = @res["data"]["encrypted_token"] 
      @user_id = @res["data"]["user_id"]
      puts "Signup guet #{@ut} <<<>>>#{@user_id}"
      puts "guest signup success" if @res["rc"] == 0
      self
    end

    def sync_guest_info
      puts "#{@user_id}<<<<<<<<<<"
      data = {
        "user_id": -1,
        "sync_items": [{
          "HealthProfile": {
            "update": [{
              "user_id": -1,
              "period_cycle": 22
            }]
          }
        }, {
          "Period": {
            "create": [{
              "pb": "2016/01/14",
              "pe": "2016/01/18",
              "pe_prediction": "2016/01/18",
              "uuid": @uuid
            }]
          }
        }, {
          "HealthProfile": {
            "update": [{
              "user_id": @user_id,
              "period_length": 5
            }]
          }
        }],
        "need_pull": 1,
        "additional_info": {
          "notification_last_read_time": 0
        }
      }
      @res = HTTParty.post("#{EVE_ANDROID_BASE_URL}/android/users/sync?#{@additional_post_data}", :body => data.to_json, :headers => {'Authorization' => @ut, 'Content-Type' => 'application/json' })
      puts "sync success" if @res["rc"] == 0
      self
    end

    def sync_guest_info_2
      data ={
        "user_id": @user_id,
        "sync_token": "0h7E0C-WpBIRj6jqyrc_uvP8eWxRyWi8cQgRhztkdF7F0JisXIstSgmfR9BRRUR7",
        "sync_items": [{
          "User": {
            "update": [{
              "syncToken": "0h7E0C-WpBIRj6jqyrc_uvP8eWxRyWi8cQgRhztkdF7F0JisXIstSgmfR9BRRUR7"
            }]
          }
        }, {
          "HealthProfile": {
            "update": [{
              "user_id": @user_id,
              "birth_control": 0
            }]
          }
        }],
        "need_pull": 1,
        "additional_info": {
          "notification_last_read_time": 0
        }
      }.merge(additional_post_data)
      @res = HTTParty.post("#{EVE_ANDROID_BASE_URL}/android/users/sync", :body => data.to_json, :headers => {'Authorization' => @ut, 'Content-Type' => 'application/json' })
      self
    end

    def get_daily_gems
      data = {
        "date": @today_date,
        "pb": @pb,
        "types": "2,4",
        "next_pb": @next_pb,
        "pe": @pe,
        "device_id": @forum_device_id,
        "app_version": @forum_app_version,
        "locale": @forum_locale,
        "tz": @forum_time_zone,
        "random": random_str,
        "ts": @forum_ts
      }
      url = hash_to_query data
      @res = HTTParty.get("#{EVE_ANDROID_BASE_URL}/android/users/get_daily_gems?#{url}", :body => {}.to_json, :headers => {'Authorization' => @ut, 'Content-Type' => 'application/json' })
      self
    end

    def signup_with_email
      data = {
        "guest_info":
        {
          "guest_token": @uuid
        },
        "user_info":
        {
          "email": @email,
          "password": @password,
          "birthday": @birthday,
          "first_name": @first_name,
          "last_name": @last_name
        },
        "onboarding_info":{}
      }
      puts "Signup with email:\n Email >>>#{@email}"
      @res = HTTParty.post("#{EVE_ANDROID_BASE_URL}/android/users/signup_with_email?#{@additional_post_data}", :body => data.to_json, :headers => {'Authorization' => @ut, 'Content-Type' => 'application/json' })
      self
    end

    def all_signup_flow
      signup_guest
      sync_guest_info
      sync_guest_info_2
      get_daily_gems
      signup_with_email
      login_with_email
      self
    end

    def login_with_email(email = nil, password = nil)
      data = {
        "email": email || @email,
        "password": password || @password,
        "guest_info": 
          {
            "guest_token": "",
          }
      }

      @res = HTTParty.post("#{EVE_ANDROID_BASE_URL}/android/users/login_with_email?#{@additional_post_data}", :body => data.to_json,
        :headers => {'Content-Type' => 'text/plain' })
      @ut = @res["data"]["encrypted_token"] if @res["rc"] == 0
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
      url = "#{EVE_ANDROID_BASE_FORUM_URL}/group/#{group_id}/topic?#{@additional_post_data_forum}"
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
      url = "#{EVE_ANDROID_BASE_FORUM_URL}/group/#{group_id}/topic?#{@additional_post_data_forum}"
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
      }.merge(additional_post_data_forum)
      @group_id = args[:group_id] || GROUP_ID
      data,headers = MultipartImage::Post.prepare_query(topic_data)
      headers = headers.merge({ "Authorization" => @ut })
      uri = URI("#{EVE_ANDROID_BASE_FORUM_URL}/group/#{group_id}/topic")
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
      url = "#{EVE_ANDROID_BASE_FORUM_URL}/topic/#{topic_id}/vote?#{@additional_post_data_forum}"
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
      url = "#{EVE_ANDROID_BASE_FORUM_URL}/topic/#{topic_id}/reply?#{@additional_post_data_forum}"
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
      url = "#{EVE_ANDROID_BASE_FORUM_URL}/topic/#{topic_id}/reply?#{@additional_post_data_forum}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      @sub_reply_id = @res["result"]["id"]
      self
    end
#---------GROUPS----------
    def join_group(group_id = GROUP_ID )
      data = {
        "group_id": group_id
      }
      url = "#{EVE_ANDROID_BASE_FORUM_URL}/group/subscribe?#{@additional_post_data_forum}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "       ------------#{self.user_id} joined group >>>#{group_id}<<<-------------"
      self
    end

    def leave_group(group_id)
      data = {
        "group_id": group_id
      }
      url = "#{EVE_ANDROID_BASE_FORUM_URL}/group/unsubscribe?#{@additional_post_data_forum}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "   #{self.user_id} left group >>>#{group_id}<<<   "
      self
    end

    def get_all_groups
      group_data = {
      }
      url = "#{EVE_ANDROID_BASE_FORUM_URL}/user/0/groups?#{@additional_post_data_forum}"
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
      url = "#{EVE_ANDROID_BASE_FORUM_URL}/topic/#{topic_id}?#{@additional_post_data_forum}"
      @res = HTTParty.delete(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "topic >>>>>'#{@topic_title}'<<<<< deleted\ntopic id is >>>>#{topic_id}<<<<\n\n"
      self
    end

    def follow_user(user_id)
      data = {
        "empty_stub": ""
      }
      url = "#{EVE_ANDROID_BASE_FORUM_URL}/user/#{user_id}/follow?#{@additional_post_data_follow}"
      puts url
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "User #{user_id} is followed by current user #{self.user_id}"  
      self
    end

    def unfollow_user(user_id)
      data = {
        "empty_stub": ""
      }
      url = "#{EVE_ANDROID_BASE_FORUM_URL}/user/#{user_id}/unfollow?#{@additional_post_data_forum}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "User #{user_id} is unfollowed by current user #{self.user_id}"  
      self
    end

    def block_user(user_id)
      data = {
        "empty_stub": ""
      }
      url = "#{EVE_ANDROID_BASE_FORUM_URL}/user/#{user_id}/block?#{@additional_post_data_forum}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "User #{user_id} is blocked by current user #{self.user_id}"  
      self
    end

    def unblock_user(user_id)
      data = {
        "empty_stub": ""
      }
      url = "#{EVE_ANDROID_BASE_FORUM_URL}/user/#{user_id}/unblock?#{@additional_post_data_forum}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "User #{user_id} is unblocked by current user #{self.user_id}"  
      self
    end


    def bookmark_topic(topic_id)
      data = {
        "bookmarked": 1
      }
      url = "#{EVE_ANDROID_BASE_FORUM_URL}/topic/#{topic_id}/bookmark?#{@additional_post_data_forum}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "topic id >>>>>'#{topic_id}'<<<<< is is bookmarked by #{self.user_id}\n\n"
      self
    end

    def unbookmark_topic(topic_id)
      data = {
        "bookmarked": 0
      }
      url = "#{EVE_ANDROID_BASE_FORUM_URL}/topic/#{topic_id}/bookmark?#{@additional_post_data_forum}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "topic id >>>>>'#{topic_id}'<<<<< is unbookmarked by #{self.user_id}\n\n"
      self
    end

# ------------upvote downvote -----------
    def upvote_topic(topic_id)
      data = {
        "liked": 1
      }
      url = "#{EVE_ANDROID_BASE_FORUM_URL}/topic/#{topic_id}/like?#{@additional_post_data_forum}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "topic id >>>>>'#{topic_id}'<<<<< is liked by #{self.user_id}\n\n"
      self
    end

    def cancel_upvote_topic(topic_id)
      data = {
        "liked": 0
      }
      url = "#{EVE_ANDROID_BASE_FORUM_URL}/topic/#{topic_id}/like?#{@additional_post_data_forum}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "topic id >>>>>'#{topic_id}'<<<<< is no longer liked by #{self.user_id}\n\n"
      self
    end

    def downvote_topic(topic_id)
      data = {
        "disliked": 1
      }
      url = "#{EVE_ANDROID_BASE_FORUM_URL}/topic/#{topic_id}/dislike?#{@additional_post_data_forum}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "topic id >>>>>'#{topic_id}'<<<<< is disliked by #{self.user_id}\n\n"
      self
    end

    def cancel_downvote_topic(topic_id)
      data = {
        "disliked": 0
      }
      url = "#{EVE_ANDROID_BASE_FORUM_URL}/topic/#{topic_id}/dislike?#{@additional_post_data_forum}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "topic id >>>>>'#{topic_id}'<<<<< is no longer disliked by #{self.user_id}\n\n"
      self
    end

    def upvote_comment(topic_id, reply_id)
      data = {
        "topic_id": topic_id,
        "liked": 1
      }
      url = "#{EVE_ANDROID_BASE_FORUM_URL}/reply/#{reply_id}/like?#{@additional_post_data_forum}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "Comment >>#{reply_id}<< under topic >>#{topic_id}<< is upvoted by #{self.user_id}\n"
      self
    end

    def cancel_upvote_comment(topic_id, reply_id)
      data = {
        "topic_id": topic_id,
        "liked": 0
      }
      url = "#{EVE_ANDROID_BASE_FORUM_URL}/reply/#{reply_id}/like?#{@additional_post_data_forum}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "Comment >>#{reply_id}<< under topic >>#{topic_id}<< is no longer upvoted by #{self.user_id}\n"
      self
    end

    def downvote_comment(topic_id, reply_id)
      data = {
        "topic_id": topic_id,
        "disliked": 1
      }
      url = "#{EVE_ANDROID_BASE_FORUM_URL}/reply/#{reply_id}/dislike?#{@additional_post_data_forum}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "Comment >>#{reply_id}<< under topic >>#{topic_id}<< is downvoted by #{self.user_id}\n"
      self
    end

    def cancel_downvote_comment(topic_id, reply_id)
      data = {
        "topic_id": topic_id,
        "disliked": 0
      }
      url = "#{EVE_ANDROID_BASE_FORUM_URL}/reply/#{reply_id}/dislike?#{@additional_post_data_forum}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "Comment >>#{reply_id}<< under topic >>#{topic_id}<< is no longer downvoted by #{self.user_id}\n"
      self
    end
 #-----------Flag topic/comment--------------

    def report_topic(topic_id, report_reason)
      data = {
        "reason": report_reason
      }
      url = "#{EVE_ANDROID_BASE_FORUM_URL}/topic/#{topic_id}/flag?#{@additional_post_data_forum}"
      @res = HTTParty.post(url, :body => data.to_json, :headers => { "Authorization" => @ut , 'Content-Type' => 'application/json' }) 
      puts "Topic >>#{topic_id}<< is reported for reason >>>#{report_reason}<<< by >>>#{self.user_id}<<<\n"
      self
    end

    def report_comment(topic_id, reply_id, report_reason)
      data = {
        "reply_id": reply_id,
        "reason": report_reason
      }
      url = "#{EVE_ANDROID_BASE_FORUM_URL}/topic/#{topic_id}/flag?#{@additional_post_data_forum}"
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
      }.merge(additional_post_data_forum)
      data,headers = MultipartImage::Post.prepare_query(topic_data)
      headers = headers.merge({ "Authorization" => @ut })
      uri = URI("#{EVE_ANDROID_BASE_FORUM_URL}/group")
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