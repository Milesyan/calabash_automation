@female_partner_daily_log @regression
Feature: Female partners complete daily log
  @non_ttc_female_partner_daily_log
  Scenario: Non-TTC female partner completes daily log
    Given I create a new "Non-TTC" "Female" glow partner user
    And I login
    And I complete daily log for female partner
    And I logout

  @ttc_female_partner_daily_log
  Scenario: TTC female partner completes daily log
    Given I create a new "TTC" "Female" glow partner user
    And I login
    And I complete daily log for female partner
    And I logout

  @prep_female_partner_daily_log
  Scenario: Prep female partner completes daily log
    Given I create a new "Prep" "Female" glow partner user
    And I login
    And I complete daily log for female partner
    And I logout

  @ivf_female_partner_daily_log
  Scenario: IVF female partner completes daily log
    Given I create a new "IVF" "Female" glow partner user
    And I login
    And I complete daily log for female partner
    And I logout