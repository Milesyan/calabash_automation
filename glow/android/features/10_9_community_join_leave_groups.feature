@forum @group
Feature: create/join/leave group (3m24.806s 3 scenarios 18 steps)
  @create_group
  Scenario: User create a group.
    Given I create a new "ttc" glow user with name "Julie"
    Then "Julie" create 1 topics and 20 comments and 0 subreply for each comment  
    And I login as the new user "Julie" created through www
    And I open "community" page 
    Then I click the plus button in community tab
    And I click create a group
    And I logout

  @join_group
  Scenario: User join a group.
    Given I create a new "ttc" glow user with name "Rachel"
    And I login as the new user "Rachel" created through www
    And I open "community" page 
    Then I click the plus button in community tab
    Then I join the group "test0000"
    And I logout

  @leave_group
  Scenario: User leave a group.
    Given I create a new "ttc" glow user with name "Miles"
    And I login as the new user "Miles" created through www
    And I open "community" page 

#need to work here
    Then I quit the group
    And I logout


