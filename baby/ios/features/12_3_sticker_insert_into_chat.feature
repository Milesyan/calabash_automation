@not_ready
Feature: User inserts sticker into chat window.
  Scenario: User send stickers in chat
    Given A premium user milesp established chat relationship with a new user "Buddy"
    Then I login as premium user
    And I open "community" page
    And I go to messages
    And I enter the chat window and start to chat
    When I click add sticker button
    Then I should see the select sticker page
    Then I choose a premium pack
    And I click to add a sticker in chat
    When I send the message
    Then I should see the sticker is sent successfully
    And I go to previous page
    And I click done to close messages
    And I logout
    And I login as the new user
    And I open "community" page
    And I go to messages
    And I enter the chat window and start to chat
    And I should see the sticker is received
    And I go to previous page
    And I click done to close messages
    And I logout
