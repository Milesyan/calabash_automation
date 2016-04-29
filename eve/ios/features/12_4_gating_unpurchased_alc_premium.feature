@not_ready
Feature: Sticker gating when users click stickers not owned by them
  Scenario: Free user clicks premium stickers in topics
    Given A premium user milesp and a non-premium user milesn have been created for test
    And premium user create a topic and a comment with premium stickers
    And I login as the non-premium user
    And I open "community" page
    And I go to the first group
    And I open the topic "Test premium sticker gating"
    When I click the sticker in topic
    Then I should see the premium sticker gating page
    And I click close sticker gating dialog
    When I click the sticker in comment
    Then I should see the prompt premium dialog
    And I click close sticker gating dialog
    And I go back to previous page
    And I logout

  Scenario: Free user clicks alc stickers
    Given A user had bought all alc stickers has been created
    And the alc user create a topic and comment with alc stickers
    And I create a new forum user with name "Miles"
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    And I enter the topic "Test alc stickers"
    When I click the sticker in topic
    Then I should see the alc sticker gating page
    And I click close sticker gating dialog
    When I click the sticker in comment
    Then I should see the alc sticker gating page
    And I click close sticker gating dialog
    And I go back to previous page
    And I logout

  