@premium @badge
Feature: Check badge for Premium/Non-premium users
  @self_badge
  Scenario: Check badge in user's own profile page
    Given I create a new premium user with name "MilesPremium"
    And I login as the new user "MilesPremium" created through www
    And I open "community" page
    Then I go to community profile page
    Then I check the badge on the profile page exists
    And I go back to forum page from forum profile page
    And I logout

  @others_badge
  Scenario: Check badge in other users profile page
    Given I create a new premium user with name "MilesPremium"
    Then I create another premium user "Charlotte" and create a topic in the test group
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    And I open the topic "Test follow/block user"
    And I click the name of the creator "Charlotte" and enter the user's profile page
    Then I check the badge on the profile page exists
    And I go back to forum page from forum profile page
    And I go back to group
    And I logout
