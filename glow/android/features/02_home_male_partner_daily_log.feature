@male_daily_log @regression @all
Feature: Complete daily log
  @non_ttc_male_partner_daily_log
  Scenario: Non-TTC male partner completes daily log
    Given I register a new "Non-TTC" user
    And I open "Me" page
    And I invite my male partner
    And I logout

    And I login as the partner
    And I finish the tutorial
    And I complate my daily log for male
    And I logout

  @ttc_male_partner_daily_log
  Scenario: TTC male partner completes daily log
   	Given I register a new "TTC" user
    And I open "Me" page
    And I invite my male partner
    And I logout

    And I login as the partner
    And I finish the tutorial
    And I complate my daily log for male
    And I logout

  @iui_male_partner_daily_log
  Scenario: IUI male partner completes daily log
    Given I register a new "IUI" user
    And I open "Me" page
    And I invite my male partner
    And I logout

    And I login as the partner
    And I finish the tutorial
    And I complate my daily log for male
    And I logout