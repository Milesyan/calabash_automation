Feature: Medical log
  @med_log
  Scenario: add a medical log
    Given I register a new pregnant user
    And I add a medical log
    And I open med log history