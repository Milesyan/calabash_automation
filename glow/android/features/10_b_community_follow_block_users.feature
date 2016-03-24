@forum @follow_block_user
Feature: user checks follow, unfollow, block and unblock. (6m4.146s 4 scenarios 62 steps)
  @follow_user
  Scenario: User follow another user.
    Given an existing glow user "Charlotte" has created a topic in the test group
    Given I create a new forum user with name "Miles"
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    And I open the topic "Test follow/block user"
    And I click the name of the creator "Charlotte" and enter the user's profile page
    Then I "follow" the user
    And I go back to forum page from forum profile page
    And I go back to group
    Then I go to community profile page
    And I check "following" under forum profile page and exit the page
    And I go back to forum page from forum profile page
    And I logout

  @block_user
  Scenario: User block another user.
    Given an existing glow user "Charlotte" has created a topic in the test group
    Given I create a new forum user with name "Miles"
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    And I open the topic "Test follow/block user"
    And I click the name of the creator "Charlotte" and enter the user's profile page
    Then I "block" the user
    And I go back to forum page from forum profile page
    And I go back to group
    Then I go to community settings page
    And I go to blocked users part under community settings
    Then I can see the person I blocked
    Then I exit blocking users page
    And I click back button in the community settings page
    And I logout

  @unfollow_user
  Scenario: User follow a user and unfollow her.
    Given an existing glow user "Charlotte" has created a topic in the test group
    Given I create a new forum user with name "Miles"
    Then I follow another user "Charlotte" and the user also follows me
    And I login as the new user "Miles" created through www
    And I open "community" page
    Then I go to community profile page
    And I open "following" under forum profile page
    Then I "unfollow" the user
    And I go back to previous page
    And I go back to forum page from forum profile page
    Then I go to community profile page
    And I check "following" without seeing the user under forum profile page and exit the page
    And I logout


  @unblock_user
  Scenario: User block a user and unblock the user.
    Given an existing glow user "Charlotte" has created a topic in the test group
    Given I create a new forum user with name "Miles"
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    And I open the topic "Test follow/block user"
    And I click the name of the creator "Charlotte" and enter the user's profile page
    Then I "block" the user
    And I go back to forum page from forum profile page
    And I go back to group
    Then I go to community settings page
    And I go to blocked users part under community settings
    Then I can see the person I blocked
    Then I "unblock" the user
    Then I exit blocking users page
    And I click back button in the community settings page
    And I logout