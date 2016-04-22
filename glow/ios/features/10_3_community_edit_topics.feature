@forum @edit_topic
Feature: User edit topics.
  @edit_post @restart
  Scenario: User create a text topic and edit it.
    Given I create a new forum user with name "Charlotte"
    And I login as the new user "Charlotte" created through www
    And I open "community" page
    And I go to the first group
    Then I post a text topic with title "test edit topic"
    And I go back to group
    And I edit the topic "test edit topic" and change the title and content
    Then I should see the topic is posted successfully
    And I logout

  @edit_existing_topic
  Scenario: Create a user and text topic through www and test edit it.
    Given I create a new forum user with name "Alex"
    And "Alex" create a "text" topic in the test group
    And I login as the new user "Alex" created through www
    And I open "community" page
    And I go to the first group
    Then I edit the topic "create topic by www api" and change the title and content
    Then I should see the topic is posted successfully
    And I logout

  @edit_poll_before_voted
  #!!!should add modify vote index
  Scenario: Create a user and a poll topic through www and test edit it.
    Given I create a new forum user with name "Miles"
    And "Miles" create a "poll" topic in the test group
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    Then I edit the topic create poll by www api and change the title and content
    Then I should see the topic is posted successfully
    And I logout

  @edit_poll_after_voted
  Scenario: Create a user and a poll topic through www and create another user to vote it.
    Given I create a new forum user with name "Miles"
    And "Miles" create a "poll" topic in the test group
    Then I created another user to vote the poll
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    Then I edit the topic create poll by www api and change the title and content
    Then I should see the topic is posted successfully
    And I logout
