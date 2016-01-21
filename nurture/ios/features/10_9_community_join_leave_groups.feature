@forum @group
Feature: create/join/leave group
  @create_group_able
  Scenario: User create a group with more than 15+ comments
    Given I create a new nurture user with name "Julie"
    Then "Julie" reply to 3 topics created by others 
    And I login as the new user "Julie" created through www
    And I open "community" page 
    Then I click the DISCOVER button in community tab
    And I click create a group
    Then I create a group
    Then I should see the group name which I created
    And I go back to previous page
    And I logout

  @create_group_unable
  Scenario: User create a group but failed because of not enough comments
    Given I create a new nurture user with name "Julie"
    Then "Julie" reply to 1 topics created by others 
    And I login as the new user "Julie" created through www
    And I open "community" page 
    Then I click the DISCOVER button in community tab
    And I click create a group
    Then I should see "Create my own group"
    And I logout

  @join_group
  Scenario: User join a group.
    # Given a user created a group in "Eve" category
    Given I create a new nurture user with name "Rachel"
    And I login as the new user "Rachel" created through www
    And I open "community" page 
    Then I click the DISCOVER button in community tab
    And I click Explore button
    And I click "Tech Support" category
    Then I join the group "Glow Support"
    Then I check the button in the group
    And I go back to previous page
    And I go back to previous page
    And I logout


  @leave_group
  Scenario: User leave a group.
    Given I create a new nurture user with name "Miles"
    And I login as the new user "Miles" created through www
    And I open "community" page 
    Then I long press group "1st Child"
    Then I quit the group
    And I logout


