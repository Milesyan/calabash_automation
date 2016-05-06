@premium @url
Feature: Check url field for Premium/Non-premium users
  @self_url @p0 @restart_after
  Scenario: Check url in user's own profile page
    Given A premium user and a non-premium user have been created for test
    And I login as premium user
    And I open "community" page
    Then I go to community profile page
    And I click edit profile button
    Then I input URL in edit profile page
    And I click save button
    Then I click the url and check the link works
    And I go back to previous page from the pop-up web page
    And I go back to forum page from forum profile page
    And I logout
    And I login as premium user
    And I open "community" page
    When I go to community profile page
    Then I click the url and check the link works
    And I go back to previous page from the pop-up web page
    And I go back to forum page from forum profile page
    And I logout
       
  @others_url @restart_after
  Scenario: Check url not exist in non-premium users profile
    Given A premium user and a non-premium user have been created for test
    And I login as non-premium user
    And I open "community" page
    Then I go to community profile page
    When I click edit profile button
    Then I cannot see a url field in edit profile page
    And I go back to forum page from forum profile page
    And I go back to previous page
    And I logout

    