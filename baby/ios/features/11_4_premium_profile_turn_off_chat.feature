@premium @turn_off_chat
Feature: Turn off chat and check chat icons and chat section.

  @self_turn_off_chat
  Scenario: User turn off chat and cannot see chat icon in other users' profile page.
    Given A premium user miles3 and a non-premium user milesn have been created for test
    And I create another non-premium user "Rabbit" and create a topic in the test group with topic name "Test self chat off"
    And I login as premium user and turn off chat
    And I open "community" page
    And I go to the first group
    And I open the topic "Test self chat off"
    Then I check that the chat requst failed to be sent
    And I enter new user's profile
    Then I check that the chat requst failed to be sent
    And I go back to forum page from forum profile page
    And I go back to group
    And I logout

  @others_turn_off_chat @p0
  Scenario: Other users turn off chat and I cannot see the Chat icon.
    Given A premium user miles3 and a non-premium user milesn have been created for test
    Then I create another non-premium user "Bigbang" and create a topic in the test group with topic name "Test chat off" and the user turns chat off
    And I login as premium user
    And I open "community" page
    And I go to the first group
    And I open the topic "Test chat off"
    Then I check that the chat icon does not exist
    When I enter new user's profile
    Then I check that the chat icon does not exist
    And I go back to forum page from forum profile page
    And I go back to group
    And I logout

  @chat_off_p2np
  Scenario: Check premium see non-premium user's topic with chat off
    Given A premium user miles3 and a non-premium user milesn have been created for test
    And a new user "FreeUser" creates 1 topic with name "chat off p2np" and 1 comment and 1 subreply for each comment with chat off
    And I login as the premium user
    And I open "community" page
    And I go to the first group
    And I enter the topic "chat off p2np" 
    Then I checked all the touch points for "chat off premium" 
    And I go back to previous page
    And I logout

  @chat_off_np2np
  Scenario: Check non-premium see non-premium user's topic with chat off
    Given A premium user miles3 and a non-premium user milesn have been created for test
    And a new user "Emma" creates 1 topic with name "chat off np2np" and 1 comment and 1 subreply for each comment with chat off
    And I login as the non-premium user
    And I open "community" page
    And I go to the first group
    And I enter the topic "chat off np2np" 
    Then I checked all the touch points for "chat off non-premium" 
    And I go back to previous page
    And I logout
