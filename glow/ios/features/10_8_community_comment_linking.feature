@forum @comment_linking
Feature: Comment linking function (3m47.074s 3 scenarios 25 steps)
)	@group_commentlinking
	Scenario: User clicks a topic in normal group @group_commentlinking
		Given I create a new "ttc" glow user
		And the user create 1 topics and 10 comments and 0 subreply for each comment
		Then I login as the new user or default user
		And I open "community" page
		Then I go to the first group
		Then I enter topic created in previous step
		Then I should see "Show entire discussion"
		And I should see the last comment
		Then I expand all the comments
		Then I go back to group
    Then I logout

	@search_commentlinking
	Scenario: User create 1 topic and some comments(comments number must > 1) 	@search_commentlinking
    Given I create a new "non-ttc" glow user 
    And the user create 1 topics and 10 comments and 0 subreply for each comment
    Then I login as the new user or default user
    And I open "community" page
    Then I go to search bar
    Then I click search for comment "Test search comment"
    Then I check the search result for comment "Test search comment"
    Then I return to group page from search result
    Then I logout


	@notification_commentlinking
	Scenario: User clicks a notification to enter a topic @notification_commentlinking
    Given I create a new "ttc" glow user 
    And The user create a "poll" topic in group "4"
    Then the user add 4 comments and user2 added 2 subreplies to each comment.
	  Then I login as the new user or default user
	  And I open "alert" page
	  Then I touch "Check it out" 
	  Then I should see "Show entire discussion"
		Then I expand all the comments
		Then I click the bookmark icon
		Then I click the close button and go back to previous page
    Then I logout
