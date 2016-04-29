@not_ready
Feature: Free, alc, premium users can only post what then owned.
  Scenario: Free user cannot post alc or premium packs.
    Given I create a new forum user with name "Miles"
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    And I click create post button and enter some text
    When I click add sticker button
    Then I should see I can post free stickers only
    When I choose premium packs
    Then I should see the premium sticker gating page
    When I choose alc packs
    Then I should see the alc sticker gating page
    And I click to add a sticker into the topic
    And I go back to previous page
    And I logout

  Scenario: Alc user cannot post premium packs.
    Given A user had bought all alc stickers has been created
    And I login as the alc user
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    And I click create post button and enter some text
    When I click add sticker button
    Then I should see I can post free stickers and alc stickers only
    And I click to add a sticker into the topic
    And I go back to previous page
    And I logout

  Scenario: Premium users can post any stickers
    Given A premium user milesp and a non-premium user milesn have been created for test
    And I login as the premium user
    And I login as the premium user
    And I open "community" page
    And I go to the first group
    And I click create post button and enter some text
    When I click add sticker button
    Then I should see I can post all the stickers
    And I click to add a sticker into the topic
    And I go back to previous page
    And I logout