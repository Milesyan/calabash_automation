@forum @hide_report
Feature: Test hide/report topic/comment (4m40.131s 4 scenarios 38 steps)
	@hide_topic
	Scenario: User create a topic and hide it.
		Given I create a new noah user with name "Miles"
		And another user "Charlotte" create 1 topic and 2 comments and 3 subreplies for each comment
		And I login as the new user "Miles" created through www
		And I open "community" page
		And I go to the first group
		And I enter topic created by another user
		Then I hide the topic
		Then I should not see the topic hidden by me
		And I logout

	@report_topic
	Scenario: User create a topic and hide it @report_topic
		Given I create a new noah user with name "Miles"
		And another user "Charlotte" create 1 topic and 1 comment and 1 subreply for each comment
		And I login as the new user "Miles" created through www
		And I open "community" page
		And I go to the first group
		And I enter topic created by another user
		Then I report the topic by reason "Wrong group"
		# Then I report the topic by reason "Spam"
		Then I should not see the topic hidden by me
		And I logout

	@hide_comment
	Scenario: User create a topic and hide it @hide_comment
		Given I create a new noah user with name "Miles"
		And another user "Charlotte" create 1 topic and 1 comment and 1 subreply for each comment
		And I login as the new user "Miles" created through www
		And I open "community" page
		And I go to the first group
		And I enter topic created by another user
		Then I hide the comment
		Then I should not see the comment hidden by me
		Then I go back to previous page
		And I logout

	@report_comment
	Scenario: User create a topic and hide it @report_comment
		Given I create a new noah user with name "Miles"
		And another user "Charlotte" create 1 topic and 1 comment and 1 subreply for each comment
		And I login as the new user "Miles" created through www
		And I open "community" page
		And I go to the first group
		And I enter topic created by another user
		Then I report the comment by reason "Spam"
		# Then I report the topic by reason "Spam"
		Then I should not see the comment hidden by me
		Then I go back to previous page
		And I logout