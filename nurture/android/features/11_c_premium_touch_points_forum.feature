@premium @premium_forum
Feature: Check all touch points in community.

  @topic_touch_points_p2np
  Scenario: Check chat touch points in topics for premium user to non-premium user
    Given A premium user milesp and a non-premium user milesn have been created for test
    And a new user "Emma" creates 1 topic with name "Test touch point p2np" and 1 comment and 1 subreply for each comment
    And I login as the premium user
    And I open "community" page
    And I go to the first group
    And I enter the topic "Test touch point p2np" 
    Then I checked all the touch points for "premium->non-premium" 
    And I go back to previous page
    And I logout

  @topic_touch_points_np2p
  Scenario: Check chat touch points in topics for non-premium user to premium user
    Given A premium user milesp and a non-premium user milesn have been created for test
    And the premium user milesp creates 1 topic with name "Test touch point np2p" and 1 comment and 1 subreply for each comment
    And A new user "Lucy" is created
    And I login as the new user
    And I open "community" page
    And I go to the first group
    And I enter the topic "Test touch point np2p" 
    Then I checked all the touch points for "non-premium->premium" 
    And I go back to previous page
    And I logout

  @topic_touch_points_np2np
  Scenario: Check chat touch points in topics for non-premium user to non-premium user
    Given A premium user milesp and a non-premium user milesn have been created for test
    And a new user "Carrie" creates 1 topic with name "Test touch point np2np" and 1 comment and 1 subreply for each comment
    And I login as the non-premium user
    And I open "community" page
    And I go to the first group
    And I enter the topic "Test touch point np2np" 
    Then I checked all the touch points for "non-premium->non-premium" 
    And I go back to previous page
    And I logout

  @topic_touch_points_existing
  Scenario: Check chat touch points in topics for existing chat relationship
    Given A premium user milesp and a non-premium user milesn have been created for test
    And a new user "Jesse" creates 1 topic with name "Test touch point existing" and 1 comment and 1 subreply for each comment
    And premium user milesp established chat relationship with the new user
    And I login as the premium user
    And I open "community" page
    And I go to the first group
    And I enter the topic "Test touch point existing" 
    Then I checked all the touch points for "existing relationship" 
    And I go back to previous page
    And I logout

