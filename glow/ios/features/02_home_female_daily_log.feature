@daily_log @regression
Feature: Complete daily log
  @non_ttc_daily_log
  Scenario: Non-TTC user completes daily log
    Given I create a new "Non-TTC" user
    And I login
    And I complete my daily log
    And I logout

  @ttc_daily_log
  Scenario: TTC user completes daily log
  	Given I create a new "TTC" user
    And I login
    And I complete my daily log
  	And I logout

  @iui_daily_log
  Scenario: IUI user completes daily log
  	Given I register a new "IUI" user
  	And I logout
