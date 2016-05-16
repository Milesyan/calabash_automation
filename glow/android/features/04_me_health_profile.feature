@me @health_profile @regression
Feature: Health profile
  @non_ttc_female_health_profile
  Scenario: Non-TTC user health profile
    Given I create a new "Non-TTC" glow user
    And I complete my health profile via www
    And I login
    And I close the premium popup
    And I open "Me" page
    And my health profile should be "100%"
    And I open and check my health profile
    And I logout

  @ttc_female_health_profile
  Scenario: TTC user health profile
    Given I create a new "TTC" glow user
    And I complete my health profile via www
    And I login
    And I close the premium popup
    And I open "Me" page
    And my health profile should be "100%"
    And I open and check my health profile
    And I logout

  @prep_female_health_profile
  Scenario: Prep user health profile
    Given I create a new "Prep" glow user
    And I complete my health profile via www
    And I login
    And I close the premium popup
    And I open "Me" page
    And my health profile should be "94%"
    And I open and check my health profile
    And I logout

  @ttc_male_partner_health_profile
  Scenario: TTC male partner health profile
    Given I create a new "TTC" "Male" glow partner user
    And I complete my health profile via www
    And I login
    And I close the premium popup
    And I open "Me" page
    And my health profile should be "69%"
    And I open and check my health profile
    And I logout

