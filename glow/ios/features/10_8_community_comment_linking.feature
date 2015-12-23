@forum @comment_linking
Feature: Comment linking function 
	@group_commentlinking
	Scenario: User clicks a topic in normal group
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
	Scenario: User create 1 topic and some comments(comments number must > 1)
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
	Scenario: User clicks a notification to enter a topic
    Given I create a new "ttc" glow user 
    And The user create a "poll" topic in group "4"
    Then the user add 4 comments and user2 added 2 subreplies to each comment.
	  Then I login as the new user or default user
	  And I open "alert" page
