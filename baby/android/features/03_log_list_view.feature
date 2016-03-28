@log_list_view
Feature: Log list view
  Scenario: log list view
    Given I create a new mother with 1 born girl
    And I login
    And I log a bottle feeding with formula milk with start time "1.day.ago"
    And I logout