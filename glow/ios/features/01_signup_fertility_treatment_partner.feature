@ft_partner_signup @regression
Feature: Fertility Treatments
  @ft_prep_partner
  Scenario: Preparing for treatment
    Given I create a new "Prep" glow user
    And I login
    And I open "Me" page
    And I invite my male partner
    And I logout
    And I login as the partner
    And I finish the tutorial
    Then I wait until I see "Complete log!"
    And I logout

  @ft_med_partner
  Scenario: Med pargner signs up
    Given I create a new "Med" glow user
    And I login
    And I open "Me" page
    And I invite my male partner
    And I logout

    And I login as the partner
    And I finish the tutorial
    Then I wait until I see "Complete log!"
    And I logout

  @ft_iui_partner
  Scenario: IUI partner signs up
    Given I create a new "IUI" glow user
    And I login
    And I open "Me" page
    And I invite my male partner
    And I logout

    And I login as the partner
    And I finish the tutorial
    Then I wait until I see "Complete log!"
    And I logout

  @ft_ivf_partner
  Scenario: IVF partner signs up
    Given I create a new "IVF" glow user
    And I login
    And I open "Me" page
    And I invite my male partner
    And I logout

    And I login as the partner
    And I finish the tutorial
    Then I wait until I see "Complete log!"
    And I logout

