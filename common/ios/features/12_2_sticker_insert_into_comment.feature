@not_ready
Feature: Users insert sticker in comments
  Scenario: User insert in a normal comment and only can insert 1 sticker
    Given I create a new forum user with name "Miles"
    And "Miles" create topic with name "Test sticker in comment"
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    And I enter the topic "Test sticker in comment"
    When I add a comment with sticker
    Then I should not add another sticker
    Then I should see the sticker is added into the topic successfully
    And I go back to previous page
    And I logout

  Scenario: User insert sticker in a comment with photo 
    Given I create a new forum user with name "Miles"
    And "Miles" create topic with name "Test sticker in comment"
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    And I enter the topic "Test sticker in comment"
    When I add a comment with an image and  sticker
    Then I should see the sticker is added into the topic successfully
    And I go back to previous page
    And I logout

  Scenario: User cannot insert sticker in a reply
    Given I create a new forum user with name "Miles"
    And "Miles" create a "text" topic in the test group
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    And I open the topic "create topic by www api"
    Then I add a comment
    When I try to add a reply
    Then I should see I cannot add sticker
    And I go to previous page
    And I go to previous page
    And I logout

