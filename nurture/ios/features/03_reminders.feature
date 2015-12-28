Feature: Reminders
  @reminder
  Scenario: Create reminders
    Given I register a new pregnant user
    And I open "Alert" tab
    And I open "Reminders" tab on Alert screen
    And I create a reminder
    And I logout