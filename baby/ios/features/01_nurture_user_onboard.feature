@nurture @regression
Feature: Nurture users should be able to login to Baby
  Scenario: Nurture User
    Given I create a Nurture user with due date "1.month.since"
    And I login
    And I add a baby with nurture pre-filled data
    And I logout
    