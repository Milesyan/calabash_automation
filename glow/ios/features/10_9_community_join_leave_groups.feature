@forum @group
Feature: create/join/leave group
	@create_group
	Scenario: User create a group
		Then I logout
		
	@join_group
	Scenario: User join a group
		Then I logout

	@leave_group
	Scenario: User leave a group
		Then I logout


