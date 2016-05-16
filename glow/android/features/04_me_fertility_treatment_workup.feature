@me @fertility_tests @regression
Feature: Fertility treatment and workup
  @ttc_ft_tests
  Scenario: TTC user should be able to use fertility testing and workup
    Given I create a new "TTC" glow user
    And I complete my fertility testing via www
    And I login
    And I close the premium popup
    And I open "Me" page
    And I open and check my fertility testing and workup
    And I logout

  @prep_ft_tests
  Scenario: Prep user should be able to use fertility testing and workup
    Given I create a new "Prep" glow user
    And I complete my fertility testing via www
    And I login
    And I close the premium popup
    And I open "Me" page
    And I open and check my fertility testing and workup
    And I logout

  @non_ttc_ft_tests
  Scenario: Non-TTC user should not see fertility testing and workup
    Given I create a new "Non-TTC" glow user
    And I login
    And I close the premium popup
    And I open "Me" page
    Then I should not see "Fertility testing and workup"
    And I logout

  @ttc_male_partner_ft_tests
  Scenario: TTC male partner should not see fertility testing and workup
    Given I create a new "TTC" "Male" glow partner user
    And I login
    And I close the premium popup
    And I open "Me" page
    Then I should not see "Fertility testing and workup"
    And I logout 

  @iui_male_partner_ft_tests
  Scenario: IUI male partner should not see fertility testing and workup
    Given I create a new "IUI" "Male" glow partner user
    And I login
    And I close the premium popup
    And I open "Me" page
    Then I should not see "Fertility testing and workup"
    And I logout

