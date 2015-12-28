@forum @group
Feature: create/join/leave group (3m24.806s 3 scenarios 18 steps)
	@create_group
	Scenario: User create a group	@create_group
		Given I create a new "ttc" glow user with name "Julie"
		Then "Julie" create 1 topics and 20 comments and 0 subreply for each comment	
		Then I login as the new user created through www
		And I open "community" page	
		Then I click the plus button in community tab
		Then I logout

	@join_group
	Scenario: User join a group	@join_group
		Given I create a new "ttc" glow user with name "Rachel"
		Then I login as the new user created through www
		And I open "community" page	
		Then I click the plus button in community tab
		Then I join the group "test0000"
		Then I logout

	@leave_group
	Scenario: User leave a group	@leave_group
		Given I create a new "ttc" glow user
		Then I login as the new user created through www
		And I open "community" page	
		Then I long press group "target group"
		Then I quit the group
		Then I logout


