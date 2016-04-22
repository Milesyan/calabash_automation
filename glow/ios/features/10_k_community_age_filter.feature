@forum @age_filter
Feature: Age filter for topic and comments
  @filter_topic @restart
  Scenario: Test age filter for topics
    Given a forum user with the age 18 and create a topic in test group
    Given I create a new forum user with name "Miles"
    And I login as the new user "Miles" created through www
    And I open "community" page
    Then I go to test group and check the topic exists
    And I go to age filter and choose the 3rd choice
    When I scroll up the screen with strong force
    And I go to test group and check the topic not exist
    And I logout
  @filter_comment
  Scenario: Test age filter for comments and subreplies
    Given a forum user with the age 18 and create a topic in test group and some test comments and subreplies are created
    Given I create a new forum user with name "Miles"
    And I login as the new user "Miles" created through www
    And I open "community" page
    And I go to the first group
    And I open the topic "Test age filter comment"
    Then I check I can see the user's comment and subreply
    And I go back to previous page
    And I go to age filter and choose the 3rd choice
    And I open the topic "Test age filter comment"
    Then I check I can not see the user's comment and subreply
    And I go back to previous page
    And I go back to previous page
    And I logout
  