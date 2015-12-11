@help_center
Feature: Help center on Me page
  Scenario: All screens in Help center should be loaded fine
    #Given I register a new "Non-TTC" user
    Given I create a new "Non-TTC" user
    And I login
    And I open "me" page
    And I open "Help center" on Me page
    Then "FAQ" screen in Help Center should be loaded fine
    And "Web" screen in Help Center should be loaded fine
    And "Blog" screen in Help Center should be loaded fine
    And "Facebook" screen in Help Center should be loaded fine
    And "Twitter" screen in Help Center should be loaded fine
    And "Terms of Service" screen in Help Center should be loaded fine
    And "Privacy policy" screen in Help Center should be loaded fine
