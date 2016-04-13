@premium @chat_notification
Feature: Check notifications about chat

  @request_notification
  Scenario: Check notification when user sends a chat request
    Given A premium user miles3 sent chat request to a new user "Albert"
    And I login as the new user
    When I open "alert" page
    Then I check the chat request is received 
    When I click accept request button
    Then I should see the messages page
    And I go back to previous page
    And I wait for 2 seconds for the next page
    And I click done to close messages
    # And I go back to community page
    And I logout

  @accept_notification @wip
  Scenario: Check notification when user accepts a chat request
    Given A premium user miles3 established chat relationship with a new user "BabySong"
    And I login as premium user
    When I open "alert" page
    Then I check the accept chat request notification is received
    When I click chat now button
    Then I should see the messages page
    And I go back to previous page
    And I wait for 2 seconds for the next page
    And I click done to close messages
    # And I go back to community page
    And I logout