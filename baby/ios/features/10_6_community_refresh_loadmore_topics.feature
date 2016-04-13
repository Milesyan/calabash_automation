@forum @load_more
Feature: Load more topics and comments.
  @load_topics  
  Scenario: User create 20+ topics.
    Given I create a new forum user with name "Miles"
    And "Miles" create 30 topics
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    Then I scroll "down" to see "Test load more topic 30"
    And I logout


  @load_comments  
  Scenario: User create a topic and 30+ comments.
    Given I create a new forum user with name "Miles"
    And "Miles" create 1 topics
    And "Miles" add 30 comments and "Charlotte" added 2 subreplies to each comment.
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    And I open the topic "Test load more topic 1"
    And I expand all the comments
    Then I scroll "down" to see "content number 1"
    And I go back to group
    And I logout

  @load_subreplies  
  Scenario: User create a topic and 30+ comments.
    Given I create a new forum user with name "Miles"
    And "Miles" create 1 topics
    And "Miles" add 1 comments and "Charlotte" added 30 subreplies to each comment.
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    And I open the topic "Test load more topic 1"
    And I click view all replies
    Then I scroll "up" to see "subreply number 1"
    And I go back to previous page
    And I go back to previous page
    And I logout