@premium @signature_actions
Feature: Check actions when user clicks elements in signature.
  @signature_actions
  Scenario: Check actions when click chat and signature area.
    Given A premium user and a non-premium user have been created for test
    And I create another non-premium user "Charlotte" and create a topic in the test group with topic name "Test signature chat"
    And I login as premium user
    And I open "community" page
    And I go to the first group
    And I open the topic "Test signature chat"
    When I click the chat icon and see the chat window
    Then I should see the send request dialog
    And I click send request button
    Then I click the areas in signature
    Then I should go to profile page 
    And I go back to forum page from forum profile page
    And I go back to group
    And I logout
