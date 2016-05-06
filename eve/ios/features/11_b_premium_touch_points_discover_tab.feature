@premium @discover_touch_points
Feature: Check touch points in discover tab.
  @discover_banner @restart
  Scenario: Check the premium banner under dicover page.
    Given A premium user and a non-premium user have been created for test
    And I login as non-premium user
    And I open "community" page 
    When I click the DISCOVER button in community tab
    Then I check the premium banner under discover tab
    And I logout

  @discover_chat_elements_premium
  Scenario: Check touch points elements under discover tab for premium users.
    Given A premium user and a non-premium user have been created for test
    And I login as premium user
    And I open "community" page 
    When I click the DISCOVER button in community tab
    Then I check the recommended people section and elements
    When I click chat button in recommended people section
    Then I can see a chat request is sent or premium prompt dialog
    And I logout

  @discover_chat_elements_free
  Scenario: Check touch points elements under discover tab for non-premium users.
    Given A premium user and a non-premium user have been created for test
    And I login as non-premium user
    And I open "community" page 
    When I click the DISCOVER button in community tab
    Then I check the recommended people section and elements
    When I click chat button in recommended people section
    Then I can see a chat request is sent or premium prompt dialog
    And I logout

  @discover_chat_see_all @p0
  Scenario: Check recommended people see all list.
    Given A premium user and a non-premium user have been created for test
    And I login as premium user
    And I open "community" page 
    When I click the DISCOVER button in community tab
    Then I check the recommended people section and elements
    When I click see all button in recommended people section
    Then I can see the list and check the elements
    When I click chat button in recommended people list
    Then I can see a chat request is sent or premium prompt dialog
    And I logout
