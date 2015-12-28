Feature: Appointments
  @appointment
  Scenario: Create appointments
    Given I register a new pregnant user
    And I open "Alert" tab
    And I open "Appointments" tab on Alert screen
    And I create an appointment
    And I logout