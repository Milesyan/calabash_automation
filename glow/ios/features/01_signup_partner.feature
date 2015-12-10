@partner @regression
Feature: Partner Signup
  @non_ttc_partner
  Scenario: female Non-TTC user invites her male partner
    # Given I am a new "Non-TTC" user
    # And I open Glow for the first time
    # And I touch "Get Started!" button
    # And I select the user type "Avoiding pregnancy"
    # And I complete Non-TTC onboarding step 1
    # And I complete Non-TTC onboarding step 2
    # And I fill in email name password and birthday
    # And I finish the tutorial
    # Then I should see "Complete log!"
    Given I create a new "Non-TTC" user
    And I login
    And I open "me" page
    And I invite my male partner
    And I logout

    And I login as the partner
    And I finish the tutorial
    Then I should see "Complete log!"
    And I logout

  @ttc_partner
  Scenario: female TTC user invites her male partner
    # Given I am a new "TTC" user
    # And I open Glow for the first time
    # And I touch "Get Started!" button
    # And I select the user type "Trying to conceive"
    # And I complete TTC onboarding step 1
    # And I complete TTC onboarding step 2
    # And I fill in email name password and birthday
    # And I finish the tutorial
    # Then I should see "Complete log!"
    Given I create a new "TTC" user
    And I login
    And I open "me" page
    And I invite my male partner
    And I logout

    And I login as the partner
    And I finish the tutorial
    Then I should see "Complete log!"
    And I logout