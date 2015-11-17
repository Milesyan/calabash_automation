@ft
Feature: Fertility Treatments
  Background:
    Given I am a new "fertility treatment" user
    And I open Glow for the first time
    And I touch "Get Started!" button
    And I select the user type "Fertility treatments"

  @ft_prep
  Scenario: Preparing for treatment
    And I choose "Preparing for treatment" status for fertility treatment
    And I complete Fertility Treatment onboarding step 2
    And I complete Fertility Treatment onboarding step 3
    And I fill in email name password and birthday
    And I finish the tutorial
    Then I should see "Complete log!"
    And I logout

  @ft_med
  Scenario: Med
    And I choose "Intercourse with fertility med" status for fertility treatment
    And I complete Fertility Treatment onboarding step 2
    And I complete Fertility Treatment onboarding step 3
    And I fill in email name password and birthday
    And I finish the tutorial
    Then I should see "Complete log!"
    And I logout

  @ft_iui
  Scenario: IUI
    And I choose "Intrauterine Insemination (IUI)" status for fertility treatment
    And I complete Fertility Treatment onboarding step 2
    And I complete Fertility Treatment onboarding step 3
    And I fill in email name password and birthday
    And I finish the tutorial
    Then I should see "Complete log!"
    And I logout

  @ft_ivf
  Scenario: IVF
    And I choose "In Vitro Fertilization (IVF)" status for fertility treatment
    And I complete Fertility Treatment onboarding step 2
    And I complete Fertility Treatment onboarding step 3
    And I fill in email name password and birthday
    And I finish the tutorial
    Then I should see "Complete log!"
    And I logout

