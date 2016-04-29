@not_ready
Feature: A la carte purchase flow.
  Scenario: Free user clicks alc stickers and go to alc purchase flow.
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
    Then I check the price on sticker gating dialog
    Then I try to go through the ALC payment flow
    And I go back to previous page
    And I logout