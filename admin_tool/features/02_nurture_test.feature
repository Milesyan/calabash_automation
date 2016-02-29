@nurture
Feature: Nurture Test
  @nurture_pages
  Scenario: All Nurture pages should be accessible
    Given I am Glow admin
    And I login
    And I search user "rachel_glow+2@yahoo.com"
    Then I should see "Basic Info"

    And I open "nurture_daily_data"
    Then I should see "Nurture Daily Data"

    And I open "nurture_pregnancy_history"
    And I should see "Nurture Pregnancy"

    And I open "nurture_medical_log"
    Then I should see "Nurture Medical Log"

    And I open "nurture_notifications"
    Then I should see "Nurture Notification History"

    And I open "nurture_insights"
    Then I should see "Nurture Insight History"

    And I open "nurture_reminders"
    Then I should see "Nurture Reminder"

    And I open "nurture_pdf_export"
    Then I should see "Nurture Pdf Export"

    And I logout


