@more_logs @regression
@symptom
Feature: Baby more logs
  Scenario: Manually log symptom
    Given I create a new mother with 1 born boy
    And I login
    And I scroll to more logs
    And I log a symptom of "Cough" with start time "15.minutes.ago" 
    And I close the insight popup
    And I logout

@temperature
  Scenario: Manually log temperature
    Given I create a new mother with 1 born girl
    And I login
    And I scroll to more logs
    And I log a temperature with "106" with start time "30.minutes.ago" 
    And I close the insight popup
    And I logout

@medication
  Scenario: Manually log medication
    Given I create a new mother with 1 born girl
    And I login
    And I scroll to more logs
    And I log a medication of "Vitamin D drops" with start time "20.minutes.ago" 
    And I close the insight popup
    And I logout

@notes
  Scenario: Manually log notes
    Given I create a new mother with 1 born boy
    And I login
    And I scroll to more logs
    And I log a notes with "This is just a note"
    And I logout