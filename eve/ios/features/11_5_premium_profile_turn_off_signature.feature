@premium @turn_off_signature
Feature: Turn off signature and check it in posts

  @self_turn_off_signature
  Scenario: User turn off signature and cannot see signature in posts
    Given A premium user miles2 and a non-premium user milesn have been created for test
    And "Miles2" create 1 topic and 2 comments and 3 subreplies for each comment
    And premium user miles2 turns off signature
    And I login as the premium user
    And I open "community" page
    And I go to the first group
    When I enter topic created in previous step
    Then I should not see the signature in topic/comment/subreply
    When I expand all the comments
    Then I should not see the signature in topic/comment/subreply
    When I click view all replies
    Then I should not see the signature in topic/comment/subreply
    And I go back to group
    And I go back to previous page
    And I logout

  @profile_flags
  Scenario: User turn off signature and cannot see signature in posts
    Given A premium user miles2 and a non-premium user milesn have been created for test
    And I login as the premium user and reset all the flags under profile page
    And I open "community" page
    And I go to community profile page
    And I click edit profile button
    Then I turn on all the flags 
    And I go back to user profile page
    When I click edit profile button
    Then I check all the flags are turned on
    And I go back to user profile page
    And I go back to previous page
    And I logout
