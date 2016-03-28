@more_logs @regression
Feature: Add More logs
  @rash
  Scenario: Add more logs
    Given I create a new mother with 1 born girl
    And I login
    And I open more logs
    And I log "Rash" symptom
    And I close the inisght popup
    And I logout
  @fever
  Scenario: Add fever
    Given I create a new mother with 1 born girl
    And I login
    And I open more logs
    And I log "Fever" symptom
    And I logout

  @med
  Scenario: Add med
    Given I create a new mother with 1 born girl
    And I login
    And I open more logs
    And I add some meds
    And I logout

  @note
    Scenario: Add notes
    Given I create a new mother with 1 born girl
    And I login
    And I open more logs
    And I add notes
    # And I save more logs
    And I logout
