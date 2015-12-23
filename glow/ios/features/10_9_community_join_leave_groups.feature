@forum @group
Feature: create/join/leave group
	@create_group
	Scenario: User create a group
		Given I create a new "ttc" glow user
		Then the user create 1 topic and 15 comments and 0 subreply for each comment		
		Then the user 
		
	@join_group
	Scenario: User join a group
		Then I logout

	@leave_group
	Scenario: User leave a group
		Then I logout


