@ft_daily_log @regression
Feature: Fertility treatment users complete daily log and ft log
  @iui_daily_log
  Scenario: IUI user completes ft log and daily log
    Given I create a new "IUI" glow user
    And I login
    And I close the premium popup
    And I complete my ft log
    And I complete my daily log
    And I logout

  @ivf_daily_log
  Scenario: IVF user completes ft log and daily log
    Given I create a new "IVF" glow user
    And I login
    And I close the premium popup
    And I complete my ft log
    And I complete my daily log
    And I logout

  @prep_daily_log
  Scenario: Prep user completes ft log and daily log
    Given I create a new "Prep" glow user
    And I login
    And I close the premium popup
    And I complete my ft log
    And I complete my daily log
    And I logout

  @med_daily_log
  Scenario: Med user completes ft log and daily log
    Given I create a new "Med" glow user
    And I login
    And I close the premium popup
    And I complete my ft log
    And I complete my daily log
    And I logout
