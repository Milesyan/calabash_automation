@home @ft_log @regression @all
Feature: Fertility treatment users complete fertility treatment log and daily log
  @iui_daily_log
  Scenario: IUI user completes fertility treatment log and daily log
    Given I create a new "IUI" glow user
    And I login
    And I close the premium popup
    And I complete ft log
    And I close insights popup
    And I complete daily log
    And I close insights popup
    And I logout
    
  @ivf_ft_log
  Scenario: IVF user completes fertility treatment log and daily log
    Given I create a new "IVF" glow user
    And I login
    And I close the premium popup
    And I complete ft log
    And I close insights popup
    And I complete daily log
    And I close insights popup
    And I logout

  @med_ft_log
  Scenario: Med user completes fertility treatment log and daily log
    Given I create a new "Med" glow user
    And I login
    And I close the premium popup
    And I complete ft log
    And I close insights popup
    And I complete daily log
    And I close insights popup
    And I logout

  @prep_ft_log
  Scenario: Prep user completes fertility treatment log and daily log
    Given I create a new "Prep" glow user
    And I login
    And I close the premium popup
    And I complete ft log
    #And I close insights popup
    And I complete daily log
    And I close insights popup
    And I logout        