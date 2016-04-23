#@regression
Feature: ToS
  @check_tos
  Scenario: check tos clickable on signup page
    Given I want to sign up 
    And I check the terms are clickable
    Then I should see "Terms of Service"
    Then I close the page
    And I check Privacy Policy clickable
    Then I should see "Privacy Policy"
    Then I close the page
    #And I go back to onbording page