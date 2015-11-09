Given(/^I post a "(.*?)" topic$/) do |topic_type|
  case topic_type.downcase
  when "poll"
    forum_page.create_poll
  when "text"
    forum_page.create_post
  when "photo"
    forum_page.create_photo
  when "link"
    forum_page.create_link
  end
end