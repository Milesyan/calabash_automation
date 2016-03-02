@premium @signature_actions
Feature: Check actions when user clicks elements in signature.
  @signature_actions
  Scenario: Check actions when click chat and signature area.
    Given I create a new premium user with name "MilesPremium"
    And "MilesPremium" create 1 topic and 1 comments and 0 subreplies for each comment
    And I login as premium user
    And I open "community" page
    And I enter topic created in previous step
    Then I click the chat icon and see the chat window
    And I go back to previous page
    Then I click the areas in signature
    Then I should go to profile page 
    And I go back to previous page
    And I go back to group
    And I logout
