@premium @profile_chat
Feature: Premium user enter a non-premium user's profile and initial a chat request 
  Scenario: Premium user check chat icon in other users profile page
    Given A premium user miles3 and a non-premium user milesn have been created for test
    And I create another non-premium user "Charlotte" and create a topic in the test group with topic name "Test profile chat"
    And I login as the premium user
    And I open "community" page
    And I go to the first group
    And I open the topic "Test profile chat"
    When I click the name of the new user and enter the user's profile page
    Then I check that the chat icon exists
    When I click the chat icon and see the chat window
    Then I should see the send request dialog
    And I click send request button
    And I go back to forum page from forum profile page
    And I go back to previous page
    And I logout
    And I login as the new user
    And I open "community" page
    And I go to messages 
    And I click the name of the chat requester
    When I accept the chat request
    Then I enter the chat window and start to chat
    And I go back to previous page
    And I go back to previous page
    And I click done to close messages
    And I logout
