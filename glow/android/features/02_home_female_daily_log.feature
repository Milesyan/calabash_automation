@daily_log @regression @all
Feature: Complete daily log
	@non_ttc_daily_log
  Scenario: Non-TTC user completes daily log
    Given I register a new "Non-TTC" user
    And I complete daily log
    And I logout

  @ttc_daily_log
  Scenario: TTC user completes daily log
  	Given I register a new "TTC" user
    And I complete daily log
    And I logout

  @iui_daily_log
  Scenario: IUI user completes daily log
  	Given I register a new "IUI" user
    And I complete daily log
    And I logout

