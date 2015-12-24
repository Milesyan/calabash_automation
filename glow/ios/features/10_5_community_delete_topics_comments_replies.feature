@forum @forum_delete
Feature: User create a topic and delete it (5m8.716s 4 scenarios 43 steps)
  @delete_topic  
  Scenario: User create a text topic and delete it. @delete_topic 
    Given I create a new "ttc" glow user 
    And The user create a "text" topic in group "4"
    Then the user add 2 comments and user2 added 2 subreplies to each comment.
    Then I login as the new user or default user
    And I open "community" page
    Then I go to the first group
    Then I open the topic "create topic by www api"
    Then I delete the topic index 1
    Then I logout

  @delete_poll 
  Scenario: User create a poll topic and delete it. @delete_poll 
    Given I create a new "ttc" glow user 
    And The user create a "poll" topic in group "4"
    Then the user add 2 comments and user2 added 2 subreplies to each comment.
    Then I login as the new user or default user
    And I open "community" page
    Then I go to the first group
    Then I open the topic "create poll by www api"
    Then I scroll down
    Then I delete the topic index 1
    Then I logout

  @delete_comment  
  Scenario: User create a text topic and delete the comment. @delete_comment
    Given I create a new "ttc" glow user 
    And The user create a "text" topic in group "4"
    Then the user add 2 comments and user2 added 2 subreplies to each comment.
    Then I login as the new user or default user
    And I open "community" page
    Then I go to the first group
    Then I open the topic "create topic by www api"
    And I expand all the comments
    Then I delete the comment index 0
    Then I delete the comment index 0
    Then I go to group page in topic "create topic by www api"
    Then I logout

  @delete_reply  
  Scenario: User create a text topic and delete the subreply. @delete_reply 
    Given I create a new "ttc" glow user 
    And The user create a "text" topic in group "4"
    Then the user add 2 comments and user2 added 2 subreplies to each comment.
    Then I login as user2
    And I open "community" page
    Then I go to the first group
    Then I open the topic "create topic by www api"
    And I click view all replies
    Then I delete the comment index 0
    Then I delete the comment index 0
    Then I go to group page in topic "create topic by www api"
    Then I logout



