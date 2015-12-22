@forum
Feature: Community
  @poll_topic
  Scenario: Post a poll
    Given I create a new "Non-TTC" glow user
    And I login
    And I open "community" page
    And I post a "poll" topic
    And I logout

  @text_topic
  Scenario: Post a text topic
    Given I create a new "Non-TTC" glow user
    And I login
    And I open "community" page
    And I post a "text" topic
    And I logout

  @link_topic
  Scenario: Post a link topic
    Given I create a new "Non-TTC" glow user
    And I login
    And I open "community" page
    And I post a "link" topic
    And I logout