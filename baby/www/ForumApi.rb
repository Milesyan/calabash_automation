module ForumApi
  extend TestHelper 
  BASE_URL = load_config["base_urls"]["Sandbox"]
  FORUM_BASE_URL = load_config["base_urls"]["SandboxForum"]
  
  class ForumIOS
    def create_topic(args = {})
      topic_data = {
        "code_name": @code_name,
        "content": "#{Time.now.strftime "%D %T"}",
        "title": args[:topic_title] || "#{@email} #{Time.now}",
        "anonymous": 0,
        "ut": @ut
      }.merge(common_data)  # random_str isn't needed
      @group_id = args[:group_id] || GROUP_ID
      @res =  HTTParty.post("#{FORUM_BASE_URL}/group/#{@group_id}/create_topic", :body => topic_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts "Code name #{@code_name}"
      @code_name == 'emma'? @topic_id = @res["topic"]["id"]: @topic_id = @res["data"]["topic"]["id"]
      @code_name == 'emma'? @group_id = @res["topic"]["id"]: @group_id = @res["data"]["topic"]["group_id"]
      @code_name == 'emma'? title = @res["topic"]["id"]: title = @res["data"]["topic"]["title"]
      @topic_title = title
      puts "topic >>>>>'#{title}'<<<<< created，topic id is #{topic_id}"
      self
    end

    def reply_to_topic(topic_id, args = {})
      reply_data = {
        "code_name": @code_name,
        "content": args[:reply_content]||"Reply to topic #{topic_id} and time is #{Time.now.to_i}",
        "anonymous": 0,
        "reply_to": 0,
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{FORUM_BASE_URL}/topic/#{topic_id}/create_reply", :body => reply_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @code_name == 'emma'? @reply_id = @res["result"]["id"]: @reply_id = @res["data"]["result"]["id"] 
      puts "Reply to topic >>>>>#{topic_id}<<<<<"
      self
    end 

    def create_poll(args = {})
      topic_data = {
        "code_name": @code_name,
        "content": "#{Time.now.strftime "%D %T"}",
        "anonymous": 0,
        "title": args[:topic_title] || "Poll + #{@email} #{Time.now}",
        "options": ["Field1","Field2","Field3"].to_s,
        "ut": @ut
      }.merge(common_data)
      @group_id = args[:group_id] || GROUP_ID
      @res =  HTTParty.post("#{FORUM_BASE_URL}/group/#{@group_id}/create_poll", :body => topic_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @code_name == 'emma'? @topic_id = @res["result"]["id"]: @topic_id = @res["data"]["result"]["id"]
      @code_name == 'emma'? title = @res["result"]["title"]: title = @res["data"]["result"]["title"]
      @topic_title = title
      puts "Poll >>>>>'#{title}'<<<<< created, topic id is #{topic_id}"
      self
    end

    def vote_poll(args = {})
      vote_data = {
        "code_name": @code_name,
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
        "code_name": @code_name,
        "content": args[:reply_content]||"Reply to topic #{topic_id} and time is #{Time.now.to_i}",
        "anonymous": 0,
        "reply_to": 0,
        "ut": @ut
      }.merge(common_data)

      @res =  HTTParty.post("#{FORUM_BASE_URL}/topic/#{topic_id}/create_reply", :body => reply_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @code_name == 'emma'? @reply_id = @res["result"]["id"]: @reply_id = @res["data"]["result"]["id"] 
      puts "Reply to topic >>>>>#{topic_id}<<<<<"
      self
    end

    def reply_to_comment(topic_id,reply_id,args = {})
      reply_data = {
        "code_name": @code_name,
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
        "code_name": @code_name,
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
        "code_name": @code_name,
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
        "code_name": @code_name,
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
        "code_name": @code_name,
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{FORUM_BASE_URL}/topic/#{topic_id}/remove", :body => reply_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      self
      puts "#{topic_id} deleted"
    end

    def follow_user(user_id)
      reply_data = {
        "code_name": @code_name,
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{FORUM_BASE_URL}/user/#{user_id}/follow", :body => reply_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      self
      puts "#{user_id} is followed by user #{self.user_id}"
    end

    def unfollow_user(user_id)
      reply_data = {
        "code_name": @code_name,
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{FORUM_BASE_URL}/user/#{user_id}/unfollow", :body => reply_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      self
      puts "#{user_id} is unfollowed by user #{self.user_id}"
    end

    def block_user(user_id)
      reply_data = {
        "code_name": @code_name,
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{FORUM_BASE_URL}/user/#{user_id}/block", :body => reply_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      self
      puts "#{user_id} is blocked by user #{self.user_id}"
    end

    def unblock_user(user_id)
      reply_data = {
        "code_name": @code_name,
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{FORUM_BASE_URL}/user/#{user_id}/unblock", :body => reply_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      self
      puts "#{user_id} is unblocked by user #{self.user_id}"
    end  

    def bookmark_topic(topic_id)
      topic_data = {
        "code_name": @code_name,
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
        "code_name": @code_name,
        "bookmarked": 0,
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{FORUM_BASE_URL}/topic/#{topic_id}/bookmark", :body => topic_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts "topic #{topic_id} is unbookmarked by #{self.user_id}"
      self
    end

    def upvote_topic(topic_id)
      topic_data = {
        "code_name": @code_name,
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
        "code_name": @code_name,
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
        "code_name": @code_name,
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
        "code_name": @code_name,
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
        "code_name": @code_name,
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
        "code_name": @code_name,
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
        "code_name": @code_name,
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
        "code_name": @code_name,
        "disliked": 0,
        "topic_id": topic_id,
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{FORUM_BASE_URL}/reply/#{reply_id}/dislike", :body => topic_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts "Comment #{reply_id} under topic #{topic_id}is no longer downvoted by #{self.user_id}"
      self
    end

    def report_topic(topic_id,report_reason)
      topic_data = {
        "code_name": @code_name,
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
        "code_name": @code_name,
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
        "code_name": @code_name,
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.get("#{FORUM_BASE_URL}/user/#{self.user_id}/social_info", :body => group_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @all_group_ids = []
      @all_group_names = []
      @code_name == 'emma'? (temp = @res["groups"]): (temp = @res["data"]["groups"])
      temp.each do |element|
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
        "code_name": @code_name,
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
      @code_name == 'emma'? @topic_title =  @res["result"]["title"]: @topic_title =  @res["data"]["result"]["title"] 
      @code_name == 'emma'? @topic_id = @res["result"]["id"]: @topic_id = @res["data"]["result"]["id"]
      puts "Photo created >>>>>>>>>>#{@topic_title}<<<<<<<"
      self
    end

    def create_group(args={})
      image_pwd = IMAGE_ROOT + Dir.new(IMAGE_ROOT).to_a.select{|f|    f.downcase.match(/\.jpg|\.jpeg|\.png/) }.sample
      topic_data = {
        "ut": @ut,
        "desc": args[:group_description] || "Test group discription",
        "code_name": @code_name,
        "category_id": args[:group_category] || 1,
        "name": args[:group_name] || "Test create group",
        "image": File.new(image_pwd)
      }

      data,headers = MultipartImage::Post.prepare_query(topic_data)
      uri = URI ("#{FORUM_BASE_URL}/group/create")
      http = Net::HTTP.new(uri.host, uri.port)
      _res = http.post(uri.path, data, headers)
      @res = JSON.parse _res.body
      @code_name == 'emma'? @group_id = @res["group"]["id"]: @group_id = @res["data"]["group"]["id"]
      @code_name == 'emma'? @group_name = @res["group"]["name"]: @group_name = @res["data"]["group"]["name"]
      puts "Group created >>>>>>>>>>#{@group_id}<<<<<<<\r\n Group name  >>>>>>>>>#{@group_name}<<<<<<<<<<"
      self
    end

    def turn_off_chat(args={})
      user_data = {
        "code_name": @code_name,
        "update_data":{"chat_off":1,"discoverable":0,"signature_on":1,"hide_posts":false},
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{FORUM_BASE_URL}/user/update", :body => user_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts "TURN OFF CHAT FOR #{self.user_id}"
      self
    end

    def turn_on_chat(args={})
      user_data = {
        "code_name": @code_name,
        "update_data":{"chat_off":0,"discoverable":0,"signature_on":1,"hide_posts":false},
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{FORUM_BASE_URL}/user/update", :body => user_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts "TURN ON CHAT FOR #{self.user_id}"
      self
    end

    def turn_off_signature(args={})
      user_data = {
        "code_name": @code_name,
        "update_data":{"chat_off":0,"discoverable":0,"signature_on":0,"hide_posts":false},
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{FORUM_BASE_URL}/user/update", :body => user_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts "TURN OFF Signature FOR #{self.user_id}"
      self
    end

    def turn_on_signature(args={})
      user_data = {
        "code_name": @code_name,
        "update_data":{"chat_off":0,"discoverable":0,"signature_on":1,"hide_posts":false},
        "ut": @ut
      }.merge(common_data)
      @res =  HTTParty.post("#{FORUM_BASE_URL}/user/update", :body => user_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts "TURN ON Signature FOR #{self.user_id}"
      self
    end

    def send_chat_request(tgt_user_id)
      chat_data = {
        "code_name": @code_name,
        "src": 2,
        "tgt_user_id": tgt_user_id,
        "ut": @ut
      }.merge(common_data)
      @tgt_user_id = tgt_user_id
      @res = HTTParty.post("#{FORUM_BASE_URL}/chat/new", :body => chat_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts "#{self.user_id} send chat request to #{tgt_user_id}"
      self
    end

    def get_request_id
      chat_data = {
        "code_name": @code_name,
        "ut": @ut
      }.merge(common_data)
      @res = HTTParty.get("#{FORUM_BASE_URL}/chats_and_participants", :body => chat_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @code_name == 'emma'? @request_id = @res["requests"][0]["id"]: @request_id = @res["data"]["requests"][0]["id"]
      self
    end

    def accept_chat
      get_request_id
      chat_data = {
        "code_name": @code_name,
        "request_id": @request_id,
        "ut": @ut
      }.merge(common_data)
      @res = HTTParty.post("#{FORUM_BASE_URL}/chat/accept", :body => chat_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts "#{self.user_id} accepts chat request id >>>#{request_id}<<<"
      self
    end

    def establish_chat(tgt_user)
      send_chat_request tgt_user.user_id
      tgt_user.accept_chat
    end

    def ignore_chat
      get_request_id
      chat_data = {
        "code_name": @code_name,
        "request_id": @request_id,
        "ut": @ut
      }.merge(common_data)
      @res = HTTParty.post("#{FORUM_BASE_URL}/chat/reject", :body => chat_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts "#{self.user_id} rejects chat request id >>>#{request_id}<<<"
      self
    end

    def remove_chat(tgt_user_id)
      chat_data = {
        "code_name": @code_name,
        "tgt_user_id": tgt_user_id,
        "ut": @ut
      }.merge(common_data)
      @tgt_user_id = tgt_user_id
      @res = HTTParty.post("#{FORUM_BASE_URL}/chat/remove_by_user", :body => chat_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      puts "#{self.user_id} remove chat relationship with #{tgt_user_id}"
      self
    end

    def get_all_participants
      chat_data = {
        "code_name": @code_name,
        "ut": @ut
      }.merge(common_data)
      @res = HTTParty.get("#{FORUM_BASE_URL}/chats_and_participants", :body => chat_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @all_participants = []
      @code_name == 'emma'? temp = @res["participants"]: temp = @res["data"]["participants"]
      temp.each do |element|
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
    
    def get_all_contacts
      chat_data = {
        "code_name": @code_name,
        "ut": @ut
      }.merge(common_data)
      @res = HTTParty.get("#{FORUM_BASE_URL}/chat/contacts", :body => chat_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @all_contacts = []
      @code_name == 'emma'? temp = @res["contacts"]: temp = @res["data"]["contacts"]
      temp.each do |element|
        element.each do |k,v|
          if k == "id"
            @all_contacts.push v
          end
        end
      end
      @all_contacts
    end     

    def remove_all_contacts
      _contacts = self.get_all_contacts
      _contacts.each do |id|
        remove_chat id
      end
      self
    end

    def get_all_blocked
      blocked_data = {
        "code_name": @code_name,
        "ut": @ut
      }.merge(common_data)
      @res = HTTParty.get("#{FORUM_BASE_URL}/users/blocked", :body => blocked_data.to_json,
        :headers => { 'Content-Type' => 'application/json' })
      @all_blocked = []
      @code_name == 'emma'? temp = @res["result"]: temp = @res["data"]["result"]
      temp.each do |element|
        element.each do |k,v|
          if k == "id"
            @all_blocked.push v
          end
        end
      end
      @all_blocked
    end

    def remove_all_blocked
      _blocked_users = self.get_all_blocked
      _blocked_users.each do |id|
        unblock_user id
      end
      self
    end
  end

end
