@not_ready
Feature: Free can post recent stickers
  Scenario: Free user cannot post alc or premium packs.
    Given I create a new forum user with name "Miles"
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    And I click create post button and enter some text
    When I click add sticker button
    Then I should see the recent stickers section
    And I click to add a sticker into the topic
    And I go back to previous page
    And I logout

  Scenario: Alc or premium stickers expires and check recent stickers tab.