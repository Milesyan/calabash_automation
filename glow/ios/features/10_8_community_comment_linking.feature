@forum @comment_linking
Feature: Comment linking function
  @group_commentlinking
  Scenario: User clicks a topic in normal group.
    Given I create a new forum user with name "Miles"
    And "Miles" create 1 topic and 10 comments and 0 subreply for each comment
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    And I enter topic created in previous step
    Then I should see "Show entire discussion" in my view
    And I should see the last comment
    And I expand all the comments
    And I go back to group
    And I logout

  @search_commentlinking
  Scenario: User create 1 topic and some comments(comments number must > 1).
    Given I create a new forum user with name "Miles"
    And "Miles" create 1 topics and 10 comments and 0 subreply for each comment
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to search bar
    And I click search for comment
    Then I check the search result for comment
    And I return to group page from search result
    And I logout


  @notification_commentlinking
  Scenario: User clicks a notification to enter a topic.
    Given I create a new forum user with name "Miles"
    And "Miles" create a "poll" topic in the test group
    And "Miles" add 4 comments and "Charlotte" added 2 subreplies to each comment.
    And I login as the new user "Miles" created through www
    And I open "alert" page
    And I touch button containing text "Check it out!" 
    Then I should see "Show entire discussion" in my view
    And I expand all the comments
    Then I click the bookmark icon
    And I click the close button and go back to previous page
    And I logout
