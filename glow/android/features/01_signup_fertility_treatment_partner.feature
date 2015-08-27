@ft_partner_signup @regression @all
Feature: Fertility Treatments user signup
  Background:
    Given I am a new "fertility treatment" user
    And I open Glow for the first time
    And I touch the "Get Started!" button
    And I select the user type "Fertility treatments"

  @ft_prep_partner
  Scenario: Preparing for treatment partner user signup
    And I choose "Preparing for treatment" status for fertility treatment
    And I complete Fertility Treatment onboarding step 2
    And I complete Fertility Treatment onboarding step 3
    And I fill in email name password and birthday
    And I finish the tutorial
    Then I should see "Complete log"
    And I open "Me" page
    And I invite my male partner
    And I logout

    And I login as the partner
    And I finish the tutorial
    Then I should see "Complete log"
    And I logout

  @ft_med_partner
  Scenario: Med partner user signup
    And I choose "Intercourse with fertility medication" status for fertility treatment
    And I complete Fertility Treatment onboarding step 2
    And I complete Fertility Treatment onboarding step 3
    And I fill in email name password and birthday
    And I finish the tutorial
    Then I should see "Complete log"
    And I open "Me" page
    And I invite my male partner
    And I logout

    And I login as the partner
    And I finish the tutorial
    Then I should see "Complete log"
    And I logout

  @ft_iui_partner
  Scenario: IUI partner user signup
    And I choose "Intrauterine Insemination (IUI)" status for fertility treatment
    And I complete Fertility Treatment onboarding step 2
    And I complete Fertility Treatment onboarding step 3
    And I fill in email name password and birthday
    And I finish the tutorial
    Then I should see "Complete log"
    And I open "Me" page
    And I invite my male partner
    And I logout

    And I login as the partner
    And I finish the tutorial
    Then I should see "Complete log"
    And I logout

  @ft_ivf_partner
  Scenario: IVF partner user signup
    And I choose "In Vitro Fertilization (IVF)" status for fertility treatment
    And I complete Fertility Treatment onboarding step 2
    And I complete Fertility Treatment onboarding step 3
    And I fill in email name password and birthday
    And I finish the tutorial
    Then I should see "Complete log"
    And I open "Me" page
    And I invite my male partner
    And I logout

    And I login as the partner
    And I finish the tutorial
    Then I should see "Complete log"
    And I logout

