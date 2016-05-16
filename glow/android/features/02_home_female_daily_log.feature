@home @daily_log @regression @all
Feature: Non-TTC, TTC users complete daily log
	@non_ttc_daily_log
  Scenario: Non-TTC user completes daily log
    Given I create a new "Non-TTC" glow user
    And I login
    And I close the premium popup
    And I complete daily log
    And I close insights popup
    And I logout

  @ttc_daily_log
  Scenario: TTC user completes daily log
    Given I create a new "TTC" glow user
    And I login
    And I close the premium popup
    And I complete daily log
    And I close insights popup
    And I logout
