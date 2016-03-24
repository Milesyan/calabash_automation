@wip @discover_touch_points
Feature: Check touch points in discover tab.
  @discover_banner
  Scenario: Check the premium banner under dicover page.
    Given A premium user miles2 and a non-premium user milesn have been created for test
    And I login as premium user
    And I open "community" page 
    When I click the DISCOVER button in community tab
    Then I check the recommended people section and elements
    When I click chat button in recommended people section
    Then I can see a chat request is sent or premium prompt dialog
    And I logout

  @discover_chat_elements
  Scenario: Check touch points elements under discover tab.
    Given A premium user miles2 and a non-premium user milesn have been created for test
    And I login as premium user
    And I open "community" page 
    When I click the DISCOVER button in community tab
    Then I check the recommended people section and elements
    When I click chat button in recommended people section
    Then I can see a chat request is sent or premium prompt dialog
    And I logout

  @discover_chat_see_all
  Scenario: Check recommended people see all list.
    Given A premium user miles2 and a non-premium user milesn have been created for test
    And I login as premium user
    And I open "community" page 
    When I click the DISCOVER button in community tab
    Then I check the recommended people section and elements
    When I click see all button in recommended people section
    Then I can see the list and check the elements
    When I click chat button in recommended people list
    Then I can see a chat request is sent or premium prompt dialog
    And I logout
