@forum @profile
Feature: check user profile (4m8.459s 3 scenarios 30 steps)
  @edit_profile 
  Scenario: User edit profile info.
    Given I create a new eve user with name "Miles"
    And I login as the new user "Miles" created through www
    And I open "community" page
    Then I go to community profile page
    And I click edit profile button
    Then I edit some field in profile page
    Then I go back to user profile page and check the changes in profile page
    And I go back to forum page from forum profile page
    And I logout

  @check_groups_followers_following
  Scenario: User checks groups,followers,following page.
    Given I create a new eve user with name "Miles"
    Then I follow another user "Charlotte" and the user also follows me
    And I login as the new user "Miles" created through www
    And I open "community" page
    Then I go to community profile page
    Then I check "groups" under forum profile page and exit the page
    And I check "followers" under forum profile page and exit the page
    And I check "following" under forum profile page and exit the page
    And I go back to forum page from forum profile page
    And I logout

  @check_tabs
  Scenario: User checks participated, created, bookmarked page.
    Given I create a new eve user with name "Charles"
    And "Charles" create 1 topics and 10 comments and 0 subreply for each comment
    Then the user bookmarked the topic
    And I login as the new user "Miles" created through www
    And I open "community" page
    Then I go to community profile page
    Then I check "participated" under forum profile page and exit the page
    And I check "created" under forum profile page and exit the page
    And I check "bookmarked" under forum profile page and exit the page
    And I go back to forum page from forum profile page
    And I logout