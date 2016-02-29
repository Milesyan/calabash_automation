@eve
Feature: Eve test
  Scenario: All Eve pages should be accessible
    Given I am Glow admin
    And I login
    And I search user "rachel_glow+2@yahoo.com"
    Then I should see "Basic Info"

    And I open "eve_period_editor"
    Then I should see "Riri's Periods"

    And I open "eve_notifications"
    Then I should see "Eve Notification History"

    And I open "eve_daily_data"
    Then I should see "Eve Daily Data"

    And I logout