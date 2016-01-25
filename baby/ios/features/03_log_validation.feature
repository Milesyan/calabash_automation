@log_validation
Feature: Premature baby
  Scenario: Mother signup and add a premature boy
    Given I create a new mother with birthday "25.years.ago"
    And I login
    And I add one born boy with birthday "729.days.ago" and due date "5.weeks.since"
    And I scroll to growth chart
    And I log weight "3.0kg" on "today"
    And I close the insight popup
    Then I should not see the percentile until 40 weeks reached
    And I logout