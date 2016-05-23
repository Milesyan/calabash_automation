@partner @regression
Feature: Partner features
  Scenario: partner leaves this baby
    Given I create a new mother with 1 born girl
    And I create and invite a partner as father
    And I signup as partner
    And I choose the baby to continue
    And I close premium introduction pop up
    And I open "me" page
    And I touch "Edit profile" button
    And I leave this baby
    And I add one born boy with birthday "3.days.ago" and due date "3.days.ago" on me page
    And I logout