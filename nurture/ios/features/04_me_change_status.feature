@change_status
Feature: Change status
  @status_born
  Scenario: Baby is born
    Given I register a new pregnant user
    And I open "Me" tab
    And I touch "Baby's born" link
    And I fill in the info of the baby
    And I logout

  @healing_from_loss
  Scenario: Healing from loss
    Given I register a new pregnant user
    And I open "Me" tab
    And I touch "See all statuses" link
    And I switch to healing from loss status
    And I logout