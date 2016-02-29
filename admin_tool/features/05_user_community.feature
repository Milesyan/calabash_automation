@user_community
Feature: User's community
  Scenario: user's community pages should be accessible
    Given I am Glow admin
    And I login
    And I search user "rachel_glow+2@yahoo.com"
    Then I should see "Basic Info"

    And I open "user_forum_activities"
    Then I should see "Riri's Community Activity"

    And I open "user_forum_groups"
    Then I should see "Riri's Subscribed Groups"

    And I logout