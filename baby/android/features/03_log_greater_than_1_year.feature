@regression
Feature: Logs for baby > 1 year old
  @old_baby
  Scenario: baby greater than one year old
    Given I create a new mother with birthday "25.years.ago"
    And I login
    And I add one born boy with birthday "380.days.ago" and due date "380.days.ago"
    And I scroll to growth chart
    And I add birth data
    And I log weight "3.0 kg" on "20.days.ago"
    And I log weight "4.0 kg" on "9.days.ago"
    And I log height "45 cm" on "10.days.ago"
    And I log height "48 cm" on "1.day.ago"
    And I logout