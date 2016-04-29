@not_ready
Feature: When A free user clicks a free pack, alc user clicks an owned alc pack, or a premium user clicks any pack. The stickers should show checked status and no prompt.

  Scenario: Free user clicks a free pack.
    Given a free user created a topic and add comments with stickers
    And I create a new forum user with name "Nadal"
    And I login as the new user "Nadal" created through www
    And I open "community" page
    And I go to the first group
    And I enter the topic "Test click owned free pack"
    When I click the free pack 
    Then I should not see any dialog prompt
    And I go back to previous page
    And I logout

  Scenario: Alc user clicks an owned pack.
    Given an alc user created a topic and add comments with alc stickers
    And I create another alc user with name "Federer"
    And I login as the new user "Federer" created through www
    And I open "community" page
    And I go to the first group
    And I enter the topic "Test click owned alc pack"
    When I click the alc pack 
    Then I should not see any dialog prompt
    And I go back to previous page
    And I logout

  Scenario: Premium user clicks an owned pack.
    Given a premium user created a topic and add comments with alc stickers
    And I create another alc user with name "Federer"
    And I login as the new user "Federer" created through www
    And I open "community" page
    And I go to the first group
    And I enter the topic "Test click owned premium pack"
    When I click the premium pack 
    Then I should not see any dialog prompt
    And I go back to previous page
    And I logout

 
