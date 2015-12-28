Feature: Nurture test
  @test
  Scenario: first nurture test
    Given I am a new user
    And I get started
    And I complete the onboard steps
    #Then I should see "Complete log"
    Then I close the insights popup
    And I finish the tutorial
    And I logout