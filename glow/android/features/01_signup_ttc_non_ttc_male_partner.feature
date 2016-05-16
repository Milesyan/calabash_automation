@signup @partner_signup @regression @all
Feature: Female invites male partner and signup
  @non_ttc_partner
  Scenario: Non-TTC female user invites her male partner
    Given I create a new "Non-TTC" glow user
    And I login
    And I close the premium popup
    Then I see "Complete log"
    And I open "Me" page
    And I invite my male partner
    And I logout

    When I login as the partner
    And I close the premium popup
    And I finish the tutorial
    Then I see "Complete log"
    And I logout

  @ttc_partner
  Scenario: TTC female user invites her male partner
    Given I create a new "TTC" glow user
    And I login
    And I close the premium popup
    Then I see "Complete log"
    And I open "Me" page
    And I invite my male partner
    And I logout

    When I login as the partner
    And I close the premium popup
    And I finish the tutorial
    Then I see "Complete log"
    And I logout

