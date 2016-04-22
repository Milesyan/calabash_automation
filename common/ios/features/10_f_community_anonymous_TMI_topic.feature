@forum @anonymous_tmi @restart
Feature: Create and edit anonymous topic, Check TMI photo.

  @create_anonymous_topic
  Scenario: User create a text topic in group in anonymous mode.
    Given I create a new forum user with name "Miles"
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    And I post a text topic with title "Post in group topic" anonymously
    Then I should not see the creator name
    And I logout

  @create_TMI_photo
  Scenario: User create a image topic in TMI mode
    Given I create a new forum user with name "Miles"
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I post a image topic with TMI flag
    Then I should see the topic is posted successfully
    And I logout

  @edit_TMI_photo
  Scenario: User create a image topic in TMI mode
    Given I create a new forum user with name "Miles"
    And "Miles" create a "photo" topic in the test group in TMI mode
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I post a image topic with TMI flag
    Then I should see the topic is posted successfully
    And I logout
