require 'httparty'
require 'json'
require 'securerandom'
require_relative "MultipartImage_IOS.rb"

module NoahIOS

  PASSWORD = 'Glow12345'
  NEW_PASSWORD = 'Glow1234'
  TREATMENT_TYPES = {"med": 1, "iui": 2, "ivf": 3, "prep": 4}

  # GROUP_ID = 72057594037927939  # sandbox0 Health & Lifestyle
  # GROUP_ID = 72057594037927938 # sandbox0 Sex & Relationships

  BASE_URL = "http://dragon-noah.glowing.com"
  FORUM_BASE_URL = "http://dragon-forum.glowing.com"
  
  # BASE_URL = "http://localhost:5010"
  # FORUM_BASE_URL = "http://localhost:35010"

  class NoahUser

    attr_accessor :email, :password, :ut, :user_id, :topic_id, :reply_id, :topic_title, :reply_content,:group_id,:all_groups_id
    attr_accessor :first_name, :last_name, :type, :partner_email, :partner_first_name
    attr_accessor :res
    attr_accessor :gender

    def initialize(args = {})  
      @first_name = (args[:first_name] || "noah") + ('0'..'3').to_a.shuffle[0,3].join + Time.now.to_i.to_s[-4..-1]
      @email = args[:email] || "#{@first_name}@g.com"
      @last_name = "Noah"
      @password = args[:password] || PASSWORD
      @partner_email = "p#{@email}"
      @partner_first_name = "p#{@first_name}"
      @gender = args[:gender] || "female"
      @type = args[:type]
    end

    def random_str
      ('0'..'9').to_a.shuffle[0,9].join + "_" + Time.now.to_i.to_s
    end

    def uuid
      SecureRandom.uuid
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

    def parent_signup(args = {})
      data = {
        "onboarding_info": {
        "birthday": 1041696000,
        "first_name": @first_name,
        "email": @email,
        "password": @password
        },
      }.merge(common_data)
      @res = HTTParty.post("#{BASE_URL}/ios/user/signup", :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts email + " has been signed up"
      self
    end

    def login(email = nil, password = nil)
      # the response of login doesn't return the rc code
      login_data = {
        "email": email || @email,
        "password": password || @password
      }.merge(common_data)

      res = HTTParty.post("#{BASE_URL}/ios/user/login", :body => login_data.to_json,
        :headers => { 'Content-Type' => 'application/json' }).to_json
      @res = JSON.parse(res)
      @ut = @res["data"]["user"]["encrypted_token"]
      @user_id = @res["data"]["user"]["id"]
      puts "Login User id is #{@user_id}"
      self
    end

    def logout
      @ut = nil
    end


    ######## Community

    def create_topic(args = {})
      topic_data = {
        "code_name": "noah",
        "content": "#{Time.now.strftime "%D %T"}",
        "title": args[:title] || "#{@email} #{Time.now}",
        "anonymous": 0,
        "ut": @ut
      }.merge(common_data)  # random_str isn't needed
      @group_id = args[:group_id] || GROUP_ID
      @res =  HTTParty.post("#{FORUM_BASE_URL}/ios/forum/group/#{@group_id}/create_topic", :body => topic_data.to_json,
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
        "title": args[:title] || "Poll + #{@email} #{Time.now}",
        "options": ["Field1","Field2","Field3"].to_s,
        "ut": @ut
      }.merge(common_data)
      @group_id = args[:group_id] || GROUP_ID
      @res =  HTTParty.post("#{FORUM_BASE_URL}/ios/forum/group/#{@group_id}/create_poll", :body => topic_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @topic_id = @res["data"]["result"]["id"]
      title = @res["data"]["result"]["title"]
      @topic_title = title
      puts "Poll >>>>>'#{title}'<<<<< created, topic id is #{topic_id}"
      self
    end


    def create_image(args={})
      topic_data = {
        "code_name": "noah",
        "app_version": "5.3.0",
        "locale": "en_US",
        "device_id": "139E7990-DB88-4D11-9D6B-290" + random_str,
        "random": random_str,
        "title": "Image topic" + Time.now.to_s,
        "anonymous": 0,
        "ut": @ut,
        "model": "iPhone7,1",
        "warning": 0,
        "image": File.new('1.png')
      }
      data,headers = MultipartImage::Post.prepare_query(topic_data)
      uri = URI ("#{FORUM_BASE_URL}/ios/forum/group/1/create_photo")
      http = Net::HTTP.new(uri.host, uri.port)
      _res = http.post(uri.path, data, headers)
      @res = JSON.parse _res.body
      self
    end


    def vote_poll(args = {})
      vote_data = {
        "code_name": "noah",
        "vote_index": 2,
        "ut": @ut
      }.merge(common_data)
      topic_id = args[:topic_id]
      @res = HTTParty.post("#{FORUM_BASE_URL}/ios/forum/topic/#{topic_id}/vote", :body => vote_data.to_json,
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

      @res =  HTTParty.post("#{FORUM_BASE_URL}/ios/forum/topic/#{topic_id}/create_reply", :body => reply_data.to_json,
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
      @res =  HTTParty.post("#{FORUM_BASE_URL}/ios/forum/topic/#{topic_id}/create_reply", :body => reply_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts "Reply to comment >>>>>#{reply_id}<<<<< under >>>>#{topic_id}<<<<"
      self
    end


    def join_group(group_id = GROUP_ID )
      data = {
        "code_name": "noah",
        "ut": @ut
      }.merge(common_data)

      @res =  HTTParty.post("#{FORUM_BASE_URL}/ios/forum/group/#{group_id}/subscribe", :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts "     -----Join group #{group_id}-----    "
      self
    end



    def leave_group(leave_group_id)
      data = {
        "code_name": "noah",
        "ut": @ut
      }.merge(common_data)
      unsubscribe_groupid = leave_group_id || GROUP_ID
      @res =  HTTParty.post("#{FORUM_BASE_URL}/ios/forum/group/#{unsubscribe_groupid}/unsubscribe", :body => data.to_json,
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
      @res = HTTParty.post("#{FORUM_BASE_URL}/ios/forum/topic/#{topic_id}/vote", :body => vote_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts "Topic #{topic_id} is voted"
      self
    end 

    def delete_topic(topic_id)
      reply_data = {
        "code_name": "noah",
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{FORUM_BASE_URL}/ios/forum/topic/#{topic_id}/remove", :body => reply_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      self
      puts "#{topic_id} deleted"
    end



    def follow_user(user_id)
      reply_data = {
        "code_name": "noah",
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{FORUM_BASE_URL}/ios/forum/user/#{user_id}/follow", :body => reply_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      self
      puts "#{user_id} is followed by user #{self.user_id}"
    end

    def unfollow_user(user_id)
      reply_data = {
        "code_name": "noah",
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{FORUM_BASE_URL}/ios/forum/user/#{user_id}/unfollow", :body => reply_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      self
      puts "#{user_id} is unfollowed by user #{self.user_id}"
    end

    def block_user(user_id)
      reply_data = {
        "code_name": "noah",
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{FORUM_BASE_URL}/ios/forum/user/#{user_id}/block", :body => reply_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      self
      puts "#{user_id} is blocked by user #{self.user_id}"
    end

    def unblock_user(user_id)
      reply_data = {
        "code_name": "noah",
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{FORUM_BASE_URL}/ios/forum/user/#{user_id}/unblock", :body => reply_data.to_json,
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
      @res =  HTTParty.post("#{FORUM_BASE_URL}/ios/forum/topic/#{topic_id}/bookmark", :body => topic_data.to_json,
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
      @res =  HTTParty.post("#{FORUM_BASE_URL}/ios/forum/topic/#{topic_id}/bookmark", :body => topic_data.to_json,
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
      @res =  HTTParty.post("#{FORUM_BASE_URL}/ios/forum/topic/#{topic_id}/like", :body => topic_data.to_json,
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
      @res =  HTTParty.post("#{FORUM_BASE_URL}/ios/forum/topic/#{topic_id}/like", :body => topic_data.to_json,
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
      @res =  HTTParty.post("#{FORUM_BASE_URL}/ios/forum/reply/#{reply_id}/like", :body => topic_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts "Comment #{reply_id} under topic #{topic_id}is upvoted by #{self.user_id}"
      self
    end

    def cancel_upvote_comment(topic_id, reply_id)
      topic_data = {
        "code_name": "noah",
        "liked": 0,
        "topic_id": topic_id,
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{FORUM_BASE_URL}/ios/forum/reply/#{reply_id}/like", :body => topic_data.to_json,
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
      @res =  HTTParty.post("#{FORUM_BASE_URL}/ios/forum/topic/#{topic_id}/dislike", :body => topic_data.to_json,
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
      @res =  HTTParty.post("#{FORUM_BASE_URL}/ios/forum/reply/#{reply_id}/dislike", :body => topic_data.to_json,
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
      @res =  HTTParty.post("#{FORUM_BASE_URL}/ios/forum/topic/#{topic_id}/dislike", :body => topic_data.to_json,
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
      @res =  HTTParty.post("#{FORUM_BASE_URL}/ios/forum/reply/#{reply_id}/dislike", :body => topic_data.to_json,
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
      @res =  HTTParty.post("#{FORUM_BASE_URL}/ios/forum/topic/#{topic_id}/flag", :body => topic_data.to_json,
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
      @res =  HTTParty.post("#{FORUM_BASE_URL}/ios/forum/topic/#{topic_id}/flag", :body => topic_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts "comment #{reply_id} under #{topic_id} is flagged for reason #{report_reason} by #{self.user_id}"
      self
    end




    # def create_group(args={})
    #   group_data = {
    #     "code_name": "noah",
    #     "category_id": 7,
    #     "desc": "test create group",
    #     "name": "GROUPNAME" + Time.now.to_s,
    #     "image": File.new('1.jpg'),
    #     "ut": @ut
    #   }.merge(common_data)
    #   @res =  Multipart_miles.post("#{FORUM_BASE_URL}/ios/forum/group/create", :body => group_data.to_json,
    #     :headers => { 'Content-Type' => 'application/json' })
    #   puts @res
    #   self
    # end

    def get_all_groups
      group_data = {
        "code_name": "noah",
        "ut": @ut
      }.merge(common_data)
      _res =  HTTParty.get("#{FORUM_BASE_URL}/ios/forum/user/#{self.user_id}/social_info", :body => group_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @all_groups_id = []
      _res["groups"].each do |element|
        element.each do |k,v|
          if k == "id"
            @all_groups_id.push v
          end
        end
      end
      self
    end

    def leave_all_groups
      get_all_groups
      all_groups_id.each do |group_id|
        leave_group group_id
      end
      self
    end

    ###### Me #####

    def change_status(status)
      ttc_to_preg_data = {
        "data": {
          "reminders": [],
          "daily_data": [],
          "last_sync_time": 1447934411,
          "periods": {
            "alive": [{
              "pb": "2015\/11\/05",
              "pe": "2015\/11\/09",
              "flag": 2
            }],
            "archived": []
          },
          "status_history": [],
          "daily_checks": [],
          "medical_logs": [],
          "settings": {
            "current_status": 2,
            "prediction_switch": 0,
            "previous_status": 0,
            "last_pregnant_date": "2015\/11\/19"
          },
          "notifications": []
        },
        "ut": @ut
      }.merge(common_data)

      preg_to_none_ttc_data = {
        "data": {
          "reminders": [],
          "daily_data": [],
          "last_sync_time": 1447935312,
          "status_history": [],
          "daily_checks": [],
          "medical_logs": [],
          "settings": {
            "previous_status": 2,
            "current_status": 3,
            "birth_control": 1
          },
          "notifications": []
        },
        "ut": @ut
      }.merge(common_data)

      case status.downcase
      when "pregnant"
        ttc_to_preg_data[:data][:settings][:current_status] = 2 
      when "ttc"
      when "non-ttc"
      end

      @res = HTTParty.post("http://dragon-emma.glowing.com/api/v2/users/push", :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      self
    end

    def change_password
      data = {
        "userinfo": {
          "user_id": @user_id,
          "password": NEW_PASSWORD
        }
      }.merge(common_data)
      @res = HTTParty.post("http://dragon-emma.glowing.com/api/users/update_password", :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      self
    end

    def invite_partner
      data = {
        "is_mom": 0,
        "email": @partner_email,
        "ut": @ut,
        "name": @partner_first_name
      }.merge(common_data)

      @res = HTTParty.post("#{BASE_URL}/api/users/partner/email", :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts "partner #{@partner_email} has been invited"
      self
    end

    def remove_partner
      data = {
        "ut": @ut
      }.merge(common_data)
      @res = HTTParty.post("#{BASE_URL}/api/users/remove_partner", :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      # if a user is signed up as a partner, then remove 'p' from the email
      if @partner_email.match /^pp/
        puts "partner #{@partner_email.sub('pp','')} has been disconnected"
      else
        puts "partner #{@partner_email} has been disconnected"
      end
      
      self
    end

    def turn_off_period_prediction
      data = {
        "data": {
          "reminders": [],
          "daily_data": [],
          "last_sync_time": 1449635974,
          "periods": {
            "alive": live_periods,
            "archived": []
          },
          "daily_checks": [],
          "medical_logs": [],
          "settings": {
            "prediction_switch": 0
          },
          "notifications": []
        },
        "ut": @ut
      }.merge(common_data)

      @res =  HTTParty.post("#{BASE_URL}/api/v2/users/push", :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      self
    end

    def add_fertility_tests
      today = Time.now.strftime("%Y/%m/%d")
      data = {
        "data": [{
          "test_val": 4,
          "test_key": "fertility_clinic"
        }, {
          "test_val": "Doctor Wu",
          "test_key": "doctor_name"
        }, {
          "test_val": "Nurse Wang",
          "test_key": "nurse_name"
        }, {
          "test_val": today,
          "test_key": "cycle_day_three_blood_work"
        }, {
          "test_val": 15,
          "test_key": "cycle_day_three_blood_work_e2"
        }, {
          "test_val": 15,
          "test_key": "cycle_day_three_blood_work_fsh"
        }, {
          "test_val": 15,
          "test_key": "cycle_day_three_blood_work_lh"
        }, {
          "test_val": 15,
          "test_key": "cycle_day_three_blood_work_prl"
        }, {
          "test_val": 15,
          "test_key": "cycle_day_three_blood_work_tsh"
        }, {
          "test_val": today,
          "test_key": "other_blood_tests"
        }, {
          "test_val": 15,
          "test_key": "other_blood_tests_amh"
        }, {
          "test_val": 1,
          "test_key": "other_blood_tests_infectious_disease"
        }, {
          "test_val": today,
          "test_key": "vaginal_ultrasound"
        }, {
          "test_val": 15,
          "test_key": "vaginal_ultrasound_antral_follicle_count"
        }, {
          "test_val": 15,
          "test_key": "vaginal_ultrasound_lining"
        }, {
          "test_val": today,
          "test_key": "hysterosalpingogram"
        }, {
          "test_val": 1,
          "test_key": "hysterosalpingogram_result"
        }, {
          "test_val": today,
          "test_key": "genetic_screening"
        }, {
          "test_val": 1,
          "test_key": "genetic_screening_result"
        }, {
          "test_val": today,
          "test_key": "saline_sonogram"
        }, {
          "test_val": 1,
          "test_key": "saline_sonogram_result"
        }, {
          "test_val": today,
          "test_key": "ovarian_reserve_testing"
        }, {
          "test_val": 1,
          "test_key": "ovarian_reserve_testing_result"
        }, {
          "test_val": today,
          "test_key": "mammogram"
        }, {
          "test_val": 1,
          "test_key": "mammogram_result"
        }, {
          "test_val": today,
          "test_key": "papsmear"
        }, {
          "test_val": 1,
          "test_key": "papsmear_result"
        }, {
          "test_val": today,
          "test_key": "partner_semen_analysis"
        }, {
          "test_val": 15,
          "test_key": "partner_semen_analysis_volume"
        }, {
          "test_val": 15,
          "test_key": "partner_semen_analysis_concentration"
        }, {
          "test_val": 1515,
          "test_key": "partner_semen_analysis_motility"
        }, {
          "test_val": 1,
          "test_key": "partner_semen_analysis_morphology"
        }, {
          "test_val": today,
          "test_key": "partner_infectious_disease_blood_test"
        }, {
          "test_val": 1,
          "test_key": "partner_infectious_disease_blood_test_result"
        }, {
          "test_val": today,
          "test_key": "partner_genetic_screening"
        }, {
          "test_val": 1,
          "test_key": "partner_genetic_screening_result"
        }],
        "ut": @ut
      }.merge(common_data)

      @res =  HTTParty.post("#{BASE_URL}/api/v2/users/push/fertility_tests", :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      self
    end

    def export_pdf
      pdf_data = {
        "unit": "",
        "email": "linus@glowing.com",
        "ut": @ut
      }.merge(common_data)

      @res =  HTTParty.post("#{BASE_URL}/api/users/export", :body => pdf_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      self
    end

    def female_complete_health_profile(type)
      data = {
        "data": {
          "reminders": [],
          "last_sync_time": 1449574337,
          "daily_data": [],
          "daily_checks": [],
          "medical_logs": [],
          "settings": {
            "miscarriage_number": 1,
            "partner_erection": 1,
            "cycle_regularity": 1,
            "live_birth_number": 1,
            "diagnosed_conditions": 14,
            "relationship_status": 2,
            "insurance": 1,
            "ethnicity": 2,
            "occupation": "Employed",
            "exercise": 8,
            "stillbirth_number": 1,
            "abortion_number": 1,
            "tubal_pregnancy_number": 1,
            "considering": (1 if type.downcase == "non-ttc"),
            "birth_control_start": (Time.now.to_i if type.downcase == "non-ttc"),
            "infertility_diagnosis": (30 if ["iui", "ivf", "med", "prep", "ft"].include?(type.downcase)),
            "height": (170 if ["iui", "ivf", "med", "prep", "ft"].include?(type.downcase))
          },
          "notifications": []
        },
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{BASE_URL}/api/v2/users/push", :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      self
    end
  end
end