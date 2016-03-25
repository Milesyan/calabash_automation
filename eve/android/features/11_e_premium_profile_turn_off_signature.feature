@premium @turn_off_signature
Feature: Turn off signature and check it in posts

  @self_turn_off_signature
  Scenario: User turn off signature and cannot see signature in posts
    Given A premium user milesp and a non-premium user milesn have been created for test
    And "MilesPremium" create 1 topic and 10 comments and 3 subreplies for each comment
    And premium user milesp turns off signature
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