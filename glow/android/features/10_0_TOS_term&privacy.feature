@dev @TOS @p0
Feature: Check TOS when open the app 
  Scenario: User opens the app and checks the TOS in the home page.
    Given I open the app and go to the signup page
    When I click the link for Terms
    Then I should see the correct website for Terms
    And I go back to previous page from the pop-up web page
    When I click the link for Privacy Policy
    Then I should see the correct website for Privacy Policy
    And I go back to previous page from the pop-up web page
    Then I should see the bottom hint section