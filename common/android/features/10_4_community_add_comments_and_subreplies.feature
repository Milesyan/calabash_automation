@forum @comment_reply
Feature: User add comments and subreplies (3m16.685s 2 scenarios 20 steps)
  @add_comment @p0
  Scenario: User create a text topic and add comment @add_comment 
    Given I create a new forum user with name "Miles"
    And "Miles" create a "text" topic in the test group
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    And I open the topic "create topic by www api"
    Then I add a comment
    Then I add a reply
    And I go back to previous page
    And I go back to previous page
    And I logout
    
  @add_comment_poll
  Scenario: User create a text topic and add comment @add_comment 
    Given I create a new forum user with name "Miles"
    And "Miles" create a "poll" topic in the test group
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    And I open the topic "create poll by www api"
    Then I add a comment
    Then I add a reply
    And I go back to previous page
    And I go back to previous page
    And I logout

  @add_reply @p0
  Scenario: User create a text topic and add reply
    Given I create a new forum user with name "Miles"
    And "Miles" create a "photo" topic in the test group
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    And I open the topic "create photo by www api"
    Then I add a comment
    Then I add a reply
    And I go back to previous page
    And I go back to previous page
    And I logout
  # @add_image_comment
  # Scenario: User create a text topic and add an image comment @add_image_comment
  #   Given I create a new forum user with name "Miles"
  #   And "Miles" create a "text" topic in the test group
  #   And I login as the new user "Miles" created through www
  #   And I open "community" page
  #   And I go to the first group
  #   And I open the topic "create topic by www api"
  #   Then I add an image comment
  #   Then I add a reply
  #   And I go back to previous page
  #   And I logout