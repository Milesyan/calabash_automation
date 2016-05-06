@premium @opt-out 
Feature: Opt-out; check remove chat history, remove contact.
  @remove_chat_history @p0
  Scenario: Remove chat history in messages page
    Given A premium user established chat relationship with a new user "Swipe"
    And I login as premium user
    And I open "community" page
    And I go to messages 
    And I go to the chat window for the new user
    Then I send a message with text "test delete history"
    And I go back to previous page
    When I swipe the conversation log and click delete
    Then I should see the chat history has been deleted
    And I click done to close messages
    And I logout

  @remove_contact
  Scenario: Remove contact in contact list.
    Given A premium user established chat relationship with a new user "Remove"
    And I login as premium user
    And I open "community" page
    And I go to messages 
    And I go to the chat window for the new user
    Then I send a message with text "test delete history"
    And I go back to previous page
    When I go to contact list
    Then I should see the user "Remove" is in the contact list
    When I swipe the contact person and click delete
    Then I should see the contact person is deleted
    And I go back to previous page
    And I click done to close messages
    And I logout