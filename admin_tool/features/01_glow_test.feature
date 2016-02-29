@glow
Feature: Glow Test
  # @login
  # Scenario: Login to admin tool
  #   Given I am Glow admin
  #   And I login

  @glow_pages
  Scenario: All Glow pages should be accessible
    Given I am Glow admin
    And I login
    And I search user "rachel_glow+2@yahoo.com"
    Then I should see "Basic Info"

    And I open "glow_daily_data"
    Then I should see "Glow Daily Data"

    And I open "glow_status_history"
    And I should see "Glow Status History"

    And I open "glow_notifications"
    Then I should see "Glow Notification History"

    And I open "glow_insights"
    Then I should see "Glow Insight History"

    And I open "glow_reminders"
    Then I should see "Glow Reminder"

    And I open "glow_pdf_export"
    Then I should see "Glow Pdf Export"

    And I logout


