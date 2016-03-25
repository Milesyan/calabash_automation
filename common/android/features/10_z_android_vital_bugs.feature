@forum @bugs
Feature: Some vital bugs and need to regress it each version.

  Scenario: Reproduce the Floating menu bug
    Given I create a new forum user with name "Miles"
    And "Miles" create a group in category "Baby" with name "SearchGroup"
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to search bar
    Then I test search group function
    # And I press the "Joined" button
    # And I go to previous page
    And I go to previous page
    And I click the DISCOVER button in community tab
    Then I check the fab menu under discover tab
    And I logout