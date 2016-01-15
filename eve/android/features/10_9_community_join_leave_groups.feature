@forum_n @group
Feature: create/join/leave group 

  Scenario: User create a group.
    Given I create a new glow forum user with name "Julie"
    Then "Julie" reply to 3 topics created by others 
    And I login as the new user "Julie" created through www
    And I open "community" page 
    Then I click the DISCOVER button in community tab
    And I click create a group
    Then I create a group
    And I logout

  @create_group_unable
  Scenario: User create a group.
    Given I create a new glow forum user with name "Julie"
    Then "Julie" reply to 1 topics created by others 
    And I login as the new user "Julie" created through www
    And I open "community" page 
    Then I click the DISCOVER button in community tab
    And I click create a group
    Then I should see "before creating a group"
    And I logout

  @join_group
  Scenario: User join a group.
    # Given a user created a group in "Eve" category
    Given I create a new glow forum user with name "Rachel"
    And I login as the new user "Rachel" created through www
    And I open "community" page 
    Then I click the DISCOVER button in community tab
    And I click Explore button
    And I click "Tech Support" category
    Then I join the group "test v3.8"
    Then I check the floating button menu
    And I go back to previous page
    And I go back to previous page
    And I logout

  @leave_group
  Scenario: User leave a group.
    Given I create a new glow forum user with name "Miles"
    And I login as the new user "Miles" created through www
    And I open "community" page 
    And I go to group page through community settings
    Then I quit the group
    And I go back to previous page
    And I go back to previous page
    Then I should not see the group which I left
    And I logout


