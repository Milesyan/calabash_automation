@forum @edit_topic
Feature: User edit topics (6m24.188s 34 steps 4 scenarios)
  @edit_post  
  Scenario: User create a text topic and edit it
    Given I create a new "ttc" glow user
    Then I login as the new user or default user
    And I open "community" page
    Then I go to the first group
    And I post a text topic with title "test edit topic"
    Then I go back to group
    Then I edit the topic "test edit topic" and change the title and content
    Then I should see the topic is posted successfully
    Then I logout

  @edit_existing_topic
  Scenario: Create a user and text topic through www and test edit it.
    Given I create a new "ttc" glow user 
    And The user create a "text" topic in group "4"
    Then I login as the new user or default user
    And I open "community" page
    Then I edit the topic "create topic by www api" and change the title and content
    Then I should see the topic is posted successfully
    Then I logout

  @edit_poll_before_voted
  #!!!should add modify vote index
  Scenario: Create a user and a poll topic through www and test edit it
    Given I create a new "ttc" glow user 
    And The user create a "poll" topic in group "4"
    Then I login as the new user or default user
    And I open "community" page
    Then I go to the first group
    Then I edit the topic "create poll by www api" and change the title and content
    Then I should see the topic is posted successfully
    Then I logout

  @edit_poll_after_voted
  Scenario: Create a user and a poll topic through www and create another user to vote it.
    Given I create a new "non-ttc" glow user 
    And The user create a "poll" topic in group "4"
    Then I created another user to vote the poll
    Then I login as the new user or default user
    And I open "community" page
    Then I go to the first group
    Then I edit the topic "create poll by www api" and change the title and content
    Then I should see the topic is posted successfully
    Then I logout
