@milestones @regression
Feature: Milestones
  @milestone_2m 
  Scenario: check the first milestone with photo by month 2 and skip share
    Given I create a new father with 1 born girl whose birthday is "1.week.ago"
    And I login 
    And I open all moments
    Then I should see "Begins to smile at people"
    #And I check milestones
    And I check the first milestone with date "10.days.ago"
    And I add a picture for milestone
    And I skip of sharing milestone to community
    And I close the insight popup 
    And I logout

  @milestone_4m @regression
    Scenario: check the first milestone with photo by month 4 and go share
    Given I create a new mother with 1 born boy whose birthday is "2.months.ago"
    And I login
    And I open all moments
    And I should see "Smiles spontaneously, especially at people"
    #And I check milestones
    And I check the first milestone with date "20.days.ago"
    And I add a picture for milestone
    And I share milestone to community
    And I close the insight popup 
    And I logout

  @milestone_6m
    Scenario: check the first milestone without photo by month 6 
    Given I create a new father with 1 born girl whose birthday is "4.months.ago"
    And I login
    And I open all moments
    And I should see "Distingushes between familiar faces vs. strangers"
    #And I check milestones
    And I check the first milestone with date "20.days.ago"
    And I save this milestone 
    And I close the insight popup  
    And I logout

  @milestone_9m
    Scenario: check the first milestone with photo by month 9 and go share from home page
    Given I create a new father with 1 born girl whose birthday is "6.months.ago"
    And I login
    And I open all moments
    And I should see "Afraid of strangers"
    #And I check milestones
    And I check the first milestone with date "20.days.ago"
    And I add a picture for milestone
    And I skip of sharing milestone to community
    And I close the insight popup
    And I share milestone from home page to community
    And I logout

  @milestone_12m
    Scenario: check the first milestone without photo by month 12 and go share from home page
    Given I create a new father with 1 born girl whose birthday is "9.months.ago"
    And I login
    And I open all moments
    And I should see "Is shy or nervous with strangers"
    #And I check milestones
    And I check the first milestone with date "20.days.ago"
    And I save this milestone 
    And I close the insight popup 
    And I share milestone from home page to community with topic title "Hello World"
    And I logout

  @milestone_13m
    Scenario: check the first milestone with photo by month 12 and go share 
    Given I create a new father with 1 born girl whose birthday is "13.months.ago"
    And I login
    And I open all moments
    And I should see "Is shy or nervous with strangers"
    And I check the first milestone with date "20.days.ago"
    And I add a picture for milestone
    And I share milestone to community
    And I close the insight popup 
    And I logout

  @create_milestone @regression
  Scenario: create a milestone and skip share
    Given I create a new father with 1 born girl whose birthday is "1.week.ago"
    And I login
    And I open all moments
    And I create a milestone with date "2.days.ago" and title "Hello World"
    And I add a picture for milestone
    And I skip of sharing milestone to community
    And I logout