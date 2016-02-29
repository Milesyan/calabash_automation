@content
Feature: Content
  Scenario: Content
    Given I am Glow admin
    And I login

    And I open "content"
    Then I should see "Quiz"
    And I should see "Notifications"
    And I logout