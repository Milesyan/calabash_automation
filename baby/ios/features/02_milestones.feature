@milestones @regression
Feature: Milestones
  @milestone_2m 
  Scenario: verify milestone list by end of month 2, 4, 6, 9 and 12
    Given I create a new father with 1 born girl whose birthday is "1.week.ago"
    And I login
    And I open all moments
    Then I should see "Begins to smile at people"
    And I check milestones
    And I close moments page
    And I logout

  @milestone_4m @regression
    Scenario: verify milestone list by end of month 2, 4, 6, 9 and 12
    Given I create a new father with 1 born girl whose birthday is "2.months.ago"
    And I login
    And I open all moments
    And I should see "Smiles spontaneously, especially at people"
    And I check milestones
    And I close moments page
    And I logout

  @milestone_6m
    Scenario: verify milestone list by end of month 2, 4, 6, 9 and 12
    Given I create a new father with 1 born girl whose birthday is "4.months.ago"
    And I login
    And I open all moments
    And I should see "Distingushes between familiar faces vs. strangers"
    And I check milestones
    And I close moments page
    And I logout

  @milestone_9m
    Scenario: verify milestone list by end of month 2, 4, 6, 9 and 12
    Given I create a new father with 1 born girl whose birthday is "6.months.ago"
    And I login
    And I open all moments
    And I should see "Afraid of strangers"
    And I check milestones
    And I close moments page
    And I logout

  @milestone_12m
    Scenario: verify milestone list by end of month 2, 4, 6, 9 and 12
    Given I create a new father with 1 born girl whose birthday is "9.months.ago"
    And I login
    And I open all moments
    And I should see "Is shy or nervous with strangers"
    And I check milestones
    And I close moments page
    And I logout

  @milestone_13m
    Scenario: verify milestone list by end of month 2, 4, 6, 9 and 12
    Given I create a new father with 1 born girl whose birthday is "13.months.ago"
    And I login
    And I open all moments
    And I should see "Is shy or nervous with strangers"
    And I close moments page
    And I logout

  @create_milestone @regression
  Scenario: Add a milestone
    Given I create a new father with 1 born girl whose birthday is "1.week.ago"
    And I login
    And I open all moments
    And I create a milestone with date "2.days.ago" and title "Hello World"
    And I logout