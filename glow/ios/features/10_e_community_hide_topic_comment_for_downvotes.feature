@forum @hide_topic/comment_by_downvote
Feature: User downvote or flag topics to make it hidden (4m50.748s 4 scenarios 60 steps)
	@hidden_by_downvote_topic
	Scenario: User create a topic and other users downvote it to make it hidden @hidden_by_downvote_topic
		Given I create a new "ttc" glow user
		And the user create 1 topics and 10 comments and 3 subreply for each comment
		And 1 other users upvote the topic and 3 other users downvote the topic
		Then I login as the new user or default user
		And I open "community" page
		Then I go to the first group
		Then I should see "Content hidden due to low rating."
		Then I touch "View Rules"
		Then I should see "Community rules"
		Then I go to the first group
		Then I touch "Show Content"
		Then I enter topic created in previous step
		Then I should see "Show entire discussion"
		Then I go back to group
    Then I logout

	@hidden_by_report_topic
	Scenario: User create a topic and other users report it to make it hidden @hidden_by_report_topic
		Given I create a new "ttc" glow user
		And the user create 1 topics and 10 comments and 3 subreply for each comment
		And 3 other users reported the topic
		Then I login as the new user or default user
		And I open "community" page
		Then I go to the first group
		Then I should see "Content hidden due to low rating."
		Then I touch "View Rules"
		Then I should see "Community rules"
		Then I go to the first group
		Then I touch "Show Content"
		Then I enter topic created in previous step
		Then I should see "Show entire discussion"
		Then I go back to group
    Then I logout

  @hidden_by_downvote_comment
	Scenario: User create a comment and other users downvote it to make it hidden @hidden_by_downvote_comment 
		Given I create a new "ttc" glow user
		And the user create 1 topics and 1 comments and 3 subreply for each comment
		And 1 other users upvote the comment and 3 other users downvote the comment
		Then I login as the new user or default user
		And I open "community" page
		Then I go to the first group
		Then I enter topic created in previous step
		Then I should see "Content hidden due to low rating."
		Then I touch "View Rules"
		Then I should see "Community rules"
    And I go back to previous page
		Then I touch "Show Content"
		Then I should see "Test search comment 1"
		Then I go back to group
    Then I logout

	@hidden_by_report_comment
	Scenario: User create a comment and other users report it to make it hidden @hidden_by_report_comment
		Given I create a new "ttc" glow user
		And the user create 1 topics and 1 comments and 3 subreply for each comment
		And 3 other users reported the comment
		Then I login as the new user or default user
		And I open "community" page
		Then I go to the first group
		Then I enter topic created in previous step
		Then I should see "Content hidden due to low rating."
		Then I touch "View Rules"
		Then I should see "Community rules"
    And I go back to previous page
		Then I touch "Show Content"
		Then I should see "Test search comment 1"
		Then I go back to group
    Then I logout