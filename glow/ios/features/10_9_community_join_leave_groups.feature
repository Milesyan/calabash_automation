@forum @group
Feature: create/join/leave group
	@create_group
	Scenario: User create a group
		Given I create a new "ttc" glow user
		Then the user create 1 topics and 20 comments and 0 subreply for each comment	
		And I open "community" page	
		Then I click the plus button in community tab
		Then I click Create a group
		Then I create a group

	@join_group
	Scenario: User join a group
		Given I create a new "ttc" glow user
		Then I login as the new user or default user
		And I open "community" page	
		Then I click the plus button in community tab
		Then I join the group "test0000"
		Then I logout

	@leave_group
	Scenario: User leave a group
		Given I create a new "ttc" glow user
		Then I login as the new user or default user
		And I open "community" page	
		Then I long press group "target group"
		Then I quit the group
		Then I logout


