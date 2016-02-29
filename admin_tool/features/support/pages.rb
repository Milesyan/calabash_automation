def login_page
  @login_page ||= LoginPage.new
end

def home_page
  @home_page ||= HomePage.new
end

def forum_page
  @forum_page ||= ForumPage.new
end

def nav_to(name)
  case name.downcase
  when "profile"
    visit "/user/#{$user.id}"
  when "partner_history"
    visit "/user/#{$user.id}/profile/relation"

  when "user_forum_activities"
    visit "/user/#{$user.id}/community"
  when "user_forum_groups"
    visit "/user/#{$user.id}/community/groups"
  when "glow_period_editor"

  when "glow_daily_data"
    visit "/user/#{$user.id}/glow/daily_data"
  when "glow_status_history"
    visit "/user/#{$user.id}/glow/status_history"
  when "glow_notifications"
    visit "/user/#{$user.id}/glow/notification_history"
  when "glow_insights"
    visit "/user/#{$user.id}/glow/insight_history"
  when "glow_reminders"
    visit "/user/#{$user.id}/glow/reminder"
  when "glow_pdf_export"
    visit "/user/#{$user.id}/glow/pdf_export"

  when "nurture_daily_data"
    visit "/user/#{$user.id}/nurture/daily_data"
  when "nurture_pregnancy_history"
    visit "/user/#{$user.id}/nurture/pregnancy"
  when "nurture_medical_log"
    visit "/user/#{$user.id}/nurture/medical_log"
  when "nurture_notifications"
    visit "/user/#{$user.id}/nurture/notification_history"
  when "nurture_insights"
    visit "/user/#{$user.id}/nurture/insight_history"
  when "nurture_reminders"
    visit "/user/#{$user.id}/nurture/reminder"
  when "nurture_pdf_export"
    visit "/user/#{$user.id}/nurture/pdf_export"

  when "eve_period_editor"
    visit "/user/#{$user.id}/eve/period"
  when "eve_notifications"
    visit "/user/#{$user.id}/eve/notification_history"
  when "eve_daily_data"
    visit "/user/#{$user.id}/eve/daily_data"

  when "baby_notifications"
    visit "/user/#{$user.id}/baby/notification_history"
  when "baby_milestones"
    visit "/user/#{$user.id}/baby/milestones"
  when "baby_insights"
    visit "/user/#{$user.id}/baby/insight_history"
  when "baby_daily_data"
    visit "/user/#{$user.id}/baby/baby_data"
  when "baby_feed_data"
    visit "/user/#{$user.id}/baby/baby_feed_data"
  when "baby_pdf_export"
    visit "/user/#{$user.id}/baby/pdf_export"

  when "community"
    #visit "/community/spamqueue"
    find('a', :text => 'Community').click
  when "content"
    #visit "/content"
    find('a', :text => 'Content').click
  end

end
