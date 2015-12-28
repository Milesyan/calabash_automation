@forum @load_more
Feature: Load more topics and comments (4m41.797s 3 scenarios 29 steps)
  @load_topics  
  Scenario: User create 20+ topics @load_topics 
    Given I create a new "non-ttc" glow user with name "Miles"
    Then "Miles" create 30 topics
    Then I login as the new user created through www
    And I open "community" page
    And I go to the first group
    Then I scroll "down" to see "Test load more topic 10"
    Then I logout


  @load_comments  
  Scenario: User create a topic and 30+ comments @load_comments 
    Given I create a new "non-ttc" glow user with name "Miles"
    Then "Miles" create 1 topics
    Then "Miles" add 50 comments and "Charlotte" added 2 subreplies to each comment.
    Then I login as the new user created through www
    And I open "community" page
    And I go to the first group
    Then I open the topic "Test load more topic 1"
    And I expand all the comments
    Then I scroll "down" to see "content number 30"
    And I go back to group
    Then I logout

  @load_subreplies  
  Scenario: User create a topic and 30+ comments @load_subreplies  
    Given I create a new "non-ttc" glow user with name "Miles"
    Then "Miles" create 1 topics
    Then "Miles" add 2 comments and "Charlotte" added 100 subreplies to each comment.
    Then I login as the new user created through www
    And I open "community" page
    And I go to the first group
    Then I open the topic "Test load more topic 1"
    And I click view all replies
    Then I scroll "up" to see "subreply number 70"
    Then I go to group page in topic "Test load more topic 1"
    Then I logout