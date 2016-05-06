@premium @turn_off_signature
Feature: Turn off signature and check it in posts

  @self_turn_off_signature
  Scenario: User turn off signature and cannot see signature in posts
    Given A premium user and a non-premium user have been created for test
    And "MilesPremium" create 1 topic and 10 comments and 3 subreplies for each comment
    And premium user turns off signature
    And I login as the premium user
    And I open "community" page
    And I go to the first group
    And I enter topic created in previous step
    Then I should not see the signature in topic/comment/subreply
    And I expand all the comments
    Then I should not see the signature in topic/comment/subreply
    And I click view all replies
    Then I should not see the signature in topic/comment/subreply
    And I go back to previous page
    And I go back to group
    And I logout

  @profile_flags @p0
  Scenario: User turn off signature and cannot see signature in posts
    Given A premium user and a non-premium user have been created for test
    And I login as the premium user and reset all the flags under profile page
    And I open "community" page
    And I go to community profile page
    And I click edit profile button
    Then I turn on all the flags 
    And I click save button
    When I click edit profile button
    Then I check all the flags are turned on
    And I go back to user profile page
    And I go back to previous page
    And I logout