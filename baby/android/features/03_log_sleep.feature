@sleep @regression
Feature: Sleep
  Scenario: Manually log sleep
    Given I create a new mother with 1 born boy
    And I login
    And I log a sleep with start time "10.minutes.ago" and end time "1.minute.ago"
    And I logout

  @sleep_yesterday
  Scenario: Manually log sleep for yesterday
    Given I create a new mother with 1 born boy
    And I login
    And I log a sleep with start time "25.hours.ago" and end time "24.hours.ago"
    And I logout

  @sleep_3logs
  Scenario: Manually log sleep for yesterday
    Given I create a new mother with 1 born boy
    And I login
    And I log a sleep with start time "50.hours.ago" and end time "48.hours.ago"
    And I log a sleep with start time "24.hours.ago" and end time "1.hour.ago"
    And I close the inisght popup
    And I log a sleep with start time "60.minutes.ago" and end time "30.minutes.ago"
    And I logout