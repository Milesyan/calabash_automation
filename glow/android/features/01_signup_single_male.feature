@signup @single_male_signup @regression @all
Feature: Single male signup
  Scenario: Single male user signup
    Given I am a new "Single Male" user
    And I open Glow for the first time
    When I sign up as a single male user
    And I finish the tutorial
    Then I should see "Complete log"
    And I logout