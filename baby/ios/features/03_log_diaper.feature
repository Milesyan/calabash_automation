@diaper @regression
Feature: Log Diaper
  Scenario: Log diaper today
    Given I create a new mother with 1 born girl
    And I login
    And I log a poo with start time "10.minutes.ago"
    And I close the insight popup
    And I log a pee with start time "30.minutes.ago"
    And I close the insight popup
    And I logout

  Scenario: Log diaper for yesterday
    Given I create a new father with 1 born boy
    And I login
    And I log a poo with start time "24.hours.ago"
    And I log a pee with start time "24.hours.ago"
    And I logout

  @diaper_3days
  Scenario: Log diaper for 3 days
    Given I create a new father with 1 born boy
    And I login
    And I log a poo with start time "50.minutes.ago"
    And I close the insight popup
    And I log a pee with start time "25.hours.ago"
    And I log a poo with start time "50.hours.ago"
    And I logout