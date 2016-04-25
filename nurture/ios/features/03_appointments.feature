Feature: Appointments
  @appointment
  Scenario: Create appointments
    Given I create a new user
    And I login
    And I open "Alert" tab
    And I open "Appointments" tab on Alert screen
    And I create an appointment
    And I logout