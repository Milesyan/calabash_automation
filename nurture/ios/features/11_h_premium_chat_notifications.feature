@premium @chat_notification
Feature: Check notifications about chat

  @request_notification
  Scenario: Check notification when user sends chat request
    Given A premium user miles2 sent chat request to a new user "Albert"
    And I login as the new user
    When I open "alert" page
    Then I check the chat request is received 
    When I click accept request button
    And I go back to previous page
    And I wait for 2 seconds for the next page
    And I click done to close messages
    And I go back to community page
    And I logout
