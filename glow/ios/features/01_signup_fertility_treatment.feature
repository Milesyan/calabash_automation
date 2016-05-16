@ft_signup @regression
Feature: Fertility Treatment users sign up
  @ft_prep
  Scenario: Preparing for treatment
    Given I am a new "Prep" user
    And I open Glow for the first time
    And I touch "Get Started!" button
    And I select the user type "Fertility treatments"
    And I complete Fertility Treatment onboarding step 1
    And I complete Fertility Treatment onboarding step 2
    And I complete Fertility Treatment onboarding step 3
    And I fill in email name password and birthday
    And I finish the tutorial via www
    And I relaunch the app
    And I login
    And I close the premium popup
    Then I wait until I see "Complete log!"
    And I logout

  @ft_med
  Scenario: Med
    Given I am a new "Med" user
    And I open Glow for the first time
    And I touch "Get Started!" button
    And I select the user type "Fertility treatments"
    And I complete Fertility Treatment onboarding step 1
    And I complete Fertility Treatment onboarding step 2
    And I complete Fertility Treatment onboarding step 3
    And I fill in email name password and birthday
    And I finish the tutorial via www
    And I relaunch the app
    And I login
    And I close the premium popup
    Then I wait until I see "Complete log!"
    And I logout

  @ft_iui
  Scenario: IUI
    Given I am a new "IUI" user
    And I open Glow for the first time
    And I touch "Get Started!" button
    And I select the user type "Fertility treatments"
    And I complete Fertility Treatment onboarding step 1
    And I complete Fertility Treatment onboarding step 2
    And I complete Fertility Treatment onboarding step 3
    And I fill in email name password and birthday
    And I finish the tutorial via www
    And I relaunch the app
    And I login
    And I close the premium popup
    Then I wait until I see "Complete log!"
    And I logout

  @ft_ivf
  Scenario: IVF
    Given I am a new "IVF" user
    And I open Glow for the first time
    And I touch "Get Started!" button
    And I select the user type "Fertility treatments"
    And I complete Fertility Treatment onboarding step 1
    And I complete Fertility Treatment onboarding step 2
    And I complete Fertility Treatment onboarding step 3
    And I fill in email name password and birthday
    And I finish the tutorial via www
    And I relaunch the app
    And I login
    And I close the premium popup
    Then I wait until I see "Complete log!"
    And I logout

