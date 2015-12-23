@forum @profile
Feature: check user profile
	@edit_profile
	Scenario: User create a group
		Given I create a new "ttc" glow user
		Then I login as the new user or default user
		And I open "community" page
		Then I go to community profile page
		And I click edit profile button
		Then I edit some field in profile page
		Then I logout

