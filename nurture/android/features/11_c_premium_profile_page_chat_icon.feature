@premium @chat_icon
Feature: Check chat icon for users.
  @self_chat_icon
  Scenario: Check chat icon in user's own profile page
    Given I create a new premium user with name "MilesPremium"
    And I login as the new user "MilesPremium" created through www
    And I open "community" page
    And I go to community profile page
    Then I check that chat icon does not exist
    And I go back to forum page from forum profile page
    And I logout

  @others_chat_icon
  Scenario: Check chat icon in other users profile page
    Given I create a new premium user with name "MilesPremium"
    Then I create another premium user "Charlotte" and create a topic in the test group
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    And I open the topic "Test premium"
    And I click the name of the creator "Charlotte" and enter the user's profile page
    Then I check that the chat icon exists
    Then I click the chat icon and see the chat window
    And I go back to forum page from forum profile page
    And I go back to previous page
    And I logout
