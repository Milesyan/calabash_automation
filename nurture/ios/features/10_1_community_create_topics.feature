@forum @create_topics
Feature: User create text/poll/image/url topics 
  @create_post @pre @p0
  Scenario: User create a text topic
    Given I create a new forum user with name "Miles"
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I post a "text" topic
    Then I should see the topic is posted successfully
    And I logout

  @create_poll
  Scenario: User create a poll topic @create_poll
    Given I create a new forum user with name "Miles"
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I post a "poll" topic
    Then I should see the topic is posted successfully
    And I logout

  @create_image 
  Scenario: User create a image topic
    Given I create a new forum user with name "Miles"
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I post a "image" topic
    Then I should see the topic is posted successfully
    And I logout 

  # @create_link
  # Scenario: User create a link topic @create_link
  #   Given I create a new forum user with name "Miles"
  #   And I login as the new user "Miles" created through www
  #   And I open "community" page
  #   And I post a "link" topic
  #   Then I should see the topic is posted successfully
  #   And I logout

  @create_post_in_group
  Scenario: User create a text topic in group @create_post_in_group
    Given I create a new forum user with name "Miles"
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    And I post a text topic with title "Post in group topic"
    Then I should see the topic is posted successfully
    And I logout

