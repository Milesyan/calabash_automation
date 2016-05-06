@not_ready
Feature: Sticker gating when users click stickers not owned by them
  Scenario: Free user clicks premium stickers in topics
    Given A premium user and a non-premium user have been created for test
    And premium user create a topic and a comment with premium stickers
    And I login as the non-premium user
    And I open "community" page
    And I go to the first group
    And I open the topic "Test premium sticker gating"
    When I click the sticker in topic
    Then I should see the premium sticker gating page
    And I click close sticker gating dialog
    When I click the sticker in comment
    Then I should see the prompt premium dialog
    And I click close sticker gating dialog
    And I go back to previous page
    And I logout

  Scenario: Free user clicks alc stickers
    Given A user had bought all alc stickers has been created
    And the alc user create a topic and comment with alc stickers
    And I create a new forum user with name "Miles"
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    And I enter the topic "Test alc stickers"
    When I click the sticker in topic
    Then I should see the alc sticker gating page
    And I click close sticker gating dialog
    When I click the sticker in comment
    Then I should see the alc sticker gating page
    And I click close sticker gating dialog
    And I go back to previous page
    And I logout

  Scenario: Free user clicks alc and premium stickers in chat.
    Given A premium user established chat relationship with a new user "Hewitt"
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
