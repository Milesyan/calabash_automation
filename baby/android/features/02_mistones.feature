@milestones @regression
Feature: Milestones
  @milestone_2m 
  Scenario: check the first milestone by month 2 
    Given I create a new father with 1 born girl whose birthday is "1.week.ago"
    And I login 
    And I open all moments
    Then I should see "Begins to smile at people"
    And I check the first milestone with date "10.days.ago"
    And I close the insight popup 
    And I logout

  @milestone_4m
    Scenario: check the first milestone by month 4 
    Given I create a new mother with 1 born boy whose birthday is "3.months.ago"
    And I login
    And I open all moments
    And I should see "Smiles spontaneously, especially at people"
    And I check the first milestone with date "20.days.ago"
    And I close the insight popup 
    And I logout

  @milestone_6m
    Scenario: check the first milestone by month 6 
    Given I create a new father with 1 born girl whose birthday is "5.months.ago"
    And I login
    And I open all moments
    And I should see "Distingushes between familiar faces vs. strangers"
    And I check the first milestone with date "20.days.ago"
    And I close the insight popup  
    And I logout

  @milestone_9m
    Scenario: check the first milestone by month 9 
    Given I create a new father with 1 born girl whose birthday is "7.months.ago"
    And I login
    And I open all moments
    And I should see "Afraid of strangers"
    And I check the first milestone with date "20.days.ago"
    And I close the insight popup
    And I logout

  @milestone_12m
    Scenario: check the first milestone by month 12 
    Given I create a new father with 1 born girl whose birthday is "10.months.ago"
    And I login
    And I open all moments
    And I should see "Is shy or nervous with strangers"
    And I check the first milestone with date "20.days.ago"
    And I close the insight popup
    And I logout

  @milestone_13m
    Scenario: check the first milestone by month 12 
    Given I create a new father with 1 born girl whose birthday is "13.months.ago"
    And I login
    And I open all moments
    And I should see "Is shy or nervous with strangers"
    And I check the first milestone with date "20.days.ago"
    And I close the insight popup 
    And I logout

  @create_milestone
  Scenario: create a milestone and skip share
    Given I create a new father with 1 born girl whose birthday is "1.week.ago"
    And I login
    And I open all moments
    And I create a milestone with date "2.days.ago" and title "Hello World"
    And I logout