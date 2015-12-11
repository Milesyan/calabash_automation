@ft_partner_signup @signup @regression @all
Feature: Fertility Treatments user signup
  @ft_prep_partner
  Scenario: Preparing for treatment partner user signup
    Given I am a new "Prep" user
    And I open Glow for the first time
    And I touch the "Sign up" button
    And I select the user type "Fertility treatments"

    And I choose "Preparing for treatment" status for fertility treatment
    And I complete Fertility Treatment onboarding step 2
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
    Given I am a new "Med" user
    And I open Glow for the first time
    And I touch the "Sign up" button
    And I select the user type "Fertility treatments"

    And I choose "Intercourse with fertility medication" status for fertility treatment
    And I complete Fertility Treatment onboarding step 2
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
    Given I am a new "IUI" user
    And I open Glow for the first time
    And I touch the "Sign up" button
    And I select the user type "Fertility treatments"

    And I choose "Intrauterine Insemination (IUI)" status for fertility treatment
    And I complete Fertility Treatment onboarding step 2
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
    Given I am a new "IVF" user
    And I open Glow for the first time
    And I touch the "Sign up" button
    And I select the user type "Fertility treatments"

    And I choose "In Vitro Fertilization (IVF)" status for fertility treatment
    And I complete Fertility Treatment onboarding step 2
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

