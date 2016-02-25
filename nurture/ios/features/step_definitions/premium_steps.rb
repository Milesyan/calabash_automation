  ##########>>>WWW layer steps<<<##########
  Given(/^I create a new premium user with name "([^"]*)"$/) do |name|
    $user = forum_page.forum_new_nurture_user(first_name: name)
    puts $user.email, $user.password
  end


  Then(/^I create another premium user "([^"]*)" and create a topic in the test group$/) do |name|
    $user = forum_page.forum_new_nurture_user(first_name: name)
    puts $user.email, $user.password
  end

  Then(/^I create another premium user "([^"]*)" and create a topic in the test group and update url in profile page$/) do |name|
    $user = forum_page.forum_new_nurture_user(first_name: name)
    puts $user.email, $user.password
  end

  Then(/^I create another premium user "([^"]*)" and create a topic in the test group and turn off chat in profile page$/) do |name|
    $user = forum_page.forum_new_nurture_user(first_name: name)
    puts $user.email, $user.password
  end

  ##########>>>APP steps<<<##########
  Then(/^I check the badge on the profile page exists$/) do
    wait_for_element_exists "UILabel marked:'Glow Plus'", :time_out => 5
  end


  Then(/^I input URL in edit profile page$/) do
    premium_page.input_url_in_profile_page
  end

  Then(/^I go back to user profile page$/) do
    forum_page.exit_edit_profile
    wait_for_none_animating
  end

  Then(/^I click the url and check the link works$/) do
    premium_page.check_url
  end

  Then(/^I go back to previous page from the pop-up web page$/) do
    premium_page.back_from_web_page
  end

  Then(/^I check that chat icon does not exist$/) do
    sleep 2
    check_element_does_not_exist "* marked:'Chat'"
  end

  Then(/^I check that the chat icon does not exist$/) do
    sleep 2
    check_element_does_not_exist "* marked:'Chat'"
  end

  Then(/^I check that the chat icon exists$/) do
    wait_for_element_exists "* marked:'Chat'"
  end

  Then(/^I click the chat icon and see the chat window$/) do
    wait_touch "* marked:'Chat'"
    wait_for_element_exists "*"
  end

  Then(/^I turn off chat in profile settings$/) do
    premium_page.switch_chat_option
  end


  Then(/^I check that the chat section does not exist on the first page$/) do
    sleep 2
    check_element_does_not_exist "* marked:'RECOMMENDED PEOPLE'"
  end

  Then(/^I turn off signature in profile settings$/) do
    premium_page.switch_signature_option
  end

  Then(/^I should not see the signature in topic\/comment\/subreply$/) do
    check_element_does_not_exist "* id:'gl-community-plus-badge.png'"
  end

  Then(/^I update bio and location info$/) do
    premium_page.update_bio_location
  end

  Then(/^I checked the elements in a signature$/) do
    check_element_exists "* marked:'Chat'"
    check_element_exists "* id:'gl-community-plus-badge.png'"
  end

  Then(/^I click the areas in signature$/) do
    "* marked:'Chat' index:0 parent * index:0"
  end

  Then(/^I should go to profile page$/) do
    wait_for_element_exists "* {text CONTAINS 'FOLLOWING'}"
  end

  Given(/^I enter the topic "([^"]*)"$/) do |arg1|
    wait_touch "label {text CONTAINS '#{arg1}'} index:0"
    wait_for_none_animating
  end

  Then(/^I check the signature does not display$/) do
    check_element_does_not_exist "* marked:'Chat'"
    check_element_does_not_exist "* id:'gl-community-plus-badge.png'"
  end