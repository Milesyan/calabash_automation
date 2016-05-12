@premium @request
Feature: Chat request -> accept/ignore.
  @accept_request @p0
  Scenario: Premium User sends chat request to no-premium user and the non-premium user accepts the request
    Given A premium user has been created for test
    And I create another non-premium user "Charlotte" and create a topic in the test group with topic name "Test signature chat"
    And I login as premium user
    And I open "community" page
    And I go to the first group
    And I open the topic "Test signature chat"
    When I click the chat icon and see the chat window
    Then I should see the send request dialog
    And I click send request button
    And I go back to previous page
    And I logout
    And I login as the new user
    And I open "community" page
    And I go to messages 
    And I click the name of the chat requester
    When I accept the chat request
    Then I enter the chat window and start to chat
    And I go back to previous page
    And I click done to close messages
    And I logout

  @ignore_chat_request
  Scenario: Premium User sends chat request to no-premium user and the non-premium user ignores the request
    Given A premium user has been created for test
    And I create another non-premium user "Zed" and create a topic in the test group with topic name "Test signature chat"
    And I login as premium user
    And I open "community" page
    And I go to the first group
    And I open the topic "Test signature chat"
    When I click the chat icon and see the chat window
    Then I should see the send request dialog
    And I click send request button
    And I go back to previous page
    And I logout
    And I login as the new user
    And I open "community" page
    And I go to messages 
    And I click the name of the chat requester
    When I ignore the chat request
    Then I should see the chat request is ignored
    And I click done to close messages
    And I logout

  @block_chat_request @p0
  Scenario: Premium User sends chat request to no-premium user and the non-premium user blocks the request
    Given A premium user has been created for test
    And I create another non-premium user "Troll" and create a topic in the test group with topic name "Test chat block"
    And I login as premium user
    And I open "community" page
    And I go to the first group
    And I open the topic "Test chat block"
    When I click the chat icon and see the chat window
    Then I should see the send request dialog
    And I click send request button
    And I go back to previous page
    And I logout
    And I login as the new user
    And I open "community" page
    And I go to messages 
    And I click the name of the chat requester
    When I block the chat request
    Then I should see the chat requst is blocked
    And I click done to close messages
    Then I go to community settings page
    And I go to blocked users part under community settings
    Then I can see the person I blocked
    Then I exit blocking users page
    And I click back button in the community settings page
    And I logout