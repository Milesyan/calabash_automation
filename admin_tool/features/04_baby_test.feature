@baby
Feature: Baby Test
  Scenario: All baby pages should be accessible
    Given I am Glow admin
    And I login
    And I search user "rachel_glow+2@yahoo.com"
    Then I should see "Basic Info"

    And I open "baby_notifications"
    Then I should see "Baby Notification History"

    And I open "baby_milestones"
    Then I should see "Baby Milestones"

    And I open "baby_insights"
    Then I should see "Baby Insight History"

    And I open "baby_daily_data"
    Then I should see "Baby Baby Data"

    And I open "baby_feed_data"
    Then I should see "Baby Baby Feed_data"

    And I open "baby_pdf_export"
    Then I should see "Baby Pdf Export"

    And I logout