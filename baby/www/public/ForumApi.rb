require_relative 'env_config'

module ForumApi
  extend TestHelper 

  class ForumIOS
    include TestHelper
    include IOSConfig
    attr :code_name, :request_id, :all_participants, :all_group_ids, 
         :all_group_names, :notifications, :app_version
    # --- some get functions---
    def get_created
      data = {
        "code_name": @code_name,
        "offset": '0',
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.get("#{forum_base_url}/topic/created", 
        :body => get_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @res = @res["data"] if @code_name != 'emma'
      self
    end

    def get_blocked
      data = {
        "code_name": @code_name,
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.get("#{forum_base_url}/users/blocked",
        :body => get_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @res = @res["data"] if @code_name != 'emma'
      self
    end

    def create_topic(args = {})
      data = {
        "code_name": @code_name,
        "content": "#{Time.now.strftime "%D %T"}",
        "title": args[:topic_title] || "#{@email} #{Time.now}",
        "anonymous": 0,
        "ut": @ut
      }.merge(common_data)  # random_str isn't needed
      @group_id = args[:group_id] || GROUP_ID
      @res =  HTTParty.post("#{forum_base_url}/group/#{@group_id}/create_topic", 
        :body => topic_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts "Code name #{@code_name}"
      @res = @res["data"] if @code_name != 'emma'
      @topic_id = @res["topic"]["id"]
      @group_id = @res["topic"]["group_id"]
      title = @res["topic"]["title"]
      @topic_title = title
      puts "topic >>>>>'#{title}'<<<<< created，topic id is #{topic_id}"
      self
    end

    def reply_to_topic(topic_id, args = {})
      data = {
        "code_name": @code_name,
        "content": args[:reply_content]||"Reply to topic #{topic_id} and time is #{Time.now.to_i}",
        "anonymous": 0,
        "reply_to": 0,
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{forum_base_url}/topic/#{topic_id}/create_reply", 
        :body => reply_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @res = @res["data"] if @code_name != 'emma'
      @reply_id = @res["result"]["id"]
      puts "Reply to topic >>>>>#{topic_id}<<<<<"
      self
    end 

    def create_poll(args = {})
      data = {
        "code_name": @code_name,
        "content": "#{Time.now.strftime "%D %T"}",
        "anonymous": 0,
        "title": args[:topic_title] || "Poll + #{@email} #{Time.now}",
        "options": ["Field1","Field2","Field3"].to_s,
        "ut": @ut
      }.merge(common_data)
      @group_id = args[:group_id] || GROUP_ID
      @res =  HTTParty.post("#{forum_base_url}/group/#{@group_id}/create_poll", 
        :body => topic_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @res = @res["data"] if @code_name != 'emma'
      @topic_id = @res["result"]["id"]
      title = @res["result"]["title"]
      @topic_title = title
      puts "Poll >>>>>'#{title}'<<<<< created, topic id is #{topic_id}"
      self
    end

    def vote_poll(args = {})
      data = {
        "code_name": @code_name,
        "vote_index": 2,
        "ut": @ut
      }.merge(common_data)
      topic_id = args[:topic_id]
      @res = HTTParty.post("#{forum_base_url}/topic/#{topic_id}/vote", 
        :body => vote_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @res = @res["data"] if @code_name != 'emma'
      puts "Topic #{topic_id} is voted"
      self
    end 



    def reply_to_comment(topic_id,reply_id,args = {})
      data = {
        "code_name": @code_name,
        "content": args[:reply_content] || 
          "Reply to topic #{topic_id} and reply #{reply_id} "+Random.rand(10).to_s,
        "anonymous": 0,
        "reply_to": reply_id,
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{forum_base_url}/topic/#{topic_id}/create_reply", 
        :body => reply_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @res = @res["data"] if @code_name != 'emma'
      puts "Reply to comment >>>>>#{reply_id}<<<<< under >>>>#{topic_id}<<<<"
      self
    end

    def join_group(group_id = GROUP_ID )
      data = {
        "code_name": @code_name,
        "ut": @ut
      }.merge(common_data)

      @res =  HTTParty.post("#{forum_base_url}/group/#{group_id}/subscribe", 
        :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @res = @res["data"] if @code_name != 'emma'
      self
    end

    def leave_group(leave_group_id)
      data = {
        "code_name": @code_name,
        "ut": @ut
      }.merge(common_data)
      unsubscribe_groupid = leave_group_id || GROUP_ID
      @res =  HTTParty.post("#{forum_base_url}/group/#{unsubscribe_groupid}/unsubscribe", 
        :body => data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @res = @res["data"] if @code_name != 'emma'
      self
    end

    def vote_poll(args = {})
      data = {
        "code_name": @code_name,
        "vote_index": 2,
        "ut": @ut
      }.merge(common_data)
      topic_id = args[:topic_id]
      @res = HTTParty.post("#{forum_base_url}/topic/#{topic_id}/vote", 
        :body => vote_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @res = @res["data"] if @code_name != 'emma'
      puts "Topic #{topic_id} is voted"
      self
    end 

    def delete_topic(topic_id)
      data = {
        "code_name": @code_name,
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{forum_base_url}/topic/#{topic_id}/remove", 
        :body => reply_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @res = @res["data"] if @code_name != 'emma'
      self
      puts "#{topic_id} deleted"
    end

    def follow_user(user_id)
      data = {
        "code_name": @code_name,
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{forum_base_url}/user/#{user_id}/follow", 
        :body => reply_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @res = @res["data"] if @code_name != 'emma'
      self
      puts "#{user_id} is followed by user #{self.user_id}"
    end

    def unfollow_user(user_id)
      data = {
        "code_name": @code_name,
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{forum_base_url}/user/#{user_id}/unfollow", 
        :body => reply_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @res = @res["data"] if @code_name != 'emma'
      self
      puts "#{user_id} is unfollowed by user #{self.user_id}"
    end

    def block_user(user_id)
      data = {
        "code_name": @code_name,
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{forum_base_url}/user/#{user_id}/block", 
        :body => reply_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @res = @res["data"] if @code_name != 'emma'
      self
      puts "#{user_id} is blocked by user #{self.user_id}"
    end

    def unblock_user(user_id)
      data = {
        "code_name": @code_name,
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{forum_base_url}/user/#{user_id}/unblock", 
        :body => reply_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @res = @res["data"] if @code_name != 'emma'
      self
      puts "#{user_id} is unblocked by user #{self.user_id}"
    end  

    def bookmark_topic(topic_id)
      data = {
        "code_name": @code_name,
        "bookmarked": 1,
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{forum_base_url}/topic/#{topic_id}/bookmark", 
        :body => topic_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @res = @res["data"] if @code_name != 'emma'
      puts "topic #{topic_id} is bookmarked by #{self.user_id}"
      self
    end

    def unbookmark_topic(topic_id)
      data = {
        "code_name": @code_name,
        "bookmarked": 0,
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{forum_base_url}/topic/#{topic_id}/bookmark", 
        :body => topic_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @res = @res["data"] if @code_name != 'emma'
      puts "topic #{topic_id} is unbookmarked by #{self.user_id}"
      self
    end

    def upvote_topic(topic_id)
      data = {
        "code_name": @code_name,
        "liked": 1,
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{forum_base_url}/topic/#{topic_id}/like", 
        :body => topic_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @res = @res["data"] if @code_name != 'emma'
      puts "topic #{topic_id} is upvoted by #{self.user_id}"
      self
    end

    def cancel_upvote_topic(topic_id)
      data = {
        "code_name": @code_name,
        "liked": 0,
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{forum_base_url}/topic/#{topic_id}/like", :body => topic_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @res = @res["data"] if @code_name != 'emma'
      puts "topic #{topic_id} is no longer upvoted by #{self.user_id}"
      self
    end

    def upvote_comment(topic_id, reply_id)
      data = {
        "code_name": @code_name,
        "liked": 1,
        "topic_id": topic_id,
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{forum_base_url}/reply/#{reply_id}/like", 
        :body => topic_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @res = @res["data"] if @code_name != 'emma'
      puts "Comment >>#{reply_id}<< under topic >>#{topic_id}<< is upvoted by >>#{self.user_id}<<"
      self
    end

    def cancel_upvote_comment(topic_id, reply_id)
      data = {
        "code_name": @code_name,
        "liked": 0,
        "topic_id": topic_id,
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{forum_base_url}/reply/#{reply_id}/like", 
        :body => topic_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @res = @res["data"] if @code_name != 'emma'
      puts "Comment #{reply_id} under topic #{topic_id}is no longer upvoted by #{self.user_id}"
      self
    end

    def downvote_topic(topic_id)
      data = {
        "code_name": @code_name,
        "disliked": 1,
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{forum_base_url}/topic/#{topic_id}/dislike", 
        :body => topic_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @res = @res["data"] if @code_name != 'emma'
      puts "topic #{topic_id} is downvoted by #{self.user_id}"
      self
    end

    def downvote_comment(topic_id, reply_id)
      data = {
        "code_name": @code_name,
        "disliked": 1,
        "topic_id": topic_id,
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{forum_base_url}/reply/#{reply_id}/dislike", 
        :body => topic_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @res = @res["data"] if @code_name != 'emma'
      puts "Comment #{reply_id} under topic #{topic_id}is downvoted by #{self.user_id}"
      self
    end

    def cancel_downvote_topic(topic_id)
      data = {
        "code_name": @code_name,
        "disliked": 0,
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{forum_base_url}/topic/#{topic_id}/dislike", 
        :body => topic_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @res = @res["data"] if @code_name != 'emma'
      puts "topic #{topic_id} is no longer downvoted by #{self.user_id}"
      self
    end

    def cancel_downvote_comment(topic_id, reply_id)
      data = {
        "code_name": @code_name,
        "disliked": 0,
        "topic_id": topic_id,
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{forum_base_url}/reply/#{reply_id}/dislike", 
        :body => topic_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @res = @res["data"] if @code_name != 'emma'
      puts "Comment #{reply_id} under topic #{topic_id}is no longer downvoted by #{self.user_id}"
      self
    end

    def report_topic(topic_id,report_reason)
      data = {
        "code_name": @code_name,
        "reason": report_reason,
        "comment": "test topic",
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{forum_base_url}/topic/#{topic_id}/flag", :body => topic_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @res = @res["data"] if @code_name != 'emma'
      puts "topic #{topic_id} is flagged for reason #{report_reason} by #{self.user_id}"
      self
    end

    def report_comment(topic_id, reply_id, report_reason)
      data = {
        "code_name": @code_name,
        "reason": report_reason,
        "reply_id": reply_id,
        "comment": "test reply",
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{forum_base_url}/topic/#{topic_id}/flag", 
        :body => topic_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @res = @res["data"] if @code_name != 'emma'
      puts "comment #{reply_id} under #{topic_id} is flagged for reason #{report_reason} by #{self.user_id}"
      self
    end

    def get_all_groups
      data = {
        "code_name": @code_name,
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.get("#{forum_base_url}/user/#{self.user_id}/social_info", 
        :body => group_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @res = @res["data"] if @code_name != 'emma'
      @all_group_ids = @res["groups"].map { |h| h['id']}
      @all_group_names = @res["groups"].map { |h| h['name']}
      self
    end

    def leave_all_groups
      get_all_groups
      puts "Leaving all groups ..."
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
      data = {
        "title": args[:topic_title] || "Baby App IMAGE" + Time.now.to_s,
        "code_name": @code_name,
        "anonymous": 0,
        "ut": @ut,
        "warning": args[:tmi_flag] || 0,
        "image": File.new(image_pwd)
      }
      @group_id = args[:group_id] || GROUP_ID
      data,headers = MultipartImage::Post.prepare_query(topic_data)
      uri = URI ("#{forum_base_url}/group/#{@group_id}/create_photo")
      http = Net::HTTP.new(uri.host, uri.port)
      _res = http.post(uri.path, data, headers)
      @res = JSON.parse _res.body
      @res = @res["data"] if @code_name != 'emma'
      @topic_title =  @res["result"]["title"]
      @topic_id = @res["result"]["id"]
      puts "Photo created >>>>>>>>>>#{@topic_title}<<<<<<<"
      self
    end

    def create_group(args={})
      image_pwd = IMAGE_ROOT + Dir.new(IMAGE_ROOT).to_a.select{|f|    f.downcase.match(/\.jpg|\.jpeg|\.png/) }.sample
      data = {
        "ut": @ut,
        "desc": args[:group_description] || "Test group discription",
        "code_name": @code_name,
        "category_id": args[:group_category] || 1,
        "name": args[:group_name] || "Test create group",
        "image": File.new(image_pwd)
      }

      data,headers = MultipartImage::Post.prepare_query(topic_data)
      uri = URI ("#{forum_base_url}/group/create")
      http = Net::HTTP.new(uri.host, uri.port)
      _res = http.post(uri.path, data, headers)
      @res = JSON.parse _res.body
      @res = @res["data"] if @code_name != 'emma'
      @group_id = @res["group"]["id"]
      @group_name = @res["group"]["name"]
      puts "Group created >>>>>>>>>>#{@group_id}<<<<<<<\r\n Group name  >>>>>>>>>#{@group_name}<<<<<<<<<<"
      self
    end

    def turn_off_chat(args={})
      data = {
        "code_name": @code_name,
        "update_data":{"chat_off":1,"discoverable":0,"signature_on":1,"hide_posts":false},
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{forum_base_url}/user/update", 
        :body => user_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @res = @res["data"] if @code_name != 'emma'
      puts "TURN OFF CHAT FOR #{self.user_id}"
      self
    end

    def turn_on_chat(args={})
      data = {
        "code_name": @code_name,
        "update_data":{"chat_off":0,"discoverable":0,"signature_on":1,"hide_posts":false},
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{forum_base_url}/user/update", 
        :body => user_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @res = @res["data"] if @code_name != 'emma'
      puts "TURN ON CHAT FOR #{self.user_id}"
      self
    end

    def turn_off_signature(args={})
      data = {
        "code_name": @code_name,
        "update_data":{"chat_off":0,"discoverable":0,"signature_on":0,"hide_posts":false},
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{forum_base_url}/user/update",
        :body => user_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @res = @res["data"] if @code_name != 'emma'
      puts "TURN OFF Signature FOR #{self.user_id}"
      self
    end


    def turn_on_signature(args={})
      data = {
        "code_name": @code_name,
        "update_data":{"chat_off":0,"discoverable":0,"signature_on":1,"hide_posts":false},
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{forum_base_url}/user/update", 
        :body => user_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @res = @res["data"] if @code_name != 'emma'
      puts "TURN ON Signature FOR #{self.user_id}"
      self
    end

    def reset_all_flags(args={})
      data = {
        "code_name": @code_name,
        "update_data":{"chat_off":0,"discoverable":1,"signature_on":1,"hide_posts":false},
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{forum_base_url}/user/update", 
        :body => user_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @res = @res["data"] if @code_name != 'emma'
      log_important "RESET ALL FLAGS FOR #{self.user_id}"
      self
    end
    
    def send_chat_request(tgt_user_id)
      data = {
        "code_name": @code_name,
        "src": 2,
        "tgt_user_id": tgt_user_id,
        "ut": @ut
      }.merge(common_data)
      @tgt_user_id = tgt_user_id
      @res = HTTParty.post("#{forum_base_url}/chat/new", 
        :body => chat_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @res = @res["data"] if @code_name != 'emma'
      puts "#{self.user_id} send chat request to #{tgt_user_id}"
      self
    end



    def get_request_id
      data = {
        "code_name": @code_name,
        "ut": @ut
      }.merge(common_data)
      @res = HTTParty.get("#{forum_base_url}/chats_and_participants", 
        :body => chat_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @res = @res["data"] if @code_name != 'emma'
      @request_id = @res["requests"][0]["id"]
      self
    end

    def accept_chat
      get_request_id
      data = {
        "code_name": @code_name,
        "request_id": @request_id,
        "ut": @ut
      }.merge(common_data)
      @res = HTTParty.post("#{forum_base_url}/chat/accept", 
        :body => chat_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @res = @res["data"] if @code_name != 'emma'
      puts "#{self.user_id} accepts chat request id >>>#{request_id}<<<"
      self
    end

    def establish_chat(tgt_user)
      send_chat_request tgt_user.user_id
      tgt_user.accept_chat
    end

    def ignore_chat
      get_request_id
      data = {
        "code_name": @code_name,
        "request_id": @request_id,
        "ut": @ut
      }.merge(common_data)
      @res = HTTParty.post("#{forum_base_url}/chat/reject", 
        :body => chat_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @res = @res["data"] if @code_name != 'emma'
      puts "#{self.user_id} rejects chat request id >>>#{request_id}<<<"
      self
    end

    def remove_chat(tgt_user_id)
      data = {
        "code_name": @code_name,
        "tgt_user_id": tgt_user_id,
        "ut": @ut
      }.merge(common_data)
      @tgt_user_id = tgt_user_id
      @res = HTTParty.post("#{forum_base_url}/chat/remove_by_user", 
        :body => chat_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @res = @res["data"] if @code_name != 'emma'
      puts "#{self.user_id} remove chat relationship with #{tgt_user_id}"
      self
    end

    def get_all_participants
      data = {
        "code_name": @code_name,
        "ut": @ut
      }.merge(common_data)
      @res = HTTParty.get("#{forum_base_url}/chats_and_participants", 
        :body => chat_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @res = @res["data"] if @code_name != 'emma'
      @all_participants = @res['participants'].map {|n| n['id']}
    end
    
    def remove_all_participants
      _participants = self.get_all_participants
      _participants.each {|id| remove_chat id}
      self
    end
    
    def get_all_contacts
      data = {
        "code_name": @code_name,
        "ut": @ut
      }.merge(common_data)
      @res = HTTParty.get("#{forum_base_url}/chat/contacts", 
        :body => chat_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @res = @res["data"] if @code_name != 'emma'
      @all_contacts = @res['contacts'].map { |h| h['id']}
    end     

    def remove_all_contacts
      _contacts = self.get_all_contacts
      _contacts.each {|id| remove_chat id}
      self
    end

    def get_all_blocked
      data = {
        "code_name": @code_name,
        "ut": @ut
      }.merge(common_data)
      @res = HTTParty.get("#{forum_base_url}/users/blocked", 
        :body => blocked_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @res = @res["data"] if @code_name != 'emma'
      @all_blocked = @res['result'].map {|n| n['id']}
    end

    def remove_all_blocked
      _blocked_users = self.get_all_blocked
      _blocked_users.each {|id| unblock_user id}
      self
    end

    def availability(tgt_user_id)
      data = {
        "code_name": @code_name,
        "auto_confirm": 0,
        "counterpart_id": tgt_user_id,
        "ut": @ut
      }.merge(common_data)
      @tgt_user_id = tgt_user_id
      @res = HTTParty.get("#{forum_base_url}/chat/availability", 
        :body => chat_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @res = @res["data"] if @code_name != 'emma'
      self
    end

    def get_notification(user=self)
      user.pull
      puts "Notification Title >>>#{user.notifications[0]["title"]}\nNotification Type >>>#{user.notifications[0]["type"]}" if user.notifications
      puts "Notification Text >>>#{user.notifications[0]["text"]}" if user.notifications 
    end  
  end

end
