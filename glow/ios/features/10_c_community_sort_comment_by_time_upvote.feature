@forum @order_by
Feature: Test order by time and order by upvote (1m40.347s 1 scenario 21 steps)
	Scenario: User create a topic and switch between order by time and upvote @order_by
		Given I create a new "ttc" glow user
		And the user create 1 topics and 10 comments and 3 subreply for each comment
		And the user upvote the first comment
		Then I login as the new user or default user
		And I open "community" page
		Then I go to the first group
		Then I enter topic created in previous step
		Then I should see "Show entire discussion"
		And I should see the last comment
		Then I expand all the comments
		Then I click the hyperlink of comments
		Then I should see "✓ Sort by Upvotes"
		And I should see "Sort by Time"
		And I should see "Cancel"
		Then I touch "Sort by Time"
		Then I should see "Test search comment 10"
		Then I click the hyperlink of comments
		Then I touch "Sort by Upvotes"
		Then I should see "Test search comment 1"
		Then I go back to group
    Then I logout
