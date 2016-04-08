@forum @floating_button
Feature: Check floating button display logic.
'''
1. show buttons by default
2. show buttons when scroll up
3. show buttons when reaching the bottom of the page
4. hide buttons when scroll down
5. hide buttons when stop scrolling (do not show when stopped)
'''

  Scenario: Check floating button show up logic
    Given I create a new forum user with name "Miles"
    And I login as the new user "Miles" created through www
    And I open "community" page
    When I go to the first group
    Then I should see the floating buttons for creating topics
    When I scroll down the screen
    Then I should not see the floating buttons for creating topics
    When I wait for the animation is finished
    Then I should not see the floating buttons for creating topics
    When I scroll up the screen
    Then I should see the floating buttons for createing topics
    And I logout