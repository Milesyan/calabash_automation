@premium @anonymouse_signature
Feature: Check UI display when a premium user post a topic
  @anonymouse_signature
  Scenario: Check UI display when a premium user post a topic
    Given A premium user miles3 and a non-premium user milesn have been created for test
    And I login as premium user
    And I open "community" page
    And I go to the first group
    And I post a text topic with title "Post in group topic" anonymously
    And I enter the topic "Post in group topic" 
    Then I check the signature does not display
    And I go back to previous page
    And I logout