@log_for_one_year_baby @regression
Feature: Baby more than one years old
  Scenario: Mother signup and add a more than one years old boy
    Given I create a new mother with birthday "25.years.ago"
    And I login with no baby
    And I add one born boy with birthday "370.days.ago" and due date "360.days.ago"
    And I close premium introduction pop up
    And I scroll to growth chart
    And I log weight "10.0kg" on "today"
    And I log height "72 cm" on "6.days.ago"
    And I push data to server and loggout