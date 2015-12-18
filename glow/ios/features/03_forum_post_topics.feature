@forum_old
Feature: Community
  @poll_topic
  Scenario: Post a poll
    Given I register a new "Non-TTC" user
    And I open "community" page
    And I post a "poll" topic
    And I logout

  @text_topic
  Scenario: Post a text topic
    Given I register a new "Non-TTC" user
    And I open "community" page
    And I post a "text" topic
    And I logout

  # @photo_topic
  # Scenario: Post a photo topic
  #   Given I register a new "Non-TTC" user
  #   And I open "community" page
  #   And I post a "photo" topic
  #   And I logout

  @link_topic
  Scenario: Post a link topic
    Given I register a new "Non-TTC" user
    And I open "community" page
    And I post a "link" topic
    And I logout