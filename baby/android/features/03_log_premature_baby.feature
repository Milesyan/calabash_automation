@premature
Feature: Premature baby
  @day_279
  Scenario: Premature baby
    Given I create a new mother with birthday "25.years.ago"
    And I login
    And I add one born boy with birthday "22.days.ago" and due date "today"
    And I scroll to growth chart
    And I log weight "3.0kg" on "today"
    # Then I should not see the percentile until 40 weeks reached
    And I logout

  @day_290
  Scenario: Premature baby
    Given I create a new mother with birthday "25.years.ago"
    And I login
    And I add one born boy with birthday "32.days.ago" and due date "10.days.ago"
    And I scroll to growth chart
    And I log weight "3.0 kg" on "11.days.ago"
    And I log weight "4.0 kg" on "9.days.ago"
    And I log height "45 cm" on "10.days.ago"
    And I log height "48 cm" on "9.days.ago"
    And I logout