@partner @regression
Feature: Partner signup
  Scenario: Partner should be able to signup
    Given I create a new mother with 1 born girl
    And I create and invite a partner as father
    And I signup as partner
    And I choose the baby to continue
    And I open "More" page
    And I edit my baby's profile
    And I leave this baby
    And I logout
    
  @partner_log
  Scenario: Partner should be able to signup
    Given I create a new mother with 1 born girl
    And I create and invite a partner as father
    And I signup as partner
    And I choose the baby to continue
    And I log a poo with start time "10.minutes.ago"
    And I close the insight popup
    And I logout
