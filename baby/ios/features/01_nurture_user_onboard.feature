@nurture 
Feature: Nurture users should be able to login to Baby
  @nurture1
  Scenario: Nurture User
    Given I create a Nurture user with due date "1.month.since"
    And I login
    And I add a baby with nurture pre-filled data
    And I logout
  
  @nurture_partner
  Scenario: Nurture partner user signs up in Baby app
    Given I create a Nurture user with due date "2.months.since"
    And I invite my partner
    And I login
    And I add a baby with nurture pre-filled data
    And I logout