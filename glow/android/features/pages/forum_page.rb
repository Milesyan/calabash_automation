require 'calabash-android/abase'

class ForumPage < Calabash::ABase
  def trait
    "*"
  end

  def create_poll
    touch "* id:'create_poll_btn'"
    title = "Poll " + random_str
    answer1 = random_str
    answer2 = random_str
    answer3 = random_str
    description = "poll #{Time.now.to_i}"
    enter_text "* id:'title_editor'", title
    enter_text "* id:'text' index:0", answer1
    enter_text "* id:'text' index:1", answer2
    enter_text "* id:'text' index:2", answer3
    enter_text "* id:'content_editor'", description
    touch "* id:'create_yes'"
    touch "* id:'text1'" # select a group
    sleep 2
  end

  def create_post
    touch "* id:'create_topic_btn'"
    title = "Topic " + random_str
    description = "topic #{Time.now.to_i}"
    enter_text "* id:'title_editor'", title
    enter_text "* id:'content_editor'", description
    touch "* id:'create_yes'" # done button
    touch "* id:'text1'" # select a group
    sleep 2
  end

  def create_photo
    touch "* id:'create_photo_btn'"
    touch "* marked:'Take a photo'"
  end

  def create_link
    touch "* id:'create_url_btn'"
    title = "link " + random_str
    link = "www.baidu.com "
    enter_text "* id:'title_editor'", title
    enter_text "* id:'content_editor'", link
    sleep 1
    wait_for_elements_do_not_exist "* id:'progress_bar'"
    touch "* id:'create_yes'" # done button
    touch "* id:'text1'" # select a group
    sleep 2
  end
end