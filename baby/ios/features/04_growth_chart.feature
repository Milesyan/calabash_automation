@growth_chart @regression
Feature: Growth chart log weight, height and head circ
  @log_weight
  Scenario: Log weight
    Given I create a new mother with 1 born boy whose birthday is "7.weeks.ago"
    And I login
    And I scroll to growth chart
    And I log weight "4.5kg" on "15.days.ago"
    And I log weight "6.1kg" on "7.days.ago"
    And I log weight "7.0kg" on "today"
    And I close the insight popup
    And I push data to server and loggout

  @log_height
  Scenario: Log height
    Given I create a new father with 1 born girl whose birthday is "8.week.ago"
    And I login
    And I scroll to growth chart
    And I log height "53 cm" on "20.days.ago"
    And I log height "16 in" on "10.days.ago"
    And I log height "59 cm" on "today"
    And I close the insight popup
    And I push data to server and loggout

  @log_head_circ
  Scenario: Log head circ
    Given I create a new father with 1 born girl whose birthday is "8.week.ago"
    And I login
    And I scroll to growth chart
    And I log head circ "30 cm" on "20.days.ago"
    And I log head circ "14 in" on "10.days.ago"
    And I log head circ "40 cm" on "today"
    And I close the insight popup
    And I push data to server and loggout


