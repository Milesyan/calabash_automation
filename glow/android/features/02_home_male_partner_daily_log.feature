@home @male_partner_daily_log @regression @all
Feature: Male partners complete daily log
  @non_ttc_male_partner_daily_log
  Scenario: Non-TTC male partner completes daily log
    Given I create a new "Non-TTC" "Male" glow partner user
    And I login
    And I complete my daily log for male
    And I logout

  @ttc_male_partner_daily_log
  Scenario: TTC male partner completes daily log
    Given I create a new "TTC" "Male" glow partner user
    And I login
    And I complete my daily log for male
    And I logout

  @iui_male_partner_daily_log
  Scenario: IUI male partner completes daily log
    Given I create a new "IUI" "Male" glow partner user
    And I login
    And I complete my daily log for male
    And I logout

  @med_male_partner_daily_log
  Scenario: Med male partner completes daily log
    Given I create a new "Med" "Male" glow partner user
    And I login
    And I complete my daily log for male
    And I logout