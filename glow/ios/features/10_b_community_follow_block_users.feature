@forum @follow_block_user
Feature: user checks follow, unfollow, block and unblock. (6m4.146s 4 scenarios 62 steps)
	@follow_user
	Scenario: User follow another user	@follow_user
		Given I create a new "ttc" glow user
		Then I create another glow user and create a topic in group 4
		Then I login as the new user or default user
		And I open "community" page
    Then I go to the first group
    Then I open the topic "Test follow/block user"
    Then I click the name of the creator and enter the user's profile page
    Then I "follow" the user
		Then I go back to forum page from forum profile page
		And I go back to group
		Then I go to community profile page
		And I check "following" under forum profile page and exit the page
		Then I go back to forum page from forum profile page
		Then I logout

	@block_user
	Scenario: User block another user	@block_user
		Given I create a new "ttc" glow user
		Then I create another glow user and create a topic in group 4
		Then I login as the new user or default user
		And I open "community" page
    Then I go to the first group
    Then I open the topic "Test follow/block user"
    Then I click the name of the creator and enter the user's profile page
    Then I "block" the user
		Then I go back to forum page from forum profile page
		And I go back to group
		Then I go to community settings page
		And I go to blocked users part under community settings
		Then I can see the person I blocked
		Then I exit blocking users page
		And I click save of the community settings page
		Then I logout

	@unfollow_user
	Scenario: User follow a user and unfollow her @unfollow_user
		Given I create a new "ttc" glow user
		Then I follow another user and the user follows me
		Then I login as the new user or default user
		Then I open "community" page
		Then I go to community profile page
		And I open "following" under forum profile page
		Then I click the name of the creator and enter the user's profile page
    Then I "unfollow" the user
		Then I go back to forum page from forum profile page
    And I go back to previous page
		Then I go back to forum page from forum profile page
		Then I go to community profile page
		And I check "following" without seeing the user under forum profile page and exit the page
		Then I go back to forum page from forum profile page
		Then I logout


	@unblock_user
	Scenario: User block a user and unblock the user	@block_user
		Given I create a new "ttc" glow user
		Then I create another glow user and create a topic in group 4
		Then I login as the new user or default user
		And I open "community" page
    Then I go to the first group
    Then I open the topic "Test follow/block user"
    Then I click the name of the creator and enter the user's profile page
    Then I "block" the user
		Then I go back to forum page from forum profile page
		And I go back to group
		Then I go to community settings page
		And I go to blocked users part under community settings
		Then I can see the person I blocked
		Then I "unblock" the user
		Then I exit blocking users page
		And I click save of the community settings page
		Then I logout