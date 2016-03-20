@premium @forum_relation
Feature: Check chat relationship and forum relationship.
  @request_follow
  Scenario: Send a chat request will automatically follow the user
    Given A premium user miles2 and a non-premium user milesn have been created for test
    And I create another non-premium user "Charlotte" and create a topic in the test group with topic name "Test request chat auto follow"
    And I login as premium user
    And I open "community" page
    And I go to the first group
    And I open the topic "Test request chat auto follow"
    When I click the chat icon and see the chat window
    Then I should see the send request dialog
    And I click send request button
    When I enter new user's profile
    Then I can see the status is following
    And I go back to previous page
    And I logout

  @block_black_list
  Scenario: Block a person will automatically put her/him in the forum blocked list.
    Given A premium user miles2 established chat relationship with a new user "Holmes"
    And I login as premium user
    And I open "community" page
    And I go to messages 
    And I go to the chat window for the new user
    And I click chat settings 
    When I click "Block this user" in chat options
    Then I confirm to block the user
    And I click done to close messages
    And I go to community settings page
    When I go to blocked users part under community settings
    Then I can see the person I blocked
    And I exit blocking users page
    And I click save of the community settings page
    And I logout
