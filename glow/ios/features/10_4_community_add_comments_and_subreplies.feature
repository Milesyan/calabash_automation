@forum @comment_reply
Feature: User add comments and subreplies
  @add_comment  
  Scenario: User create a text topic and add comment
    Given I create a new "ttc" glow user with name "Miles"
    And "Miles" create a "poll" topic in the test group
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    And I open the topic "create poll by www api"
    Then I add a comment
    Then I go to group page in topic "create poll by www api"
    And I logout

  @add_reply  
  Scenario: User create a text topic and add comment 
    Given I create a new "ttc" glow user with name "Miles"
    And "Miles" create a "text" topic in the test group
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    And I open the topic "create topic by www api"
    Then I add a comment
    Then I add a reply
    Then I go to group page in topic "create topic by www api"
    And I logout

  @add_image_comment
  Scenario: User create a text topic and add an image comment
    Given I create a new "ttc" glow user with name "Miles"
    And "Miles" create a "text" topic in the test group
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    And I open the topic "create topic by www api"
    Then I add an image comment
    Then I go to group page in topic "create topic by www api"
    And I logout