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
    Then I should see "Complete log!"
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
    And I finish the tutorial
    Then I should see "Complete log!"
    And I logout

  @ft_signup
  Scenario: Fertility treatment user signup
    Given I am a new "Fertility treatment" user
    And I open Glow for the first time
    And I touch "Get Started!" button
    And I select the user type "Fertility treatments"
    And I choose "Preparing for treatment" status for fertility treatment
    And I complete Fertility Treatment onboarding step 2
    And I complete Fertility Treatment onboarding step 3
    And I fill in email name password and birthday
    And I finish the tutorial
    Then I should see "Complete log!"
    And I logout
