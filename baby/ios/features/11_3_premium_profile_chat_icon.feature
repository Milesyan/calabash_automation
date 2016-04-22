@premium @chat_icon
Feature: Check chat icon for users.
  @self_chat_icon @restart
  Scenario: Check chat icon in user's own profile page
    Given A premium user miles3 and a non-premium user milesn have been created for test
    And I login as premium user
    And I open "community" page
    And I go to community profile page
    Then I check that chat icon does not exist
    And I go back to forum page from forum profile page
    And I logout

  @p_others_chat_icon
  Scenario: Premium user check chat icon in other users profile page
    Given A premium user miles3 and a non-premium user milesn have been created for test
    Then the non-premium user create a topic in the test group
    And I login as the premium user
    And I open "community" page
    And I go to the first group
    And I open the topic "Test premium"
    When I enter non-premium user's profile
    Then I check that the chat icon exists
    When I click the chat icon and see the chat window
    Then I should see the send request dialog
    And I close the request dialog
    And I go back to forum page from forum profile page
    And I go back to previous page
    And I logout

  @np_others_chat_icon
  Scenario: Non-premium User check chat icon in other users profile page
    Given A premium user miles3 and a non-premium user milesn have been created for test
    Then I create another non-premium user "Snoopy" and create a topic in the test group with topic name "Test upgrade dialog"
    And I login as the non-premium user
    And I open "community" page
    And I go to the first group
    And I open the topic "Test upgrade dialog"
    When I enter new user's profile
    Then I check that the chat icon exists
    When I click the chat icon
    Then I should see the prompt premium dialog
    And I close the request dialog
    And I go back to forum page from forum profile page
    And I go back to previous page
    And I logout
