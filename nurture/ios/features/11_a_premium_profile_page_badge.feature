@premium @badge
Feature: Check badge for Premium/Non-premium users
  @self_badge
  Scenario: Check badge in user's own profile page
    Given A premium user miles2 and a non-premium user milesn have been created for test
    And I login as premium user
    And I open "community" page
    When I go to community profile page
    Then I check the badge on the profile page exists
    And I go back to forum page from forum profile page
    And I logout

  @others_badge
  Scenario: Check badge in other users profile page
    Given A premium user miles2 and a non-premium user milesn have been created for test
    And the premium user create a topic in the test group
    And I login as the non-premium user
    And I open "community" page
    And I go to the first group
    And I open the topic "Test premium"
    When I enter premium user's profile
    Then I check the badge on the profile page exists
    And I go back to forum page from forum profile page
    And I go back to previous page
    And I logout
