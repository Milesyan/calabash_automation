@forum @discover
Feature: User enter discover tab and check elements
  @explore
  Scenario: User enter explore tab and check elements
    Given I create a new forum user with name "Miles"
    And "Miles" create a group in category "Health & Lifestyle" using www api
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I click the DISCOVER button in community tab
    Then I click Explore button
    And I click the search icon in explore page
    Then I test search group function
    And I click cancel button
    And I go to "Health & Lifestyle" category
    And I click new tab
    Then I check the group I created is there
    And I go to previous page
    And I logout


  @see_all
  Scenario: User enter explore tab and check elements
    Given I create a new forum user with name "Miles"
    And "Miles" create a group in category "Health & Lifestyle" using www api
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I click the DISCOVER button in community tab
    Then I click see all button after "Popular Groups"
    And I can see many groups
    And I go to previous page
    Then I click see all button after "Super Active Groups"
    And I can see many groups
    And I go to previous page
    And I logout


