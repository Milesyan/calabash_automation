@premium @opt-in
Feature: Start chat requst with others. 

  @opt-in_setting @restart
  Scenario: Enter setting page in chat request.
    Given A premium user sent chat request to a new user "Albert"
    And I login as the new user
    When I open "alert" page
    Then I check the chat request is received 
    Then I click settings in chat request page and see edit profile page
    And I go back to forum page from forum profile page
    And I go back to previous page from chat request page
    And I logout

  @opt-in_profile @p0
  Scenario: Check the profile photo is clickable in chat request dialog.
    Given A premium user sent chat request to a new user "Albert"
    And I login as the new user
    When I open "alert" page
    Then I check the chat request is received 
    Then I click the requestor's profile photo to see the profile page
    And I go back to forum page from forum profile page
    And I go back to previous page from chat request page
    And I logout