@premium @forum_relation
Feature: Check chat relationship and forum relationship.
	@request_follow
	Scenario: Send a chat request will automatically follow the user

	@accept_follow
	Scenario: Accept chat request will automatically follow back

	@delete_unfollow
	Scenario: Delete a contact person will automatically unfollow her/him.

	@block_black_list
	Scenario: Block a person will automatically put her/him in the forum blocked list.