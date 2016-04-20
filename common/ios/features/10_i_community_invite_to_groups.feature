@forum @invite
Feature: legacy and new invite users to group flow
  @new_invite @p0
  Scenario: Invite other users to a group in new group banner
    Given I create a new forum user with name "Miles" and join group 1340
    Then I follow another user "Elsa" and the user also follows me
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the invite target group
    Then I invite the user to this group
    And I logout
    And I login as "Elsa"
    And I open "community" page
    And I open "alert" page
    Then I click the button to join the group
    And I close the group page
    And I logout
