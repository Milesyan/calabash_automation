@me @health_profile @regression
Feature: Health profile
  Scenario: check my Health profile
    Given I create a new "Non-TTC" user
    And I login
    And I open "me" page

    And I open "Health profile" on Me page
    And I complete my health profile
    And I logout