@premium @contact_page
Feature: Check contact page features.

  @follow_contact @restart
  Scenario: The followed people should appear in the contact list
    Given I create a new forum user with name "Legend"
    Then I follow another user "Friend" and the user also follows me
    And I login as the new user "Legend" created through www
    And I open "community" page
    And I go to messages
    When I go to contact list
    Then I should see the user "Friend" is in the contact list
    And I should see the lock icon after the user's name
    When I click the name of user "Friend"
    Then I should see the prompt premium dialog
    And I close the request dialog
    And I go back to previous page
    And I click done to close messages
    And I logout

  @start_chat
  Scenario: Click name of people with chat relationship established will go to chat window.
    Given A premium user established chat relationship with a new user "Holmes"
    And I login as premium user
    And I open "community" page
    And I go to messages 
    When I go to contact list    
    And I click the name of user "Holmes"
    Then I send a message with text "test start chat from contact"
    And I go back to previous page
    And I go back to previous page
    And I click done to close messages
    And I logout