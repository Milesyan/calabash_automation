@forum @forum_delete
Feature: User create a topic and delete it (5m8.716s 4 scenarios 43 steps)
  @delete_topic  
  Scenario: User create a text topic and delete it. @delete_topic 
    Given I create a new noah user with name "Miles"
    And "Miles" create a "text" topic in the test group
    And "Miles" add 2 comments and "Charlotte" added 2 subreplies to each comment.
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    And I open the topic "create topic by www api"
    Then I delete the topic with 1 visible comment
    And I logout

  @delete_poll 
  Scenario: User create a poll topic and delete it. @delete_poll 
    Given I create a new noah user with name "Miles"
    And "Miles" create a "poll" topic in the test group
    And "Miles" add 2 comments and "Charlotte" added 2 subreplies to each comment.
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    And I open the topic "create poll by www api"
    And I scroll down
    Then I delete the topic with 1 visible comment
    And I logout

  @delete_comment  
  Scenario: User create a text topic and delete the comment. @delete_comment
    Given I create a new noah user with name "Miles"
    And "Miles" create a "text" topic in the test group
    And "Miles" add 2 comments and "Charlotte" added 2 subreplies to each comment.
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    And I open the topic "create topic by www api"
    And I expand all the comments
    Then I delete the comment index 0
    Then I delete the comment index 0
    Then I go to group page in topic "create topic by www api"
    And I logout

  @delete_reply  
  Scenario: User create a text topic and delete the subreply. @delete_reply 
    Given I create a new noah user with name "Miles"
    And "Miles" create a "text" topic in the test group
    And "Miles" add 2 comments and "Charlotte" added 2 subreplies to each comment.
    Then I login as "Charlotte"
    And I open "community" page
    And I go to the first group
    And I open the topic "create topic by www api"
    And I click view all replies
    Then I delete the comment index 0
    # Then I delete the comment index 0
    Then I go to group page in topic "create topic by www api"
    And I logout



