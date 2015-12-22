@signup @regression
Feature: Onboarding flow
  @non_ttc_signup
  Scenario: NonTTC user signup
    Given I am a new "Non-TTC" user
    And I open Glow for the first time
    And I touch "Get Started!" button
    And I select the user type "Avoiding pregnancy"
    And I complete Non-TTC onboarding step 1
    And I complete Non-TTC onboarding step 2
    And I fill in email name password and birthday
    And I finish the tutorial
    Then I wait until I see "Complete log!"
    And I logout

  @ttc_signup
  Scenario: TTC user signup
    Given I am a new "TTC" user
    And I open Glow for the first time
    And I touch "Get Started!" button
    And I select the user type "Trying to conceive"
    And I complete TTC onboarding step 1
    And I complete TTC onboarding step 2
    And I fill in email name password and birthday
    And I finish the tutorial via www
    And I relaunch the app
    And I login
    Then I wait until I see "Complete log!"
    And I logout

