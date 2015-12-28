Feature: partner signup
  @partner
  Scenario: partner signs up
    Given I register a new pregnant user
    And I open "Me" tab
    And I invite a partner
    And I logout
    And I sign up as a partner
    And I logout