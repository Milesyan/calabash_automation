@premium @opt-in
Feature: Start chat requst with others. 

  @opt-in_setting
  Scenario: Enter setting page in chat request.
    Given A premium user miles2 sent chat request to a new user "Albert"
    And I login as the new user
    When I open "alert" page
    Then I check the chat request is received 
    Then I click settings in chat request page and see edit profile page
    And I go back to forum page from forum profile page
    And I go back to previous page from chat request page
    And I go back to community page
    And I logout
