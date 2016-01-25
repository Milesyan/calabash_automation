@feed @regression
Feature: Feeding baby
  @bottle_feed_breastmilk
  Scenario: bottle feeding - breast milk
    Given I create a new mother with 1 born boy
    And I login
    And I log a bottle feeding with breast milk with start time "30.minutes.ago"
    And I close the insight popup
    And I logout

  @bottle_feed_formula
  Scenario: bottle feeding - formula
    Given I create a new mother with 1 born girl
    And I login
    And I log a bottle feeding with formula milk with start time "90.minutes.ago"
    And I close the insight popup
    And I logout

  @bottle_feed_yesterday
  Scenario: bottle feeding for yesterday
    Given I create a new mother with 1 born girl
    And I login
    And I log a bottle feeding with formula milk with start time "1.day.ago"
    And I logout

  @bottle_feed_3days
  Scenario: bottle feeding for 3 days
    Given I create a new mother with 1 born girl
    And I login
    And I log a bottle feeding with breast milk with start time "70.minutes.ago"
    And I close the insight popup
    And I log a bottle feeding with formula milk with start time "30.hours.ago"
    And I log a bottle feeding with formula milk with start time "50.hours.ago"
    And I logout