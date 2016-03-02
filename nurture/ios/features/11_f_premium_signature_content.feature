@premium @signature_content
Feature: Check signature content for users.
  @signature_content
  Scenario: Check signature contents for users
    Given I create a new premium user with name "MilesPremium"
    And "MilesPremium" create 1 topic and 1 comments and 0 subreplies for each comment
    And I login as premium user
    And I open "community" page
    And I go to community profile page
    And I click edit profile button
    Then I update bio and location info
    And I go back to user profile page
    And I go back to forum page from forum profile page
    And I go to the first group
    And I enter topic created in previous step
    Then I checked the elements in a signature
    And I go back to group
    And I logout

