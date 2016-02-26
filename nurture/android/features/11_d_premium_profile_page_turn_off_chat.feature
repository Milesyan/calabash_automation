@premium @turn_off_chat
Feature: Turn off chat and check chat icons and chat section.

  @self_turn_off_chat
  Scenario: User turn off chat and cannot see chat icon in other users' profile page.
    Given I create a new premium user with name "MilesPremium"
    Then I turn off chat in profile settings
    Then I create another premium user "Charlotte" and create a topic in the test group
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    And I open the topic "Test premium"
    And I click the name of the creator "Charlotte" and enter the user's profile page
    Then I check that the chat icon does not exist
    And I go back to forum page from forum profile page
    And I go back to group
    And I logout

  @others_turn_off_chat
  Scenario: Other users turn off chat and I cannot see the Chat icon.
    Given I create a new premium user with name "MilesPremium"
    Then I create another premium user "Charlotte" and create a topic in the test group and turn off chat in profile page
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    And I open the topic "Test premium"
    And I click the name of the creator "Charlotte" and enter the user's profile page
    Then I check that the chat icon does not exist
    And I go back to forum page from forum profile page
    And I go back to group
    And I logout

  @chat_section
  Scenario: Check chat icon in other users profile page
    Given I create a new premium user with name "MilesPremium"
    Then I turn off chat in profile settings
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to discover tab
    Then I check that the chat section does not exist on the first page
    And I logout