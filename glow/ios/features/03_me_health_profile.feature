@me @health_profile @regression
Feature: Health profile
  @ui_non_ttc_female_health_profile
  Scenario: Check my Health profile
    Given I create a new "Non-TTC" glow user
    And I login
    And I open "me" page
    And I open "Health profile" on Me page
    And I complete my health profile
    And I logout

  @non_ttc_female_health_profile
  Scenario: Health profile for Non-TTC user
    Given I create a new "Non-TTC" glow user
    And I complete my health profile via www
    When I login
    And I open "Me" page
    And my health profile should be "100%"
    And I open and check my health profile
    And I logout

  @ttc_female_health_profile
  Scenario: Health profile for TTC user
    Given I create a new "TTC" glow user
    And I complete my health profile via www
    When I login
    And I open "Me" page
    And my health profile should be "100%"
    And I open and check my health profile
    And I logout

  @iui_female_health_profile
  Scenario: Health profile for IUI user
    Given I create a new "IUI" glow user
    And I complete my health profile via www
    When I login
    And I open "Me" page
    And my health profile should be "95%"
    And I open and check my health profile
    And I logout


