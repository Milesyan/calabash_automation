def forum_new_user(args = {})
  ForumUser.new(args).all_signup_flow.leave_all_groups.join_group
end

def ntf_user(args = {})
  ForumUser.new(args).all_signup_flow
end

#community notification test

Then(/^I check the text and click the buttons for this type of notification$/) do
  case $ntf_type
  when "1050","1085","1086","1087","1051","1053", "1059", "1060", "1088", "1089"
    puts "Touch Check it out"
    wait_touch "* marked:'Check it out'"
  when "1055"
    puts "Touch Take a look"
    wait_touch "* marked:'Check it out'"
  when ""
    puts "Touch Checkout out the results"
    wait_touch "* marked:'Check out the results'"
  when "1091"
    wait_touch "* marked:'Follow Back'"
  when "1092"
    sleep 10
  end
end

Then(/^I should see the page is navigating to the right page$/) do
  sleep 1
  case $ntf_type
  when "1050", "1085", "1086", "1087","1051","1055", "1060", "1088", "1089"
    wait_for_element_exists "* marked:'notification_#{$ntf_type}'"
  when "1059"
    wait_for_element_exists "* marked:'notification_#{$ntf_type}'" 
    wait_for_element_exists "* {text CONTAINS 'Reply_#{$ntf_type}'}"
  when "1053"
    wait_for_element_exists "* marked:'notification_#{$ntf_type}'" 
    sleep 1
    scroll_down
    wait_for_element_exists "* {text CONTAINS 'Reply_#{$ntf_type}'}"
  when "1091"
    wait_for_element_exists "* marked:'Follow'"
  end
end

Then(/^I go back to community page$/) do
  case $ntf_type
  when "1050", "1085", "1086", "1087","1051","1053","1055", "1059", "1060", "1088", "1089"
    forum_page.click_back_button
  when "1091", "1092"
    forum_page.click_back_button
  else 
    forum_page.click_back_button
  end
end
