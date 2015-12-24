@forum @comment_reply
Feature: User add comments and subreplies
  @add_comment  
  Scenario: User create a text topic and add comment @add_comment 
    Given I create a new "ttc" glow user 
    And The user create a "text" topic in group "4"
    Then I login as the new user or default user
    And I open "community" page
    Then I go to the first group
    Then I open the topic "create topic by www api"
    Then I add a comment
    Then I add a reply
    Then I go to group page in topic "create topic by www api"
    Then I logout

  @add_image_comment
  Scenario: User create a text topic and add an image comment @add_image_comment
    Given I create a new "ttc" glow user 
    And The user create a "text" topic in group "4"
    Then I login as the new user or default user
    And I open "community" page
    Then I go to the first group
    Then I open the topic "create topic by www api"
    Then I add an image comment
    Then I add a reply
    Then I go to group page in topic "create topic by www api"
    Then I logout