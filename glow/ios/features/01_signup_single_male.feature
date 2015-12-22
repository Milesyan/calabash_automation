@signup @single_male_signup @regression
Feature: Male signup
  Scenario: Single male user signup
    Given I am a new "Single Male" user
    And I open Glow for the first time
    And I touch "Get Started!" button
    When I sign up as a single male user
    And I finish the tutorial
    Then I wait until I see "Complete log!"
    And I logout