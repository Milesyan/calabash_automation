@partner @regression
Feature: Partner Signup
  @non_ttc_partner
  Scenario: female Non-TTC user invites her male partner
    Given I create a new "Non-TTC" glow user
    And I login
    And I open "me" page
    And I invite my male partner
    And I logout

    And I login as the partner
    And I finish the tutorial
    Then I wait until I see "Complete log!"
    And I logout

  @ttc_partner
  Scenario: female TTC user invites her male partner
    Given I create a new "TTC" glow user
    And I login
    And I open "me" page
    And I invite my male partner
    And I logout

    And I login as the partner
    And I finish the tutorial
    Then I wait until I see "Complete log!"
    And I logout