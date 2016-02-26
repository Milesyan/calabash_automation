@premium @url
Feature: Check badge for Premium/Non-premium users
  @self_url
  Scenario: Check url in user's own profile page
    Given I create a new premium user with name "MilesPremium"
    And I login as the new user "MilesPremium" created through www
    And I open "community" page
    Then I go to community profile page
    And I click edit profile button
    Then I input URL in edit profile page
    And I go back to user profile page 
    Then I click the url and check the link works
    Then I go back to previous page from the pop-up web page
    And I go back to forum page from forum profile page
    And I logout

  @others_url
  Scenario: Check url in other users profile page
    Given I create a new premium user with name "MilesPremium"
    Then I create another premium user "Charlotte" and create a topic in the test group and update url in profile page
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    And I open the topic "Test premium"
    And I click the name of the creator "Charlotte" and enter the user's profile page
    Then I click the url and check the link works
    And I go back to forum page from forum profile page
    And I logout
    