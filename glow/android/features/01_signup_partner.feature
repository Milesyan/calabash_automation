@signup @partner_signup @regression @all
Feature: Partner signup
  @non_ttc_partner
  Scenario: female Non-TTC user invites her male partner
    Given I am a new "Non-TTC" user
    And I open Glow for the first time
    And I touch the "Get Started!" button
    And I select the user type "Avoiding pregnancy"
    And I complete Non-TTC onboarding step 1
    And I complete Non-TTC onboarding step 2
    And I fill in email name password and birthday
    And I close the onboarding popup
    And I finish the tutorial
    Then I see "Complete log"
    And I open "Me" page
    And I invite my male partner
    And I logout

    When I login as the partner
    And I finish the tutorial
    Then I see "Complete log"
    And I logout

  @ttc_partner
  Scenario: TTC female user invites her male partner
    Given I am a new "TTC" user
    And I open Glow for the first time
    And I touch the "Get Started!" button
    And I select the user type "Trying to conceive"
    And I complete TTC onboarding step 1
    And I complete TTC onboarding step 2
    And I fill in email name password and birthday
    And I close the onboarding popup
    And I finish the tutorial
    Then I see "Complete log"
    And I open "Me" page
    And I invite my male partner
    And I logout

    When I login as the partner
    And I finish the tutorial
    Then I see "Complete log"
    And I logout

