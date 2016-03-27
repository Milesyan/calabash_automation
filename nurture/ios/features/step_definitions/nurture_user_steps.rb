def forum_new_user(args={})
  ForumUser.new(args).signup.login.leave_all_groups.join_group
end

def ntf_user(args = {})
  ForumUser.new(args).signup.login
end
  

#----------------Community--------------------
#community notification test

Then(/^I check the text and click the buttons for this type of notification$/) do
  case $ntf_type
  when "1050","1085","1086","1087","1051","1053", "1059", "1088", "1089", "1055"
    puts "Touch Check it out"
    sleep 1
    wait_touch "* {text CONTAINS 'Check it out'}"
  when ""
    puts "Touch Take a look"
    wait_touch "* {text CONTAINS 'Take a look'}"
  when "1060"
    puts "Touch Checkout out the results"
    wait_touch "* {text CONTAINS 'Check out the results'}"
  when "1091"
    wait_touch "* {text CONTAINS 'Follow back'}"
  when "1092"
    sleep 10
  end
end

Then(/^I should see the page is navigating to the right page$/) do
  case $ntf_type
  when "1050", "1085", "1086", "1087","1051","1055", "1060", "1088", "1089"
    wait_for_element_exists "* marked:'Upvote'"
    wait_for_element_exists "* marked:'notification_#{$ntf_type}'"
  when "1053","1059"
    wait_for_element_exists "* marked:'Upvote'"
    wait_for_element_exists "* marked:'notification_#{$ntf_type}'"
    wait_for_element_exists "* {text CONTAINS 'Reply_#{$ntf_type}'}"
  when "1091"
    wait_for_element_exists "* marked:'Follow'"
  end
end

Then(/^I go back to community page$/) do
  case $ntf_type
  when "1050", "1085", "1086", "1087","1051","1053","1055", "1059", "1060", "1088", "1089"
    forum_page.click_topnav_close
  when "1091", "1092"
    forum_page.exit_profile_page forum_page.get_UIButton_number-1
  else
    forum_page.click_topnav_close
  end
end

