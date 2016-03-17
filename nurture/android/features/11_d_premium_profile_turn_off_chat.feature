@premium @turn_off_chat
Feature: Turn off chat and check chat icons and chat section.

  @self_turn_off_chat
  Scenario: User turn off chat and cannot see chat icon in other users' profile page.
    Given A premium user milesp and a non-premium user milesn have been created for test
    And I create another non-premium user "Rabbit" and create a topic in the test group with topic name "Test self chat off"
    And I login as premium user and turn off chat
    And I open "community" page
    And I go to the first group
    And I open the topic "Test self chat off"
    And I enter new user's profile
    Then I check that the chat requst failed to be sent
    And I go back to forum page from forum profile page
    And I go back to group
    And I logout

  @others_turn_off_chat
  Scenario: Other users turn off chat and I cannot see the Chat icon.
    Given A premium user milesp and a non-premium user milesn have been created for test
    Then I create another non-premium user "Bigbang" and create a topic in the test group with topic name "Test chat off" and the user turns chat off
    And I login as premium user
    And I open "community" page
    And I go to the first group
    And I open the topic "Test chat off"
    When I enter new user's profile
    Then I check that the chat icon does not exist
    And I go back to forum page from forum profile page
    And I go back to group
    And I logout

  # @chat_section
  # Scenario: Check chat icon in other users profile page
  #   Given A premium user milesp and a non-premium user milesn have been created for test
  #   Then I turn off chat in profile settings
  #   And I login as the new user "Miles" created through www
  #   And I open "community" page
  #   And I go to discover tab
  #   Then I check that the chat section does not exist on the first page
  #   And I logout