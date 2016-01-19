@confirm_period @regressioin
Feature: Period confirmation
  @confirm_period_yes
  Scenario: Confirm Period - Yes
    Given I create a new "TTC" user with cycle length 30 days and period start date "30.days.ago"
    And I login
    And I confirm the period with "Yes"
    And I logout

  @confirm_period_no
  Scenario: Confirm Period - No
    Given I create a new "TTC" user with cycle length 30 days and period start date "30.days.ago"
      And I login
      And I confirm the period with "No"
      And I logout