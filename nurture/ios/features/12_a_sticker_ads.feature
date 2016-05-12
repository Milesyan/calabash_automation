@not_ready
Feature: Check ads in community.
  Scenario: Community discover ads.
    Given I create a new forum user with name "Miles"
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I click the DISCOVER button in community tab
    Then I swipe the banner and click sticker ads
    And I logout
