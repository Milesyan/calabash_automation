@forum @invite
Feature: legacy and new invite users to group flow
  @new_invite
  Scenario: Invite other users to a group in new group banner
    Given I create a new noah user with name "Miles" and join group 417
    Then I follow another user "Elsa" and the user also follows me
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    Then I invite the user to this group
    And I logout
    And I login as "Elsa"
    And I open "alert" page
    Then I click the button to join the group
    And I close the group page
    And I logout
