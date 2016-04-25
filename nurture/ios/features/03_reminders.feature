Feature: Reminders
  @reminder
  Scenario: Create reminders
    Given I create a new user
    And I login
    And I open "Alert" tab
    And I open "Reminders" tab on Alert screen
    And I create a reminder
    And I logout