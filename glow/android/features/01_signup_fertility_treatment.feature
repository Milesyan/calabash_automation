@signup @ft-signup @regression @all
Feature: Fertility Treatment users sign up
  @ft_prep
  Scenario: Preparing for treatment user signs up
    Given I am a new "Prep" user
    And I open Glow for the first time
    And I touch the "Sign up" button
    And I select the user type "Fertility treatments"
    And I complete Fertility Treatment onboarding step 1
    And I complete Fertility Treatment onboarding step 2
    And I fill in email name password and birthday
    And I finish the tutorial
    Then I should see "Complete log"
    And I logout

  @ft_med
  Scenario: Med user signup
    Given I am a new "Med" user
    And I open Glow for the first time
    And I touch the "Sign up" button
    And I select the user type "Fertility treatments"
    And I complete Fertility Treatment onboarding step 1
    And I complete Fertility Treatment onboarding step 2
    And I fill in email name password and birthday
    And I finish the tutorial
    Then I should see "Complete log"
    And I logout

  @ft_iui
  Scenario: IUI user signup
    Given I am a new "IUI" user
    And I open Glow for the first time
    And I touch the "Sign up" button
    And I select the user type "Fertility treatments"
    And I complete Fertility Treatment onboarding step 1
    And I complete Fertility Treatment onboarding step 2
    And I fill in email name password and birthday
    And I finish the tutorial
    Then I should see "Complete log"
    And I logout

  @ft_ivf
  Scenario: IVF user signup
    Given I am a new "IVF" user
    And I open Glow for the first time
    And I touch the "Sign up" button
    And I select the user type "Fertility treatments"
    And I complete Fertility Treatment onboarding step 1
    And I complete Fertility Treatment onboarding step 2
    And I fill in email name password and birthday
    And I finish the tutorial
    Then I should see "Complete log"
    And I logout
