@premature_baby @wip
Feature: Premature baby
  Scenario: Mother signup and add a premature boy
    Given I create a new mother with birthday "25.years.ago"
    And I login
    And I add one born boy with birthday "1.weeks.ago" and due date "5.weeks.since"
    And I scroll to growth chart
    And I log weight "3.0kg" on "today"
    And I close the insight popup
    Then I should not see the percentile until 40 weeks reached
    And I logout

  @start_to_see_percentile
  Scenario: I should start to see the percentile once a premature baby is 40 weeks old
    Given I create a new mother with birthday "25.years.ago"
    And I login
    And I add one born boy with birthday "5.weeks.ago" and due date "today"
    And I scroll to growth chart
    And I log weight "3.0kg" on "Time.now"
    Then I should not see the percentile until 40 weeks reached
    And I logout