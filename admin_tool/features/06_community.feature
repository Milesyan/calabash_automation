@alerts_queue
Feature: Community alerts queue
  Scenario: alerts queue page should load well
    Given I am Glow admin
    And I login

    And I open "community"
    And I check the alerts queue
    And I logout